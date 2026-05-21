abstract class LoginEvent {}

class LoginSuccessEvent extends LoginEvent {
  final String email;
  final String password;
  LoginSuccessEvent({required this.email, required this.password});
}

class GoogleSignUpEvent extends LoginEvent {}

class AppleSignUpEvent extends LoginEvent {}
