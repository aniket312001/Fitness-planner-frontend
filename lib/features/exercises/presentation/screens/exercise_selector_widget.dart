import 'package:fitness_planner_frontend/core/di/injector.dart';
import 'package:fitness_planner_frontend/features/exercises/presentation/screens/add_exercise_dialog.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../bloc/exercise_bloc.dart';

class ExerciseSelectorWidget extends StatefulWidget {
  final Function(List<String>) onChanged;

  const ExerciseSelectorWidget({super.key, required this.onChanged});

  @override
  State<ExerciseSelectorWidget> createState() => _ExerciseSelectorWidgetState();
}

class _ExerciseSelectorWidgetState extends State<ExerciseSelectorWidget> {
  final selectedIds = <String>[];

  late final ExerciseBloc bloc;

  @override
  void initState() {
    super.initState();

    bloc = sl<ExerciseBloc>();

    bloc.add(GetExercises());
  }

  @override
  void dispose() {
    bloc.close();

    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider.value(
      value: bloc,

      child: BlocConsumer<ExerciseBloc, ExerciseState>(
        listener: (context, state) {},

        builder: (context, state) {
          List exercises = [];

          if (state is ExerciseLoaded) {
            exercises = state.exercises;
          }

          if (state is ExerciseCreated) {
            exercises = state.exercises;
          }

          if (state is ExerciseLoading) {
            return const Center(child: CircularProgressIndicator());
          }

          return Column(
            crossAxisAlignment: CrossAxisAlignment.start,

            children: [
              Wrap(
                spacing: 8,
                runSpacing: 8,

                children: exercises.map<Widget>((exercise) {
                  final isSelected = selectedIds.contains(exercise.id);

                  return FilterChip(
                    label: Text(exercise.name),

                    selected: isSelected,

                    onSelected: (_) {
                      setState(() {
                        if (isSelected) {
                          selectedIds.remove(exercise.id);
                        } else {
                          selectedIds.add(exercise.id);
                        }
                      });

                      widget.onChanged(selectedIds);
                    },
                  );
                }).toList(),
              ),

              const SizedBox(height: 12),

              ElevatedButton(
                onPressed: () {
                  showDialog(
                    context: context,

                    builder: (_) {
                      return BlocProvider.value(
                        value: bloc,
                        child: const AddExerciseDialog(),
                      );
                    },
                  );
                },

                child: const Text('Add Exercise'),
              ),
            ],
          );
        },
      ),
    );
  }
}
