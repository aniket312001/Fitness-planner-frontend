part of 'exercise_bloc.dart';

abstract class ExerciseEvent {}

class GetExercises extends ExerciseEvent {}

class CreateExercise extends ExerciseEvent {
  final String name;

  CreateExercise(this.name);
}
