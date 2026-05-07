import 'package:fitness_planner_frontend/features/workout_plan/domain/repositories/workout_plan_repository.dart';

class AssignPlanUsecase {
  final WorkoutPlanRepository repository;

  AssignPlanUsecase(this.repository);

  Future<void> call({required String planId, required List<String> clientIds}) {
    return repository.assignPlan(planId: planId, clientIds: clientIds);
  }
}
