import '../../../exercises/data/models/exercise_model.dart';
import '../../domain/entities/plan_entity.dart';

class PlanModel extends PlanEntity {
  const PlanModel({
    required super.id,
    required super.name,
    super.description,
    required super.exercises,
  });

  factory PlanModel.fromJson(Map<String, dynamic> json) {
    return PlanModel(
      id: json['id'],
      name: json['name'],
      description: json['description'],

      exercises: (json['exercises'] as List? ?? [])
          .map((e) => ExerciseModel.fromJson(e))
          .toList(),
    );
  }
}
