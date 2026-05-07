import 'package:equatable/equatable.dart';

class ExerciseEntity extends Equatable {
  final String id;
  final String name;

  ExerciseEntity({required this.id, required this.name});

  @override
  // TODO: implement props
  List<Object?> get props => [id, name];
}
