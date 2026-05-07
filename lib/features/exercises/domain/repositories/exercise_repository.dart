import '../entities/exercise_entity.dart';

abstract class ExerciseRepository {
  Future<List<ExerciseEntity>> getExercises();

  Future<ExerciseEntity> createExercise(String name);
}
