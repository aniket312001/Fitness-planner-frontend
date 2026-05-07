import 'package:fitness_planner_frontend/features/exercises/data/datasource/exercise_remote_datasource.dart';

import '../../domain/entities/exercise_entity.dart';
import '../../domain/repositories/exercise_repository.dart';

class ExerciseRepositoryImpl implements ExerciseRepository {
  final ExerciseRemoteDatasource datasource;

  ExerciseRepositoryImpl(this.datasource);

  @override
  Future<List<ExerciseEntity>> getExercises() {
    return datasource.getExercises();
  }

  @override
  Future<ExerciseEntity> createExercise(String name) {
    return datasource.createExercise(name);
  }
}
