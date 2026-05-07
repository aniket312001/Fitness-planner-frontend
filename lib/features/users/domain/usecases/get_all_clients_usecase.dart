import '../entities/user_entity.dart';
import '../repositories/users_repository.dart';

class GetAllClientsUsecase {
  final UsersRepository repository;

  GetAllClientsUsecase(this.repository);

  Future<List<UserEntity>> call({
    required int page,
    required int limit,
    String search = '',
  }) {
    return repository.getClients(page: page, limit: limit, search: search);
  }
}
