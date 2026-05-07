import '../../../../core/storage/token_storage.dart';
import '../../domain/entities/auth_entity.dart';
import '../../domain/repositories/auth_repository.dart';
import '../datasource/auth_remote_datasource.dart';

class AuthRepositoryImpl implements AuthRepository {
  final AuthRemoteDatasource datasource;

  AuthRepositoryImpl(this.datasource);

  @override
  Future<AuthEntity> login({
    required String email,
    required String password,
  }) async {
    final result = await datasource.login(email: email, password: password);

    await TokenStorage.saveToken(result.token);

    return result;
  }

  @override
  Future<AuthEntity> register({
    required String name,
    required String email,
    required String password,
    required String role,
  }) async {
    final result = await datasource.register(
      name: name,
      email: email,
      password: password,
      role: role,
    );

    await TokenStorage.saveToken(result.token);

    return result;
  }
}
