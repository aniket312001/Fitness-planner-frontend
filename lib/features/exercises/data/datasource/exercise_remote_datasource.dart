import 'package:dio/dio.dart';
import 'package:fitness_planner_frontend/features/exercises/domain/entities/exercise_entity.dart';

import '../../../../core/network/dio_client.dart';

import '../models/exercise_model.dart';

abstract class ExerciseRemoteDatasource {
  Future<List<ExerciseModel>> getExercises();

  Future<ExerciseModel> createExercise(String name);
}

class ExerciseRemoteDatasourceImpl implements ExerciseRemoteDatasource {
  final dio = DioClient.dio;

  @override
  Future<List<ExerciseModel>> getExercises() async {
    final response = await dio.get('/exercises');

    final List list = response.data['data'];

    return list.map((e) => ExerciseModel.fromJson(e)).toList();
  }

  @override
  Future<ExerciseModel> createExercise(String name) async {
    final response = await dio.post('/exercises', data: {'name': name});

    return ExerciseModel.fromJson(response.data['data']);
  }
}
