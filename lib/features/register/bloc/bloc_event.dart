abstract class RegisterEvent {}

class RegisterSuccessEvent extends RegisterEvent {
  String fullName;
  String email;
  String password;

  RegisterSuccessEvent({
    required this.fullName,
    required this.email,
    required this.password,
  });
}
