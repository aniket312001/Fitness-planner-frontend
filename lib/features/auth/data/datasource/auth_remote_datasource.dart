import 'package:dio/dio.dart';
import 'package:fitness_planner_frontend/core/constants/constants_apis.dart';
import '../../../../core/network/dio_client.dart';
import '../models/auth_response_model.dart';

class AuthRemoteDatasource {
  final Dio dio = DioClient.dio;

  Future<AuthResponseModel> login({
    required String email,
    required String password,
  }) async {
    final response = await dio.post(
      AppConstantsApis.login,
      data: {'email': email, 'password': password},
    );

    return AuthResponseModel.fromJson(response.data);
  }

  Future<AuthResponseModel> register({
    required String name,
    required String email,
    required String password,
    required String role,
  }) async {
    final response = await dio.post(
      AppConstantsApis.register,
      data: {'name': name, 'email': email, 'password': password, 'role': role},
    );

    return AuthResponseModel.fromJson(response.data['data']);
  }
}
