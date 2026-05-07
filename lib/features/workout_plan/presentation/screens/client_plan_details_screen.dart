import 'package:flutter/material.dart';

import '../../domain/entities/assignment_entity.dart';

class ClientPlanDetailsScreen extends StatelessWidget {
  final AssignmentEntity plan;

  const ClientPlanDetailsScreen({super.key, required this.plan});

  @override
  Widget build(BuildContext context) {
    final isCompleted = plan.status == 'completed';

    return Scaffold(
      backgroundColor: const Color(0xfff8fafc),

      body: CustomScrollView(
        slivers: [
          SliverAppBar(
            expandedHeight: 220,
            pinned: true,
            backgroundColor: Colors.blue.shade700,

            flexibleSpace: FlexibleSpaceBar(
              title: Text(
                plan.name,
                style: const TextStyle(fontWeight: FontWeight.bold),
              ),

              background: Container(
                decoration: BoxDecoration(
                  gradient: LinearGradient(
                    colors: [Colors.blue.shade800, Colors.blue.shade500],
                    begin: Alignment.topLeft,
                    end: Alignment.bottomRight,
                  ),
                ),

                child: Center(
                  child: Icon(
                    Icons.fitness_center,
                    size: 80,
                    color: Colors.white.withOpacity(0.2),
                  ),
                ),
              ),
            ),
          ),

          SliverToBoxAdapter(
            child: Padding(
              padding: const EdgeInsets.all(20),

              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,

                children: [
                  Container(
                    padding: const EdgeInsets.all(18),

                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(20),
                      boxShadow: [
                        BoxShadow(
                          color: Colors.black.withOpacity(0.05),
                          blurRadius: 10,
                        ),
                      ],
                    ),

                    child: Column(
                      children: [
                        Row(
                          children: [
                            Expanded(
                              child: _infoTile(
                                icon: Icons.person,
                                title: 'Assigned By',
                                value: plan.assignedByName ?? 'Unknown Coach',
                              ),
                            ),

                            Expanded(
                              child: _infoTile(
                                icon: Icons.calendar_today,
                                title: 'Assigned On',
                                value: plan.assignedAt != null
                                    ? '${plan.assignedAt!.day}/${plan.assignedAt!.month}/${plan.assignedAt!.year}'
                                    : 'No Date',
                              ),
                            ),
                          ],
                        ),

                        const SizedBox(height: 20),

                        Row(
                          children: [
                            const Text(
                              'Status',
                              style: TextStyle(fontWeight: FontWeight.bold),
                            ),

                            const Spacer(),

                            Container(
                              padding: const EdgeInsets.symmetric(
                                horizontal: 16,
                                vertical: 8,
                              ),

                              decoration: BoxDecoration(
                                color: isCompleted
                                    ? Colors.green.shade100
                                    : Colors.orange.shade100,

                                borderRadius: BorderRadius.circular(30),
                              ),

                              child: Text(
                                plan.status.toUpperCase(),
                                style: TextStyle(
                                  color: isCompleted
                                      ? Colors.green.shade700
                                      : Colors.orange.shade700,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),

                  const SizedBox(height: 24),

                  const Text(
                    'Description',
                    style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
                  ),

                  const SizedBox(height: 12),

                  Text(
                    plan.description ?? 'No Description',
                    style: TextStyle(color: Colors.grey.shade700, height: 1.5),
                  ),

                  const SizedBox(height: 30),

                  const Text(
                    'Exercises',
                    style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
                  ),

                  const SizedBox(height: 16),

                  ...plan.exercises.map(
                    (exercise) => Container(
                      margin: const EdgeInsets.only(bottom: 14),

                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(18),
                        boxShadow: [
                          BoxShadow(
                            color: Colors.black.withOpacity(0.04),
                            blurRadius: 8,
                          ),
                        ],
                      ),

                      child: ListTile(
                        contentPadding: const EdgeInsets.all(16),

                        leading: Container(
                          padding: const EdgeInsets.all(12),

                          decoration: BoxDecoration(
                            color: Colors.blue.shade50,
                            borderRadius: BorderRadius.circular(14),
                          ),

                          child: Icon(
                            Icons.fitness_center,
                            color: Colors.blue.shade700,
                          ),
                        ),

                        title: Text(
                          exercise.name,
                          style: const TextStyle(fontWeight: FontWeight.w600),
                        ),

                        trailing: const Icon(Icons.arrow_forward_ios, size: 16),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _infoTile({
    required IconData icon,
    required String title,
    required String value,
  }) {
    return Column(
      children: [
        Icon(icon, color: Colors.blue),

        const SizedBox(height: 8),

        Text(
          title,
          style: TextStyle(color: Colors.grey.shade600, fontSize: 13),
        ),

        const SizedBox(height: 4),

        Text(
          value,
          textAlign: TextAlign.center,
          style: const TextStyle(fontWeight: FontWeight.bold),
        ),
      ],
    );
  }
}
