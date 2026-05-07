import '../entities/auth_entity.dart';

abstract class AuthRepository {
  Future<AuthEntity> login({required String email, required String password});

  Future<AuthEntity> register({
    required String name,
    required String email,
    required String password,
    required String role,
  });
}
