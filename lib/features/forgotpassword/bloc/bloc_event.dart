abstract class ForgotPasswordEvent {}

class PasswordResetEvent extends ForgotPasswordEvent {
  final String email;

  PasswordResetEvent({required this.email});
}
