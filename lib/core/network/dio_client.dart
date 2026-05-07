import 'package:dio/dio.dart';
import 'package:fitness_planner_frontend/core/constants/constants_apis.dart';

import '../storage/token_storage.dart';

class DioClient {
  static final Dio dio =
      Dio(
          BaseOptions(
            baseUrl: AppConstantsApis.baseUrl,
            headers: {'Content-Type': 'application/json'},
          ),
        )
        ..interceptors.add(
          InterceptorsWrapper(
            onRequest: (options, handler) async {
              final token = await TokenStorage.getToken();

              if (token != null) {
                options.headers['Authorization'] = 'Bearer $token';
              }

              return handler.next(options);
            },
          ),
        );
}
