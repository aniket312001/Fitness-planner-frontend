import 'package:equatable/equatable.dart';

import '../../../exercises/domain/entities/exercise_entity.dart';

class AssignmentEntity extends Equatable {
  final String id;
  final String planId;
  final String name;
  final String? description;
  final String status;
  final String? assignedByName;
  final DateTime? assignedAt;

  final List<ExerciseEntity> exercises;

  const AssignmentEntity({
    required this.id,
    required this.assignedAt,
    required this.assignedByName,
    required this.planId,
    required this.name,
    this.description,
    required this.status,
    required this.exercises,
  });

  @override
  List<Object?> get props => [
    id,
    planId,
    name,
    description,
    status,
    exercises,
    assignedByName,
    assignedAt,
  ];
}
