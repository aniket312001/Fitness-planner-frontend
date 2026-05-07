import 'package:fitness_planner_frontend/features/workout_plan/data/models/assignment_model.dart';
import 'package:fitness_planner_frontend/features/workout_plan/data/models/plan_model.dart';
import 'package:fitness_planner_frontend/features/workout_plan/domain/entities/pagination_entity.dart';

import '../../domain/entities/assignment_entity.dart';
import '../../domain/entities/plan_entity.dart';
import '../../domain/repositories/workout_plan_repository.dart';
import '../datasource/workout_plan_remote_datasource.dart';

class WorkoutPlanRepositoryImpl implements WorkoutPlanRepository {
  final WorkoutPlanRemoteDatasource remote;

  WorkoutPlanRepositoryImpl(this.remote);

  @override
  Future<void> assignPlan({
    required String planId,
    required List<String> clientIds,
  }) {
    return remote.assignPlan(planId: planId, clientIds: clientIds);
  }

  @override
  Future<void> completePlan(String assignmentId) {
    return remote.completePlan(assignmentId);
  }

  @override
  Future<void> createPlan({
    required String name,
    required String description,
    required List<String> exercises,
  }) {
    return remote.createPlan(
      name: name,
      description: description,
      exercises: exercises,
    );
  }

  @override
  Future<PaginationEntity<AssignmentEntity>> getClientPlans({
    required int page,
    required int limit,
    String? search,
  }) async {
    final response = await remote.getClientPlans(
      page: page,
      limit: limit,
      search: search,
    );

    print("response['data' - ${response['data']}");

    return PaginationEntity<AssignmentEntity>(
      items: (response['data'] as List)
          .map((e) => AssignmentModel.fromJson(e))
          .toList(),
      total: response['total'],
      page: response['page'],
      limit: response['limit'],
    );
  }

  @override
  Future<PaginationEntity<PlanEntity>> getPlans({
    required int page,
    required int limit,
    String? search,
  }) async {
    final response = await remote.getPlans(
      page: page,
      limit: limit,
      search: search,
    );

    return PaginationEntity<PlanEntity>(
      items: (response['data'] as List)
          .map((e) => PlanModel.fromJson(e))
          .toList(),

      total: response['total'],
      page: response['page'],
      limit: response['limit'],
    );
  }
}
