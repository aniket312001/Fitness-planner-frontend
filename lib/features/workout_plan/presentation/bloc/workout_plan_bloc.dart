import 'package:fitness_planner_frontend/features/workout_plan/domain/entities/assignment_entity.dart';
import 'package:fitness_planner_frontend/features/workout_plan/domain/entities/plan_entity.dart';
import 'package:fitness_planner_frontend/features/workout_plan/domain/usecases/assign_plan_usecase.dart';
import 'package:fitness_planner_frontend/features/workout_plan/domain/usecases/complete_plan_usecase.dart';
import 'package:fitness_planner_frontend/features/workout_plan/domain/usecases/create_plan_usecase.dart';
import 'package:fitness_planner_frontend/features/workout_plan/domain/usecases/get_client_plans_usecase.dart';
import 'package:fitness_planner_frontend/features/workout_plan/domain/usecases/get_plans_usecase.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../domain/repositories/workout_plan_repository.dart';

import 'workout_plan_event.dart';
import 'workout_plan_state.dart';

class WorkoutPlanBloc extends Bloc<WorkoutPlanEvent, WorkoutPlanState> {
  final GetPlansUsecase getPlansUsecase;
  final CreatePlanUsecase createPlanUsecase;
  final AssignPlanUsecase assignPlanUsecase;
  final GetClientPlansUsecase getClientPlansUsecase;
  final CompletePlanUsecase completePlanUsecase;

  List<PlanEntity> allPlans = [];
  int currentPage = 1;
  bool hasMore = true;
  bool isFetching = false;

  List<AssignmentEntity> allClientPlans = [];
  bool clientHasMore = true;
  bool clientFetching = false;

  WorkoutPlanBloc({
    required this.getClientPlansUsecase,
    required this.completePlanUsecase,
    required this.getPlansUsecase,
    required this.createPlanUsecase,
    required this.assignPlanUsecase,
  }) : super(WorkoutPlanInitial()) {
    on<GetPlansEvent>(_getPlans);
    on<CreatePlanEvent>(_createPlan);
    on<AssignPlanEvent>(_assignPlan);
    on<GetClientPlansEvent>(_getClientPlans);
    on<CompletePlanEvent>(_completePlan);
  }

  Future<void> _getPlans(
    GetPlansEvent event,
    Emitter<WorkoutPlanState> emit,
  ) async {
    if (isFetching) return;

    isFetching = true;

    try {
      if (event.page == 1) {
        allPlans.clear();

        emit(WorkoutPlanLoading());
      }

      final response = await getPlansUsecase(
        page: event.page,
        limit: event.limit,
        search: event.search,
      );

      allPlans.addAll(response.items);

      hasMore = allPlans.length < response.total;

      emit(WorkoutPlansLoaded(plans: allPlans, hasMore: hasMore));
    } catch (e) {
      print("error - ${e}");
      emit(WorkoutPlanFailure(e.toString()));
    }

    isFetching = false;
  }

  Future<void> _createPlan(
    CreatePlanEvent event,
    Emitter<WorkoutPlanState> emit,
  ) async {
    emit(WorkoutPlanLoading());

    try {
      await createPlanUsecase(
        name: event.name,
        description: event.description,
        exercises: event.exercises,
      );

      emit(WorkoutPlanSuccess());
    } catch (e) {
      print("Err- ${e}");
      emit(WorkoutPlanFailure(e.toString()));
    }
  }

  Future<void> _assignPlan(
    AssignPlanEvent event,
    Emitter<WorkoutPlanState> emit,
  ) async {
    emit(WorkoutPlanLoading());

    try {
      await assignPlanUsecase(planId: event.planId, clientIds: event.clientIds);

      emit(WorkoutPlanSuccess());
    } catch (e) {
      emit(WorkoutPlanFailure(e.toString()));
    }
  }

  Future<void> _getClientPlans(
    GetClientPlansEvent event,
    Emitter<WorkoutPlanState> emit,
  ) async {
    if (clientFetching) return;

    clientFetching = true;

    try {
      if (event.page == 1) {
        allClientPlans.clear();

        emit(WorkoutPlanLoading());
      }

      final response = await getClientPlansUsecase(
        page: event.page,
        limit: event.limit,
        search: event.search,
      );

      allClientPlans.addAll(response.items);

      clientHasMore = allClientPlans.length < response.total;

      emit(ClientPlansLoaded(plans: allClientPlans, hasMore: clientHasMore));
    } catch (e, s) {
      print("Err -r ${e} ${s}");
      emit(WorkoutPlanFailure(e.toString()));
    }

    clientFetching = false;
  }

  Future<void> _completePlan(
    CompletePlanEvent event,
    Emitter<WorkoutPlanState> emit,
  ) async {
    emit(WorkoutPlanLoading());

    try {
      await completePlanUsecase(event.assignmentId);

      emit(WorkoutPlanSuccess());
    } catch (e) {
      emit(WorkoutPlanFailure(e.toString()));
    }
  }
}
