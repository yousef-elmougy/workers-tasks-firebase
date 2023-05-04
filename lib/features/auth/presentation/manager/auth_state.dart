part of 'auth_cubit.dart';

@immutable
abstract class AuthState {
  const AuthState();
}

class AuthInitial extends AuthState {
  const AuthInitial();
}

/// Pick Image
class PickImageSuccess extends AuthState {
  const PickImageSuccess();
}

class PickImageLoading extends AuthState {
  const PickImageLoading();
}

class PickImageError extends AuthState {
  final String error;

  const PickImageError(this.error);
}

/// Register
class RegisterLoading extends AuthState {
  const RegisterLoading();
}

class RegisterSuccess extends AuthState {
  const RegisterSuccess();
}

class RegisterError extends AuthState {
  final String error;
const RegisterError(this.error);
}
/// Login
class LoginLoading extends AuthState {
  const LoginLoading();
}

class LoginSuccess extends AuthState {
  const LoginSuccess();
}

class LoginError extends AuthState {
  final String error;
const LoginError(this.error);
}
