abstract class AuthEvent {}

class UsernameChanged extends AuthEvent {
  final String username;

  UsernameChanged({required this.username});
}

class PasswordChanged extends AuthEvent {
  final String password;

  PasswordChanged({required this.password});
}

class LoginSubmitted extends AuthEvent{
  final String username;
  final String password;

  LoginSubmitted({
    required this.username,
    required this.password,
  });
}
class SignUpSubmitted extends AuthEvent{
  final String userName;
  final String fullName;
  final String email;
  final String phoneNumber;
  final String gender;
  final String password;
  final String confirmPassword;

  SignUpSubmitted({
    required this.userName,
    required this.fullName,
    required this.email,
    required this.phoneNumber,
    required this.gender,
    required this.password,
    required this.confirmPassword,
  });
}
class ForgotPasswordSubmitted extends AuthEvent{
  final String username;

  ForgotPasswordSubmitted({
    required this.username,
  });
}
class LogoutSubmitted extends AuthEvent{ }
