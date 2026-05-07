import 'package:fitness_planner_frontend/features/workout_plan/domain/repositories/workout_plan_repository.dart';

class CreatePlanUsecase {
  final WorkoutPlanRepository repository;

  CreatePlanUsecase(this.repository);

  Future<void> call({
    required String name,
    required String description,
    required List<String> exercises,
  }) {
    return repository.createPlan(
      name: name,
      description: description,
      exercises: exercises,
    );
  }
}
