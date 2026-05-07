import 'package:fitness_planner_frontend/core/di/injector.dart';
import 'package:fitness_planner_frontend/core/widgets/app_text_field.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../bloc/users_bloc.dart';
import '../bloc/users_event.dart';
import '../bloc/users_state.dart';

import '../../../workout_plan/presentation/bloc/workout_plan_bloc.dart';
import '../../../workout_plan/presentation/bloc/workout_plan_event.dart';
import '../../../workout_plan/presentation/bloc/workout_plan_state.dart';

class AssignPlanScreen extends StatefulWidget {
  final String planId;

  const AssignPlanScreen({super.key, required this.planId});

  @override
  State<AssignPlanScreen> createState() => _AssignPlanScreenState();
}

class _AssignPlanScreenState extends State<AssignPlanScreen> {
  final searchController = TextEditingController();

  final scrollController = ScrollController();

  List<String> selectedUsers = [];

  int page = 1;

  final int limit = 10;

  List users = [];

  bool isLoadingMore = false;

  bool hasMore = true;

  @override
  void initState() {
    super.initState();

    scrollController.addListener(_onScroll);
  }

  void _loadUsers({String search = ''}) {
    context.read<UsersBloc>().add(
      GetClientsEvent(page: page, limit: limit, search: search),
    );
  }

