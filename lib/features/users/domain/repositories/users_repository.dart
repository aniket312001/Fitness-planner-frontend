import '../entities/user_entity.dart';

abstract class UsersRepository {
  Future<List<UserEntity>> getClients({
    required int page,
    required int limit,
    String search,
  });
}
