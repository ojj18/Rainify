import 'package:rainify/features/forgotpassword/data/provider/forgot_password_provider.dart';

abstract class IForgotPasswordRepositort {
  Future passwordResetMethod({required String email});
}

class ForgotPasswordRepository implements IForgotPasswordRepositort {
  ForgotPasswordProvider forgotPasswordProvider;

  ForgotPasswordRepository({required this.forgotPasswordProvider});

  @override
  Future<dynamic> passwordResetMethod({required String email}) {
    return forgotPasswordProvider.passwordResetMethod(email: email);
  }
}
