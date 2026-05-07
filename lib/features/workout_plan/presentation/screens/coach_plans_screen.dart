import 'package:fitness_planner_frontend/core/di/injector.dart';
import 'package:fitness_planner_frontend/core/widgets/app_text_field.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../bloc/workout_plan_bloc.dart';
import '../bloc/workout_plan_event.dart';
import '../bloc/workout_plan_state.dart';

import '../../../users/presentation/screens/assign_plan_screen.dart';

import 'create_plan_screen.dart';
import 'plan_details_screen.dart';

class CoachPlansScreen extends StatefulWidget {
  const CoachPlansScreen({super.key});

  @override
  State<CoachPlansScreen> createState() => _CoachPlansScreenState();
}

class _CoachPlansScreenState extends State<CoachPlansScreen> {
  final scrollController = ScrollController();

  final searchController = TextEditingController();

  late final WorkoutPlanBloc bloc;

  int page = 1;

  @override
  void initState() {
    super.initState();

    bloc = sl<WorkoutPlanBloc>();

    bloc.add(GetPlansEvent(page: 1));

    scrollController.addListener(_onScroll);
  }

  void _onScroll() {
    if (scrollController.position.pixels >=
        scrollController.position.maxScrollExtent - 200) {
      if (bloc.hasMore && !bloc.isFetching) {
        page++;

        bloc.add(
          GetPlansEvent(page: page, search: searchController.text.trim()),
        );
      }
    }
  }

