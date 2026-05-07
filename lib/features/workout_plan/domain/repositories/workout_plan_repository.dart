import 'package:fitness_planner_frontend/features/workout_plan/domain/entities/pagination_entity.dart';

import '../entities/assignment_entity.dart';
import '../entities/plan_entity.dart';

abstract class WorkoutPlanRepository {
  Future<PaginationEntity<PlanEntity>> getPlans({
    required int page,
    required int limit,
    String? search,
  });

  Future<void> createPlan({
    required String name,
    required String description,
    required List<String> exercises,
  });

  Future<void> assignPlan({
    required String planId,
    required List<String> clientIds,
  });

  Future<PaginationEntity<AssignmentEntity>> getClientPlans({
    required int page,
    required int limit,
    String? search,
  });

  Future<void> completePlan(String assignmentId);
}
