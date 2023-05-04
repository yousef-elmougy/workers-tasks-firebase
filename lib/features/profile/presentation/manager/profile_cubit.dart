import '../../../../lib_exports.dart';

part 'profile_state.dart';

class ProfileCubit extends Cubit<ProfileState> {
  ProfileCubit(this.homeRepository) : super(const ProfileInitial());

  final ProfileRepository homeRepository;
  UserData user = const UserData();
  Uint8List? file;
  Future<void> pickedImage(ImageSource source) async {
    emit(const UpdateImageLoading());
    try {
      file = await pickImage(source);
      emit(const UpdateImageSuccess());
    } catch (e) {
      emit(UpdateImageError('Failed to pick image: $e'));
    }
  }

  Future<void> getUserProfile() async {
    emit(const GetUserProfileLoading());
    final user = await homeRepository.getUserProfile();
    user.fold((error) => emit(GetUserProfileError(error)), (user) {
      this.user = user;
      emit(const GetUserProfileSuccess());
    });
  }

  Future<void> updateUserProfile({
    required String name,
    required String phone,
  }) async {
    emit(const UpdateUserProfileLoading());

    final userData = await homeRepository.updateUserProfile(
      file: file,
      name: name,
      phone: phone,
      user: user,
    );
    userData.fold((error) => emit(UpdateUserProfileError(error)),
        (_) => emit(const UpdateUserProfileSuccess()));
  }

  Future<void> updateUserPassword({
    required String oldPassword,
    required String newPassword,
  }) async {
    emit(const UpdateUserPasswordLoading());
    final user = await homeRepository.updateUserPassword(
      oldPassword: oldPassword,
      newPassword: newPassword,
    );
    user.fold((error) => emit(UpdateUserPasswordError(error)),
        (_) => emit(const UpdateUserPasswordSuccess()));
  }

  Future<void> deleteUserProfile() async {
    emit(const DeleteUserProfileLoading());
    final user = await homeRepository.deleteUserProfile();
    user.fold((error) => emit(DeleteUserProfileError(error)),
        (_) => emit(const DeleteUserProfileSuccess()));
  }
}
