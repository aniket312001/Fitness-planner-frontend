import '../repositories/workout_plan_repository.dart';

class CompletePlanUsecase {
  final WorkoutPlanRepository repository;

  CompletePlanUsecase(this.repository);

  Future<void> call(String assignmentId) {
    return repository.completePlan(assignmentId);
  }
}
