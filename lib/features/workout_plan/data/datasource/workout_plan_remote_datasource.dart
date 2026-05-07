import 'package:dio/dio.dart';
import 'package:fitness_planner_frontend/core/network/dio_client.dart';

import '../models/assignment_model.dart';
import '../models/plan_model.dart';

class WorkoutPlanRemoteDatasource {
  final Dio dio = DioClient.dio;

  WorkoutPlanRemoteDatasource();

  Future<Map<String, dynamic>> getPlans({
    required int page,
    required int limit,
    String? search,
  }) async {
    print("page- ${page} search- ${search}");
    final response = await dio.get(
      '/plans',
      queryParameters: {'page': page, 'limit': limit, 'search': search},
    );

    return response.data;
  }

  Future<void> createPlan({
    required String name,
    required String description,
    required List<String> exercises,
  }) async {
    await dio.post(
      '/plans',
      data: {'name': name, 'description': description, 'exercises': exercises},
    );
  }

  Future<void> assignPlan({
    required String planId,
    required List<String> clientIds,
  }) async {
    await dio.post(
      '/plans/assign',
      data: {'planId': planId, 'clientIds': clientIds},
    );
  }

  Future<Map<String, dynamic>> getClientPlans({
    required int page,
    required int limit,
    String? search,
  }) async {
    final response = await dio.get(
      '/plans/client/my-plans',
      queryParameters: {'page': page, 'limit': limit, 'search': search},
    );

    return response.data;
  }

  Future<void> completePlan(String assignmentId) async {
    await dio.post('/plans/complete', data: {'assignmentId': assignmentId});
  }
}
