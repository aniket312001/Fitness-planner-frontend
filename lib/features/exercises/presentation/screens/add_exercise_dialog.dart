import 'package:fitness_planner_frontend/core/widgets/app_text_field.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../bloc/exercise_bloc.dart';

class AddExerciseDialog extends StatefulWidget {
  const AddExerciseDialog({super.key});

  @override
  State<AddExerciseDialog> createState() => _AddExerciseDialogState();
}

class _AddExerciseDialogState extends State<AddExerciseDialog> {
  final controller = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: const Text('Add Exercise'),

      content: AppTextField(
        controller: controller,
        hintText: 'Exercise Name',
        keyboardType: TextInputType.text,
        prefixIcon: const Icon(Icons.fitness_center),
      ),

      actions: [
        TextButton(
          onPressed: () {
            Navigator.pop(context);
          },
          child: const Text('Cancel'),
        ),

        ElevatedButton(
          onPressed: () {
            context.read<ExerciseBloc>().add(
              CreateExercise(controller.text.trim()),
            );

            Navigator.pop(context);
          },
          child: const Text('Add'),
        ),
      ],
    );
  }
}
