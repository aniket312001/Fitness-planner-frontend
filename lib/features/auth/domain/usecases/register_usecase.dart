import '../entities/auth_entity.dart';
import '../repositories/auth_repository.dart';

class RegisterUsecase {
  final AuthRepository repository;

  RegisterUsecase(this.repository);

  Future<AuthEntity> call({
    required String name,
    required String email,
    required String password,
    required String role,
  }) {
    return repository.register(
      name: name,
      email: email,
      password: password,
      role: role,
    );
  }
}
