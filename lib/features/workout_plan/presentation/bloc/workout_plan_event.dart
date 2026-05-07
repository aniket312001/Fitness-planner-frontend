abstract class WorkoutPlanEvent {}

class GetPlansEvent extends WorkoutPlanEvent {
  final int page;
  final int limit;
  final String? search;

  GetPlansEvent({this.page = 1, this.limit = 10, this.search});
}

class CreatePlanEvent extends WorkoutPlanEvent {
  final String name;
  final String description;
  final List<String> exercises;

  CreatePlanEvent({
    required this.name,
    required this.description,
    required this.exercises,
  });
}

class AssignPlanEvent extends WorkoutPlanEvent {
  final String planId;
  final List<String> clientIds;

  AssignPlanEvent({required this.planId, required this.clientIds});
}

class GetClientPlansEvent extends WorkoutPlanEvent {
  final int page;
  final int limit;
  final String? search;

  GetClientPlansEvent({this.page = 1, this.limit = 10, this.search});
}

class CompletePlanEvent extends WorkoutPlanEvent {
  final String assignmentId;

  CompletePlanEvent(this.assignmentId);
}
