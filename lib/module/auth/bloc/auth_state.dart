abstract class AuthState {}

class AuthError extends AuthState {
  final String error;
  AuthError({required this.error});
}

class UsernameValid extends AuthState {}

class UsernameError extends AuthError {
  UsernameError({required String error}) : super(error: error);
}

class PasswordValid extends AuthState {}

class PasswordError extends AuthError {
  PasswordError({required String error}) : super(error: error);
}

class AuthInital extends AuthState {}

class AuthLoading extends AuthState {}

class LoginSucces extends AuthState {
  final bool isAdmin;
  LoginSucces({required this.isAdmin});
}

class LoginError extends AuthError {
  LoginError({required String error}) : super(error: error);
}

class SignUpSucces extends AuthState {}

class SignUpError extends AuthError {
  SignUpError({required String error}) : super(error: error);
}

class SendEmailSuccess extends AuthState {}

class SendEmailFaild extends AuthError {
  SendEmailFaild({required String error}) : super(error: error);
}
