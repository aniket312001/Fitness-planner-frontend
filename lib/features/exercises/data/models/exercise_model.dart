import '../../domain/entities/exercise_entity.dart';

class ExerciseModel extends ExerciseEntity {
  ExerciseModel({required super.id, required super.name});

  factory ExerciseModel.fromJson(Map<String, dynamic> json) {
    return ExerciseModel(id: json['id'], name: json['name']);
  }
}
