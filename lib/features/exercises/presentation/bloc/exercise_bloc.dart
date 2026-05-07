import 'package:flutter_bloc/flutter_bloc.dart';

import '../../domain/entities/exercise_entity.dart';
import '../../domain/repositories/exercise_repository.dart';

part 'exercise_event.dart';
part 'exercise_state.dart';

class ExerciseBloc extends Bloc<ExerciseEvent, ExerciseState> {
  final ExerciseRepository repository;

  List<ExerciseEntity> exercises = [];

  ExerciseBloc({required this.repository}) : super(ExerciseInitial()) {
    on<GetExercises>(_getExercises);
    on<CreateExercise>(_createExercise);
  }

  Future<void> _getExercises(
    GetExercises event,
    Emitter<ExerciseState> emit,
  ) async {
    emit(ExerciseLoading());

    try {
      exercises = await repository.getExercises();

      emit(ExerciseLoaded(List.from(exercises)));
    } catch (e) {
      emit(ExerciseError(e.toString()));
    }
  }

  Future<void> _createExercise(
    CreateExercise event,
    Emitter<ExerciseState> emit,
  ) async {
    try {
      final newExercise = await repository.createExercise(event.name);

      exercises.insert(0, newExercise);

      emit(ExerciseCreated(List.from(exercises)));

      emit(ExerciseLoaded(List.from(exercises)));
    } catch (e) {
      emit(ExerciseError(e.toString()));
    }
  }
}
