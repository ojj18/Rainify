import 'package:rainify/features/register/data/provider/register_provider.dart';

abstract class IRegisterRepository {
  Future registerUser({
    required String fullName,
    required String email,
    required String password,
    required dynamic latitude,
    required dynamic longitude,
  });
}

class RegisterRepository implements IRegisterRepository {
  final RegisterProvider registerProvider;

  const RegisterRepository({required this.registerProvider});

  @override
  Future<dynamic> registerUser({
    required String fullName,
    required String email,
    required String password,
    required dynamic latitude,
    required dynamic longitude,
  }) {
    return registerProvider.registerFunction(
      fullName: fullName,
      email: email,
      password: password,
      latitude: latitude,
      longitude: longitude,
    );
  }
}
