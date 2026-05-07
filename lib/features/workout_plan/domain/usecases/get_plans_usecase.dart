import '../entities/plan_entity.dart';
import '../entities/pagination_entity.dart';
import '../repositories/workout_plan_repository.dart';

class GetPlansUsecase {
  final WorkoutPlanRepository repository;

  GetPlansUsecase(this.repository);

  Future<PaginationEntity<PlanEntity>> call({
    required int page,
    required int limit,
    String? search,
  }) {
    return repository.getPlans(page: page, limit: limit, search: search);
  }
}
