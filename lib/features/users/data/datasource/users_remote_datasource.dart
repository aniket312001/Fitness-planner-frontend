import 'package:dio/dio.dart';
import 'package:fitness_planner_frontend/core/network/dio_client.dart';

import '../models/user_model.dart';

class UsersRemoteDatasource {
  final Dio dio = DioClient.dio;

  UsersRemoteDatasource();

  Future<List<UserModel>> getClients({
    required int page,
    required int limit,
    String search = '',
  }) async {
    final response = await dio.get(
      '/users/clients',
      queryParameters: {'page': page, 'limit': limit, 'search': search},
    );

    return (response.data['data'] as List)
        .map((e) => UserModel.fromJson(e))
        .toList();
  }
}
