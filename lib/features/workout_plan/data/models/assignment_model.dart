import '../../../exercises/data/models/exercise_model.dart';
import '../../domain/entities/assignment_entity.dart';

class AssignmentModel extends AssignmentEntity {
  const AssignmentModel({
    required super.id,
    required super.planId,
    required super.name,
    super.description,
    required super.status,
    required super.exercises,

    super.assignedByName,
    super.assignedAt,
  });

  factory AssignmentModel.fromJson(Map<String, dynamic> json) {
    return AssignmentModel(
      id: json['assignment_id'],
      planId: json['plan_id'],
      name: json['name'],
      description: json['description'],
      status: json['status'],

      assignedByName: json['assigned_by_name'],

      assignedAt: json['assigned_at'] != null
          ? DateTime.parse(json['assigned_at'])
          : null,

      exercises: (json['exercises'] as List? ?? [])
          .map((e) => ExerciseModel.fromJson(e))
          .toList(),
    );
  }
}
