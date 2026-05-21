import 'package:rainify/features/login/data/provider/login_provider.dart';

abstract class IloginRepository {
  Future loginMethod({required String email, required String password});

  Future googleSignUpMethod({
    required double latitude,

    required double longitude,
  });

  Future appleSignUpMethod({
    required double latitude,

    required double longitude,
  });
}

class LoginRepository implements IloginRepository {
  LoginProvider loginProvider;

  LoginRepository({required this.loginProvider});

  @override
  Future<dynamic> loginMethod({
    required String email,
    required String password,
  }) {
    return loginProvider.loginMethod(email: email, password: password);
  }

  @override
  Future<dynamic> googleSignUpMethod({
    required double latitude,

    required double longitude,
  }) {
    return loginProvider.googleSignUpMethod(
      latitude: latitude,
      longitude: longitude,
    );
  }

  @override
  Future<dynamic> appleSignUpMethod({
    required double latitude,
    required double longitude,
  }) {
    return loginProvider.appleSignUpMethod(
      latitude: latitude,
      longitude: longitude,
    );
  }
}
