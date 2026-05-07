import 'package:fitness_planner_frontend/core/widgets/app_text_field.dart';
import 'package:fitness_planner_frontend/features/exercises/presentation/screens/exercise_selector_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../bloc/workout_plan_bloc.dart';
import '../bloc/workout_plan_event.dart';
import '../bloc/workout_plan_state.dart';

class CreatePlanScreen extends StatefulWidget {
  const CreatePlanScreen({super.key});

  @override
  State<CreatePlanScreen> createState() => _CreatePlanScreenState();
}

class _CreatePlanScreenState extends State<CreatePlanScreen> {
  final nameController = TextEditingController();

  final descriptionController = TextEditingController();

  final formKey = GlobalKey<FormState>();

  List<String> selectedExercises = [];

  @override
  void dispose() {
    nameController.dispose();
    descriptionController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: BlocConsumer<WorkoutPlanBloc, WorkoutPlanState>(
        listener: (context, state) {
          if (state is WorkoutPlanSuccess) {
            ScaffoldMessenger.of(context).showSnackBar(
              const SnackBar(
                content: Text('Workout Plan Created Successfully'),
              ),
            );

            Navigator.pop(context, true);
          }

          if (state is WorkoutPlanFailure) {
            ScaffoldMessenger.of(
              context,
            ).showSnackBar(SnackBar(content: Text(state.message)));
          }
        },

        builder: (context, state) {
          return Container(
            decoration: const BoxDecoration(
              gradient: LinearGradient(
                colors: [
                  Color(0xff0f172a),
                  Color(0xff1e293b),
                  Color(0xff334155),
                ],
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
              ),
            ),

            child: SafeArea(
              child: SingleChildScrollView(
                padding: const EdgeInsets.all(20),

                child: Form(
                  key: formKey,

                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,

                    children: [
                      Row(
                        children: [
                          InkWell(
                            onTap: () {
                              Navigator.pop(context);
                            },

                            borderRadius: BorderRadius.circular(12),

                            child: Container(
                              padding: const EdgeInsets.all(10),

                              decoration: BoxDecoration(
                                color: Colors.white.withOpacity(0.15),
                                borderRadius: BorderRadius.circular(12),
                              ),

                              child: const Icon(
                                Icons.arrow_back_ios_new,
                                color: Colors.white,
                                size: 20,
                              ),
                            ),
                          ),

                          const SizedBox(width: 16),

                          const Expanded(
                            child: Text(
                              'Create Workout Plan',
                              style: TextStyle(
                                fontSize: 28,
                                fontWeight: FontWeight.bold,
                                color: Colors.white,
                              ),
                            ),
                          ),
                        ],
                      ),

                      const SizedBox(height: 10),

                      Text(
                        'Design a personalized workout plan for your clients',
                        style: TextStyle(
                          fontSize: 15,
                          color: Colors.white.withOpacity(0.8),
                        ),
                      ),

                      const SizedBox(height: 30),

                      Container(
                        padding: const EdgeInsets.all(24),

                        decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(28),

                          boxShadow: [
                            BoxShadow(
                              color: Colors.black.withOpacity(0.12),
                              blurRadius: 20,
                              offset: const Offset(0, 10),
                            ),
                          ],
                        ),

                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,

                          children: [
                            Center(
                              child: Container(
                                height: 90,
                                width: 90,

                                decoration: BoxDecoration(
                                  color: Colors.blue.shade50,
                                  shape: BoxShape.circle,
                                ),

                                child: Icon(
                                  Icons.fitness_center,
                                  size: 45,
                                  color: Colors.blue.shade700,
                                ),
                              ),
                            ),

                            const SizedBox(height: 24),

                            const Center(
                              child: Text(
                                'Workout Details',
                                style: TextStyle(
                                  fontSize: 24,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                            ),

                            const SizedBox(height: 30),

                            AppTextField(
                              controller: nameController,
                              hintText: 'Workout Plan Name',
                              prefixIcon: const Icon(Icons.fitness_center),

                              validator: (value) {
                                if (value == null || value.trim().isEmpty) {
                                  return 'Plan name is required';
                                }

                                if (value.trim().length < 3) {
                                  return 'Plan name must be at least 3 characters';
                                }

                                return null;
                              },
                            ),

                            const SizedBox(height: 20),

                            AppTextField(
                              controller: descriptionController,
                              hintText: 'Describe this workout plan...',
                              maxLines: 5,
                              prefixIcon: const Padding(
                                padding: EdgeInsets.only(bottom: 80),
                                child: Icon(Icons.description),
                              ),

                              validator: (value) {
                                if (value == null || value.trim().isEmpty) {
                                  return 'Description is required';
                                }

                                if (value.trim().length < 10) {
                                  return 'Description should be more detailed';
                                }

                                return null;
                              },
                            ),

                            const SizedBox(height: 28),

                            Container(
                              padding: const EdgeInsets.all(18),

                              decoration: BoxDecoration(
                                color: Colors.grey.shade100,
                                borderRadius: BorderRadius.circular(20),
                              ),

                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,

                                children: [
                                  Row(
                                    children: [
                                      Icon(
                                        Icons.list_alt,
                                        color: Colors.blue.shade700,
                                      ),

                                      const SizedBox(width: 10),

                                      const Text(
                                        'Select Exercises',
                                        style: TextStyle(
                                          fontSize: 18,
                                          fontWeight: FontWeight.bold,
                                        ),
                                      ),
                                    ],
                                  ),

                                  const SizedBox(height: 18),

                                  ExerciseSelectorWidget(
                                    onChanged: (ids) {
                                      selectedExercises = ids;
                                    },
                                  ),
                                ],
                              ),
                            ),

                            const SizedBox(height: 32),

                            SizedBox(
                              width: double.infinity,
                              height: 58,

                              child: ElevatedButton(
                                style: ElevatedButton.styleFrom(
                                  backgroundColor: Colors.blue.shade700,

                                  shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(18),
                                  ),
                                ),

                                onPressed: state is WorkoutPlanLoading
                                    ? null
                                    : () {
                                        if (!formKey.currentState!.validate()) {
                                          return;
                                        }

                                        if (selectedExercises.isEmpty) {
                                          ScaffoldMessenger.of(
                                            context,
                                          ).showSnackBar(
                                            const SnackBar(
                                              content: Text(
                                                'Please select at least one exercise',
                                              ),
                                            ),
                                          );

                                          return;
                                        }

                                        context.read<WorkoutPlanBloc>().add(
                                          CreatePlanEvent(
                                            name: nameController.text.trim(),
                                            description: descriptionController
                                                .text
                                                .trim(),
                                            exercises: selectedExercises,
                                          ),
                                        );
                                      },

                                child: state is WorkoutPlanLoading
                                    ? const CircularProgressIndicator(
                                        color: Colors.white,
                                      )
                                    : const Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.center,

                                        children: [
                                          Icon(
                                            Icons.add_circle_outline,
                                            color: Colors.white,
                                          ),

                                          SizedBox(width: 10),

                                          Text(
                                            'Create Plan',
                                            style: TextStyle(
                                              fontSize: 18,
                                              fontWeight: FontWeight.bold,
                                              color: Colors.white,
                                            ),
                                          ),
                                        ],
                                      ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}
