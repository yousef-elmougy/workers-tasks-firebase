import '../../../../../lib_exports.dart';

part 'auth_state.dart';

class AuthCubit extends Cubit<AuthState> {
  AuthCubit(this.authRepository) : super(const AuthInitial());
  final AuthRepository authRepository;

  Uint8List? file;
  String? position;

  Future<void> pickedImage(ImageSource source) async {
    try {
      emit(const PickImageLoading());
      file = await pickImage(source);
      emit(const PickImageSuccess());
    } catch (e) {
      emit(PickImageError('Failed to pick image: $e'));
    }
  }

  Future<void> register({
    required String email,
    required String name,
    required String password,
    required String phone,
  }) async {
    if (isClosed) return;
    emit(const RegisterLoading());

    final register = await authRepository.register(
      email: email,
      name: name,
      password: password,
      phone: phone,
      position: position!,
      file: file,
    );
    register.fold((error) => emit(RegisterError(error)),
        (_) => emit(const RegisterSuccess()));
  }

  Future<void> login({
    required String email,
    required String password,
  }) async {
    emit(const LoginLoading());

    final login = await authRepository.login(
      email: email,
      password: password,
    );
    login.fold(
        (error) => emit(LoginError(error)), (_) => emit(const LoginSuccess()));
  }
}
