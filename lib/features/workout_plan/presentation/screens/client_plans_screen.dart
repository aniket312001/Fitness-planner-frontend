import 'package:fitness_planner_frontend/core/di/injector.dart';
import 'package:fitness_planner_frontend/core/widgets/app_text_field.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../bloc/workout_plan_bloc.dart';
import '../bloc/workout_plan_event.dart';
import '../bloc/workout_plan_state.dart';

import 'client_plan_details_screen.dart';

class ClientPlansScreen extends StatefulWidget {
  const ClientPlansScreen({super.key});

  @override
  State<ClientPlansScreen> createState() => _ClientPlansScreenState();
}

class _ClientPlansScreenState extends State<ClientPlansScreen> {
  final scrollController = ScrollController();

  final searchController = TextEditingController();

  late final WorkoutPlanBloc bloc;

  int page = 1;

  @override
  void initState() {
    super.initState();

    bloc = sl<WorkoutPlanBloc>();

    bloc.add(GetClientPlansEvent(page: 1));

    scrollController.addListener(_onScroll);
  }

  void _onScroll() {
    if (scrollController.position.pixels >=
        scrollController.position.maxScrollExtent - 200) {
      if (bloc.clientHasMore && !bloc.clientFetching) {
        page++;

        bloc.add(
          GetClientPlansEvent(page: page, search: searchController.text.trim()),
        );
      }
    }
  }

  @override
  void dispose() {
    scrollController.dispose();
    searchController.dispose();
    bloc.close();
    super.dispose();
  }

  Color getStatusColor(String status) {
    switch (status.toLowerCase()) {
      case 'completed':
        return Colors.green;
      case 'pending':
        return Colors.orange;
      default:
        return Colors.blue;
    }
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
            'Assigned Plans',
            style: TextStyle(color: Colors.black, fontWeight: FontWeight.bold),
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

                  bloc.add(GetClientPlansEvent(page: 1, search: value.trim()));
                },
              ),
            ),

            Expanded(
              child: BlocConsumer<WorkoutPlanBloc, WorkoutPlanState>(
                listener: (context, state) {
                  if (state is WorkoutPlanSuccess) {
                    page = 1;

                    bloc.add(
                      GetClientPlansEvent(
                        page: 1,
                        search: searchController.text.trim(),
                      ),
                    );
                  }
                },

                builder: (context, state) {
                  if (state is WorkoutPlanLoading && page == 1) {
                    return const Center(child: CircularProgressIndicator());
                  }

                  if (state is ClientPlansLoaded) {
                    if (state.plans.isEmpty) {
                      return const Center(
                        child: Text(
                          'No Assigned Plans',
                          style: TextStyle(
                            fontSize: 18,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                      );
                    }

                    return ListView.builder(
                      controller: scrollController,
                      padding: const EdgeInsets.only(bottom: 20),

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
                                builder: (_) =>
                                    ClientPlanDetailsScreen(plan: plan),
                              ),
                            );
                          },

                          child: Container(
                            margin: const EdgeInsets.symmetric(
                              horizontal: 16,
                              vertical: 10,
                            ),

                            decoration: BoxDecoration(
                              color: Colors.white,
                              borderRadius: BorderRadius.circular(24),

                              boxShadow: [
                                BoxShadow(
                                  color: Colors.black.withOpacity(0.06),
                                  blurRadius: 14,
                                  offset: const Offset(0, 6),
                                ),
                              ],
                            ),

                            child: Padding(
                              padding: const EdgeInsets.all(18),

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
                                            16,
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
                                                fontSize: 19,
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

                                      Container(
                                        padding: const EdgeInsets.symmetric(
                                          horizontal: 12,
                                          vertical: 6,
                                        ),

                                        decoration: BoxDecoration(
                                          color: getStatusColor(
                                            plan.status,
                                          ).withOpacity(0.15),

                                          borderRadius: BorderRadius.circular(
                                            50,
                                          ),
                                        ),

                                        child: Text(
                                          plan.status.toUpperCase(),
                                          style: TextStyle(
                                            color: getStatusColor(plan.status),
                                            fontWeight: FontWeight.bold,
                                            fontSize: 12,
                                          ),
                                        ),
                                      ),
                                    ],
                                  ),

                                  const SizedBox(height: 18),

                                  Text(
                                    plan.description ?? 'No description',
                                    style: TextStyle(
                                      color: Colors.grey.shade700,
                                      height: 1.5,
                                    ),
                                  ),

                                  const SizedBox(height: 18),

                                  Row(
                                    children: [
                                      const Icon(
                                        Icons.person,
                                        size: 18,
                                        color: Colors.grey,
                                      ),

                                      const SizedBox(width: 8),

                                      Expanded(
                                        child: Text(
                                          plan.assignedByName ?? 'Unknown',
                                          style: TextStyle(
                                            color: Colors.grey.shade700,
                                          ),
                                        ),
                                      ),
                                    ],
                                  ),

                                  const SizedBox(height: 12),

                                  Wrap(
                                    spacing: 8,
                                    runSpacing: 8,

                                    children: plan.exercises.take(4).map((
                                      exercise,
                                    ) {
                                      return Container(
                                        padding: const EdgeInsets.symmetric(
                                          horizontal: 12,
                                          vertical: 8,
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
                                            fontWeight: FontWeight.w500,
                                          ),
                                        ),
                                      );
                                    }).toList(),
                                  ),

                                  const SizedBox(height: 20),

                                  if (plan.status != 'completed')
                                    SizedBox(
                                      width: double.infinity,
                                      height: 48,

                                      child: ElevatedButton(
                                        style: ElevatedButton.styleFrom(
                                          backgroundColor: Colors.blue.shade700,

                                          shape: RoundedRectangleBorder(
                                            borderRadius: BorderRadius.circular(
                                              16,
                                            ),
                                          ),
                                        ),

                                        onPressed: () {
                                          bloc.add(CompletePlanEvent(plan.id));
                                        },

                                        child: const Text(
                                          'Mark as Complete',
                                          style: TextStyle(
                                            fontWeight: FontWeight.bold,
                                            color: Colors.white,
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
