import '../../domain/entities/user_entity.dart';
import '../../domain/repositories/users_repository.dart';

import '../datasource/users_remote_datasource.dart';

class UsersRepositoryImpl implements UsersRepository {
  final UsersRemoteDatasource remote;

  UsersRepositoryImpl(this.remote);

  @override
  Future<List<UserEntity>> getClients({
    required int page,
    required int limit,
    String search = '',
  }) {
    return remote.getClients(page: page, limit: limit, search: search);
  }
}