  void _onScroll() {
    if (scrollController.position.pixels >=
            scrollController.position.maxScrollExtent - 200 &&
        !isLoadingMore &&
        hasMore) {
      page++;

      isLoadingMore = true;

      _loadUsers(search: searchController.text);
    }
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => sl<UsersBloc>()
        ..add(
          GetClientsEvent(
            page: page,
            limit: limit,
            search: searchController.text,
          ),
        ),

      child: Builder(
        builder: (context) {
          return Scaffold(
            // backgroundColor: const Color(0xff0f172a),
            appBar: AppBar(
              elevation: 0,
              // backgroundColor: Colors.transparent,
              centerTitle: true,

              title: const Text(
                'Assign Workout Plan',
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  // color: Colors.white,
                ),
              ),
            ),

            body: Container(
              // decoration: const BoxDecoration(
              //   gradient: LinearGradient(
              //     colors: [
              //       Color(0xff0f172a),
              //       Color(0xff1e293b),
              //       Color(0xff334155),
              //     ],
              //     begin: Alignment.topLeft,
              //     end: Alignment.bottomRight,
              //   ),
              // ),
              child: Column(
                children: [
                  /// SEARCH
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 20),

                    child: AppTextField(
                      controller: searchController,
                      hintText: 'Search Clients',
                      prefixIcon: const Icon(Icons.search),

                      onChanged: (value) {
                        page = 1;

                        users.clear();

                        hasMore = true;

                        _loadUsers(search: value);
                      },
                    ),
                  ),

                  const SizedBox(height: 18),

                  /// USERS LIST
                  Expanded(
                    child: BlocConsumer<UsersBloc, UsersState>(
                      listener: (context, state) {
                        if (state is UsersLoaded) {
                          isLoadingMore = false;

                          if (page == 1) {
                            users = state.users;
                          } else {
                            users.addAll(state.users);
                          }

                          if (state.users.length < limit) {
                            hasMore = false;
                          }
                        }
                      },

                      builder: (context, state) {
                        if (state is UsersLoading && page == 1) {
                          return const Center(
                            child: CircularProgressIndicator(
                              color: Colors.white,
                            ),
                          );
                        }

                        if (users.isEmpty) {
                          return const Center(
                            child: Text(
                              'No Clients Found',
                              style: TextStyle(
                                color: Colors.white,
                                fontSize: 16,
                              ),
                            ),
                          );
                        }

                        return ListView.builder(
                          controller: scrollController,

                          padding: const EdgeInsets.symmetric(horizontal: 20),

                          itemCount: users.length + (hasMore ? 1 : 0),

                          itemBuilder: (context, index) {
                            if (index >= users.length) {
                              return const Padding(
                                padding: EdgeInsets.all(20),

                                child: Center(
                                  child: CircularProgressIndicator(
                                    color: Colors.white,
                                  ),
                                ),
                              );
                            }

                            final user = users[index];

                            final isSelected = selectedUsers.contains(user.id);

                            return AnimatedContainer(
                              duration: const Duration(milliseconds: 250),

                              margin: const EdgeInsets.only(bottom: 16),

                              decoration: BoxDecoration(
                                color: isSelected
                                    ? Colors.blue.shade700
                                    : Colors.white,

                                borderRadius: BorderRadius.circular(22),

                                boxShadow: [
                                  BoxShadow(
                                    color: Colors.black.withOpacity(0.08),
                                    blurRadius: 12,
                                    offset: const Offset(0, 6),
                                  ),
                                ],
                              ),

                              child: CheckboxListTile(
                                value: isSelected,

                                activeColor: Colors.white,

                                checkColor: Colors.blue,

                                secondary: CircleAvatar(
                                  radius: 26,
                                  backgroundColor: isSelected
                                      ? Colors.white.withOpacity(0.2)
                                      : Colors.blue.shade100,

                                  child: Text(
                                    user.name[0].toUpperCase(),

                                    style: TextStyle(
                                      color: isSelected
                                          ? Colors.white
                                          : Colors.blue.shade700,
                                      fontWeight: FontWeight.bold,
                                      fontSize: 20,
                                    ),
                                  ),
                                ),

                                title: Text(
                                  user.name,

                                  style: TextStyle(
                                    fontWeight: FontWeight.bold,
                                    fontSize: 16,

                                    color: isSelected
                                        ? Colors.white
                                        : Colors.black87,
                                  ),
                                ),

                                subtitle: Padding(
                                  padding: const EdgeInsets.only(top: 4),

                                  child: Text(
                                    user.email,

                                    style: TextStyle(
                                      color: isSelected
                                          ? Colors.white70
                                          : Colors.grey.shade700,
                                    ),
                                  ),
                                ),

                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(22),
                                ),

                                onChanged: (value) {
                                  setState(() {
                                    if (value == true) {
                                      selectedUsers.add(user.id);
                                    } else {
                                      selectedUsers.remove(user.id);
                                    }
                                  });
                                },
                              ),
                            );
                          },
                        );
                      },
                    ),
                  ),

                  /// BOTTOM BUTTON
                  Container(
                    padding: const EdgeInsets.all(20),

                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: const BorderRadius.only(
                        topLeft: Radius.circular(30),
                        topRight: Radius.circular(30),
                      ),

                      boxShadow: [
                        BoxShadow(
                          color: Colors.black.withOpacity(0.08),
                          blurRadius: 15,
                          offset: const Offset(0, -5),
                        ),
                      ],
                    ),

                    child: Column(
                      mainAxisSize: MainAxisSize.min,

                      children: [
                        Row(
                          children: [
                            Icon(
                              Icons.people_alt_rounded,
                              color: Colors.blue.shade700,
                            ),

                            const SizedBox(width: 10),

                            Text(
                              '${selectedUsers.length} client selected',
                              style: const TextStyle(
                                fontWeight: FontWeight.w600,
                                fontSize: 15,
                              ),
                            ),
                          ],
                        ),

                        const SizedBox(height: 18),

                        BlocConsumer<WorkoutPlanBloc, WorkoutPlanState>(
                          listener: (context, state) {
                            if (state is WorkoutPlanSuccess) {
                              ScaffoldMessenger.of(context).showSnackBar(
                                SnackBar(
                                  backgroundColor: Colors.green.shade400,

                                  content: const Text('Assigned Successfully'),
                                ),
                              );

                              Navigator.pop(context, true);
                            }
                          },

                          builder: (context, state) {
                            return SizedBox(
                              width: double.infinity,
                              height: 58,

                              child: ElevatedButton(
                                style: ElevatedButton.styleFrom(
                                  elevation: 0,

                                  backgroundColor: Colors.blue.shade700,

                                  shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(18),
                                  ),
                                ),

                                onPressed: () {
                                  if (selectedUsers.isEmpty) {
                                    ScaffoldMessenger.of(context).showSnackBar(
                                      SnackBar(
                                        backgroundColor: Colors.red.shade400,

                                        content: const Text(
                                          'Please select at least one client',
                                        ),
                                      ),
                                    );

                                    return;
                                  }

                                  context.read<WorkoutPlanBloc>().add(
                                    AssignPlanEvent(
                                      planId: widget.planId,
                                      clientIds: selectedUsers,
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
                                            Icons.send_rounded,
                                            color: Colors.white,
                                          ),

                                          SizedBox(width: 10),

                                          Text(
                                            'Assign Plan',
                                            style: TextStyle(
                                              fontSize: 17,
                                              fontWeight: FontWeight.bold,
                                              color: Colors.white,
                                            ),
                                          ),
                                        ],
                                      ),
                              ),
                            );
                          },
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}
