import 'package:fitness_planner_frontend/features/exercises/data/datasource/exercise_remote_datasource.dart';
import 'package:fitness_planner_frontend/features/exercises/data/repositories/exercise_repository_impl.dart';
import 'package:fitness_planner_frontend/features/exercises/domain/repositories/exercise_repository.dart';
import 'package:fitness_planner_frontend/features/exercises/presentation/bloc/exercise_bloc.dart';
import 'package:fitness_planner_frontend/features/users/data/datasource/users_remote_datasource.dart';
import 'package:fitness_planner_frontend/features/users/data/repositories/users_repository_impl.dart';
import 'package:fitness_planner_frontend/features/users/domain/repositories/users_repository.dart';
import 'package:fitness_planner_frontend/features/users/domain/usecases/get_all_clients_usecase.dart';
import 'package:fitness_planner_frontend/features/users/presentation/bloc/users_bloc.dart';
import 'package:fitness_planner_frontend/features/workout_plan/data/datasource/workout_plan_remote_datasource.dart';
import 'package:fitness_planner_frontend/features/workout_plan/data/repositories/workout_plan_repository_impl.dart';
import 'package:fitness_planner_frontend/features/workout_plan/domain/repositories/workout_plan_repository.dart';
import 'package:fitness_planner_frontend/features/workout_plan/domain/usecases/assign_plan_usecase.dart';
import 'package:fitness_planner_frontend/features/workout_plan/domain/usecases/complete_plan_usecase.dart';
import 'package:fitness_planner_frontend/features/workout_plan/domain/usecases/create_plan_usecase.dart';
import 'package:fitness_planner_frontend/features/workout_plan/domain/usecases/get_client_plans_usecase.dart';
import 'package:fitness_planner_frontend/features/workout_plan/domain/usecases/get_plans_usecase.dart';
import 'package:fitness_planner_frontend/features/workout_plan/presentation/bloc/workout_plan_bloc.dart';
import 'package:get_it/get_it.dart';

import '../../features/auth/data/datasource/auth_remote_datasource.dart';
import '../../features/auth/data/repositories/auth_repository_impl.dart';

import '../../features/auth/domain/repositories/auth_repository.dart';

import '../../features/auth/domain/usecases/login_usecase.dart';
import '../../features/auth/domain/usecases/register_usecase.dart';

import '../../features/auth/presentation/bloc/auth_bloc.dart';

final sl = GetIt.instance;

Future<void> initDependencies() async {
  // datasource
  sl.registerLazySingleton<AuthRemoteDatasource>(() => AuthRemoteDatasource());
  sl.registerLazySingleton<ExerciseRemoteDatasource>(
    () => ExerciseRemoteDatasourceImpl(),
  );
  sl.registerLazySingleton<UsersRemoteDatasource>(
    () => UsersRemoteDatasource(),
  );
  sl.registerLazySingleton<WorkoutPlanRemoteDatasource>(
    () => WorkoutPlanRemoteDatasource(),
  );

  // repository
  sl.registerLazySingleton<AuthRepository>(() => AuthRepositoryImpl(sl()));
  sl.registerLazySingleton<ExerciseRepository>(
    () => ExerciseRepositoryImpl(sl()),
  );
  sl.registerLazySingleton<UsersRepository>(() => UsersRepositoryImpl(sl()));
  sl.registerLazySingleton<WorkoutPlanRepository>(
    () => WorkoutPlanRepositoryImpl(sl()),
  );

  // usecases
  sl.registerLazySingleton(() => LoginUsecase(sl()));

  sl.registerLazySingleton(() => RegisterUsecase(sl()));
  sl.registerLazySingleton(() => GetAllClientsUsecase(sl()));
  sl.registerLazySingleton(() => AssignPlanUsecase(sl()));
  sl.registerLazySingleton(() => CompletePlanUsecase(sl()));
  sl.registerLazySingleton(() => CreatePlanUsecase(sl()));
  sl.registerLazySingleton(() => GetClientPlansUsecase(sl()));
  sl.registerLazySingleton(() => GetPlansUsecase(sl()));

  // bloc
  sl.registerFactory(() => AuthBloc(loginUsecase: sl(), registerUsecase: sl()));
  sl.registerFactory(() => ExerciseBloc(repository: sl()));
  sl.registerFactory(() => UsersBloc(getAllClientsUsecase: sl()));
  sl.registerFactory(
    () => WorkoutPlanBloc(
      assignPlanUsecase: sl(),
      completePlanUsecase: sl(),
      createPlanUsecase: sl(),
      getClientPlansUsecase: sl(),
      getPlansUsecase: sl(),
    ),
  );
}
