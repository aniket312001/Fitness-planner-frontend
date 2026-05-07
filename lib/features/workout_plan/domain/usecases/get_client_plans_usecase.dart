import '../entities/assignment_entity.dart';
import '../entities/pagination_entity.dart';
import '../repositories/workout_plan_repository.dart';

class GetClientPlansUsecase {
  final WorkoutPlanRepository repository;

  GetClientPlansUsecase(this.repository);

  Future<PaginationEntity<AssignmentEntity>> call({
    required int page,
    required int limit,
    String? search,
  }) {
    return repository.getClientPlans(page: page, limit: limit, search: search);
  }
}
