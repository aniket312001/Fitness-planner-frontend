part of 'exercise_bloc.dart';

abstract class ExerciseState {}

class ExerciseInitial extends ExerciseState {}

class ExerciseLoading extends ExerciseState {}

class ExerciseLoaded extends ExerciseState {
  final List<ExerciseEntity> exercises;

  ExerciseLoaded(this.exercises);
}

class ExerciseCreated extends ExerciseState {
  final List<ExerciseEntity> exercises;

  ExerciseCreated(this.exercises);
}

class ExerciseError extends ExerciseState {
  final String message;

  ExerciseError(this.message);
}
