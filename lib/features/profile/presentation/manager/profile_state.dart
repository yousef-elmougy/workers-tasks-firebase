part of 'profile_cubit.dart';

@immutable
abstract class ProfileState {
  const ProfileState();
}

class ProfileInitial extends ProfileState {
  const ProfileInitial();
}

/// GET USER PROFILE DATA
class GetUserProfileLoading extends ProfileState {
  const GetUserProfileLoading();
}

class GetUserProfileSuccess extends ProfileState {
  const GetUserProfileSuccess();
}

class GetUserProfileError extends ProfileState {
  final String error;

  const GetUserProfileError(this.error);
}

/// UPDATE USER PROFILE DATA
class UpdateUserProfileLoading extends ProfileState {
  const UpdateUserProfileLoading();
}

class UpdateUserProfileSuccess extends ProfileState {
  const UpdateUserProfileSuccess();
}

class UpdateUserProfileError extends ProfileState {
  final String error;

  const UpdateUserProfileError(this.error);
}

/// DELETE USER PROFILE DATA
class DeleteUserProfileLoading extends ProfileState {
  const DeleteUserProfileLoading();
}

class DeleteUserProfileSuccess extends ProfileState {
  const DeleteUserProfileSuccess();
}

class DeleteUserProfileError extends ProfileState {
  final String error;

  const DeleteUserProfileError(this.error);
}

/// UPDATE USER PASSWORD DATA
class UpdateUserPasswordLoading extends ProfileState {
  const UpdateUserPasswordLoading();
}

class UpdateUserPasswordSuccess extends ProfileState {
  const UpdateUserPasswordSuccess();
}

class UpdateUserPasswordError extends ProfileState {
  final String error;

  const UpdateUserPasswordError(this.error);
}

/// Pick Image
class UpdateImageSuccess extends ProfileState {
  const UpdateImageSuccess();
}

class UpdateImageLoading extends ProfileState {
  const UpdateImageLoading();
}

class UpdateImageError extends ProfileState {
  final String error;

  const UpdateImageError(this.error);
}
