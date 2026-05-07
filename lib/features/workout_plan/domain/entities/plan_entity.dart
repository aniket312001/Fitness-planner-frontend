import 'package:equatable/equatable.dart';

import '../../../exercises/domain/entities/exercise_entity.dart';

class PlanEntity extends Equatable {
  final String id;
  final String name;
  final String? description;

  final List<ExerciseEntity> exercises;

  const PlanEntity({
    required this.id,
    required this.name,
    this.description,
    required this.exercises,
  });

  @override
  List<Object?> get props => [id, name, description, exercises];
}
