import 'package:flutter/material.dart';

import '../../domain/entities/plan_entity.dart';

class PlanDetailsScreen extends StatelessWidget {
  final PlanEntity plan;

  const PlanDetailsScreen({super.key, required this.plan});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xfff8fafc),

      body: CustomScrollView(
        slivers: [
          SliverAppBar(
            expandedHeight: 240,
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
                    colors: [Colors.blue.shade700, Colors.blue.shade400],

                    begin: Alignment.topLeft,
                    end: Alignment.bottomRight,
                  ),
                ),

                child: Center(
                  child: Container(
                    height: 100,
                    width: 100,

                    decoration: BoxDecoration(
                      color: Colors.white.withOpacity(0.18),
                      shape: BoxShape.circle,
                    ),

                    child: const Icon(
                      Icons.fitness_center,
                      color: Colors.white,
                      size: 45,
                    ),
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
                    padding: const EdgeInsets.all(22),

                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(28),

                      boxShadow: [
                        BoxShadow(
                          color: Colors.black.withOpacity(0.05),
                          blurRadius: 14,
                          offset: const Offset(0, 8),
                        ),
                      ],
                    ),

                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,

                      children: [
                        Row(
                          children: [
                            Container(
                              padding: const EdgeInsets.all(14),

                              decoration: BoxDecoration(
                                color: Colors.blue.shade50,
                                borderRadius: BorderRadius.circular(18),
                              ),

                              child: Icon(
                                Icons.description,
                                color: Colors.blue.shade700,
                              ),
                            ),

                            const SizedBox(width: 14),

                            const Text(
                              'Plan Overview',

                              style: TextStyle(
                                fontSize: 20,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ],
                        ),

                        const SizedBox(height: 22),

                        Text(
                          plan.description ?? 'No Description Available',

                          style: TextStyle(
                            fontSize: 15,
                            color: Colors.grey.shade700,
                            height: 1.7,
                          ),
                        ),

                        const SizedBox(height: 24),

                        Container(
                          padding: const EdgeInsets.all(18),

                          decoration: BoxDecoration(
                            color: Colors.blue.shade50,
                            borderRadius: BorderRadius.circular(18),
                          ),

                          child: Row(
                            children: [
                              Icon(
                                Icons.fitness_center,
                                color: Colors.blue.shade700,
                              ),

                              const SizedBox(width: 12),

                              Expanded(
                                child: Text(
                                  '${plan.exercises.length} Exercises Included',

                                  style: TextStyle(
                                    fontSize: 15,
                                    fontWeight: FontWeight.w600,
                                    color: Colors.blue.shade700,
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),

                  const SizedBox(height: 30),

                  const Text(
                    'Exercises',
                    style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
                  ),

                  const SizedBox(height: 18),

                  ...plan.exercises.asMap().entries.map((entry) {
                    final index = entry.key;
                    final exercise = entry.value;

                    return Container(
                      margin: const EdgeInsets.only(bottom: 16),

                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(24),

                        boxShadow: [
                          BoxShadow(
                            color: Colors.black.withOpacity(0.05),
                            blurRadius: 10,
                            offset: const Offset(0, 6),
                          ),
                        ],
                      ),

                      child: ListTile(
                        contentPadding: const EdgeInsets.all(18),

                        leading: Container(
                          height: 52,
                          width: 52,

                          decoration: BoxDecoration(
                            color: Colors.blue.shade50,
                            borderRadius: BorderRadius.circular(16),
                          ),

                          child: Center(
                            child: Text(
                              '${index + 1}',

                              style: TextStyle(
                                color: Colors.blue.shade700,
                                fontWeight: FontWeight.bold,
                                fontSize: 16,
                              ),
                            ),
                          ),
                        ),

                        title: Text(
                          exercise.name,

                          style: const TextStyle(
                            fontSize: 17,
                            fontWeight: FontWeight.bold,
                          ),
                        ),

                        subtitle: const Padding(
                          padding: EdgeInsets.only(top: 6),

                          child: Text('Workout Exercise'),
                        ),

                        trailing: Icon(
                          Icons.arrow_forward_ios,
                          size: 18,
                          color: Colors.grey.shade500,
                        ),
                      ),
                    );
                  }),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