  @override
  void dispose() {
    scrollController.dispose();
    searchController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider.value(
      value: bloc,

      child: Scaffold(
        backgroundColor: const Color(0xfff8fafc),

        appBar: AppBar(
          elevation: 0,
          backgroundColor: Colors.white,
          centerTitle: true,

          title: const Text(
            'Workout Plans',
            style: TextStyle(color: Colors.black, fontWeight: FontWeight.bold),
          ),
        ),

        floatingActionButton: FloatingActionButton.extended(
          backgroundColor: Colors.blue.shade700,

          onPressed: () async {
            var result = await Navigator.push(
              context,
              MaterialPageRoute(
                builder: (_) => BlocProvider.value(
                  value: bloc,
                  child: const CreatePlanScreen(),
                ),
              ),
            );

            if (result == true) {
              page = 1;

              bloc.add(GetPlansEvent(page: 1));
            }
          },

          icon: const Icon(Icons.add, color: Colors.white),

          label: const Text(
            'Create',
            style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
          ),
        ),

        body: Column(
          children: [
            Padding(
              padding: const EdgeInsets.all(16),

              child: AppTextField(
                controller: searchController,
                hintText: 'Search workout plans',
                prefixIcon: const Icon(Icons.search),

                onChanged: (value) {
                  page = 1;

                  bloc.add(GetPlansEvent(page: 1, search: value.trim()));
                },
              ),
            ),

            Expanded(
              child: BlocBuilder<WorkoutPlanBloc, WorkoutPlanState>(
                builder: (context, state) {
                  if (state is WorkoutPlanLoading && page == 1) {
                    return const Center(child: CircularProgressIndicator());
                  }

                  if (state is WorkoutPlansLoaded) {
                    if (state.plans.isEmpty) {
                      return const Center(
                        child: Text(
                          'No Plans Found',
                          style: TextStyle(
                            fontSize: 18,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      );
                    }

                    return ListView.builder(
                      controller: scrollController,

                      padding: const EdgeInsets.only(
                        left: 16,
                        right: 16,
                        bottom: 100,
                      ),

                      itemCount: state.hasMore
                          ? state.plans.length + 1
                          : state.plans.length,

                      itemBuilder: (context, index) {
                        if (index >= state.plans.length) {
                          return const Padding(
                            padding: EdgeInsets.all(16),

                            child: Center(child: CircularProgressIndicator()),
                          );
                        }

                        final plan = state.plans[index];

                        return GestureDetector(
                          onTap: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (_) => PlanDetailsScreen(plan: plan),
                              ),
                            );
                          },

                          child: Container(
                            margin: const EdgeInsets.only(bottom: 18),

                            decoration: BoxDecoration(
                              color: Colors.white,
                              borderRadius: BorderRadius.circular(28),

                              boxShadow: [
                                BoxShadow(
                                  color: Colors.black.withOpacity(0.06),
                                  blurRadius: 14,
                                  offset: const Offset(0, 8),
                                ),
                              ],
                            ),

                            child: Padding(
                              padding: const EdgeInsets.all(20),

                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,

                                children: [
                                  Row(
                                    children: [
                                      Container(
                                        padding: const EdgeInsets.all(14),

                                        decoration: BoxDecoration(
                                          color: Colors.blue.shade50,
                                          borderRadius: BorderRadius.circular(
                                            18,
                                          ),
                                        ),

                                        child: Icon(
                                          Icons.fitness_center,
                                          color: Colors.blue.shade700,
                                        ),
                                      ),

                                      const SizedBox(width: 14),

                                      Expanded(
                                        child: Column(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,

                                          children: [
                                            Text(
                                              plan.name,

                                              style: const TextStyle(
                                                fontSize: 20,
                                                fontWeight: FontWeight.bold,
                                              ),
                                            ),

                                            const SizedBox(height: 4),

                                            Text(
                                              '${plan.exercises.length} Exercises',
                                              style: TextStyle(
                                                color: Colors.grey.shade600,
                                              ),
                                            ),
                                          ],
                                        ),
                                      ),

                                      const Icon(
                                        Icons.arrow_forward_ios,
                                        size: 18,
                                        color: Colors.grey,
                                      ),
                                    ],
                                  ),

                                  const SizedBox(height: 18),

                                  Text(
                                    plan.description ??
                                        'No Description Available',

                                    style: TextStyle(
                                      color: Colors.grey.shade700,
                                      height: 1.5,
                                    ),
                                  ),

                                  const SizedBox(height: 20),

                                  Wrap(
                                    spacing: 10,
                                    runSpacing: 10,

                                    children: plan.exercises.take(4).map((
                                      exercise,
                                    ) {
                                      return Container(
                                        padding: const EdgeInsets.symmetric(
                                          horizontal: 14,
                                          vertical: 10,
                                        ),

                                        decoration: BoxDecoration(
                                          color: Colors.grey.shade100,
                                          borderRadius: BorderRadius.circular(
                                            50,
                                          ),
                                        ),

                                        child: Text(
                                          exercise.name,

                                          style: const TextStyle(
                                            fontWeight: FontWeight.w600,
                                          ),
                                        ),
                                      );
                                    }).toList(),
                                  ),

                                  const SizedBox(height: 24),

                                  SizedBox(
                                    width: double.infinity,
                                    height: 52,

                                    child: ElevatedButton.icon(
                                      style: ElevatedButton.styleFrom(
                                        backgroundColor: Colors.blue.shade700,

                                        shape: RoundedRectangleBorder(
                                          borderRadius: BorderRadius.circular(
                                            16,
                                          ),
                                        ),
                                      ),

                                      onPressed: () async {
                                        var result = await Navigator.push(
                                          context,
                                          MaterialPageRoute(
                                            builder: (_) => BlocProvider.value(
                                              value: bloc,

                                              child: AssignPlanScreen(
                                                planId: plan.id,
                                              ),
                                            ),
                                          ),
                                        );

                                        if (result == true) {
                                          page = 1;

                                          bloc.add(GetPlansEvent(page: 1));
                                        }
                                      },

                                      icon: const Icon(
                                        Icons.send,
                                        color: Colors.white,
                                      ),

                                      label: const Text(
                                        'Assign Plan',

                                        style: TextStyle(
                                          color: Colors.white,
                                          fontSize: 16,
                                          fontWeight: FontWeight.bold,
                                        ),
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ),
                        );
                      },
                    );
                  }

                  if (state is WorkoutPlanFailure) {
                    return Center(child: Text(state.message));
                  }

                  return const SizedBox();
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
