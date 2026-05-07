import '../../domain/entities/assignment_entity.dart';
import '../../domain/entities/plan_entity.dart';

abstract class WorkoutPlanState {}

class WorkoutPlanInitial extends WorkoutPlanState {}

class WorkoutPlanLoading extends WorkoutPlanState {}

class WorkoutPlanSuccess extends WorkoutPlanState {}

class WorkoutPlansLoaded extends WorkoutPlanState {
  final List<PlanEntity> plans;
  final bool hasMore;

  WorkoutPlansLoaded({required this.plans, required this.hasMore});
}

class ClientPlansLoaded extends WorkoutPlanState {
  final List<AssignmentEntity> plans;
  final bool hasMore;

  ClientPlansLoaded({required this.plans, required this.hasMore});
}

class WorkoutPlanFailure extends WorkoutPlanState {
  final String message;

  WorkoutPlanFailure(this.message);
}
