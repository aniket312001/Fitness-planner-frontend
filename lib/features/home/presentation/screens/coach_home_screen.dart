import 'package:fitness_planner_frontend/core/utils/navigate_home_screen.dart';
import 'package:fitness_planner_frontend/features/workout_plan/presentation/screens/coach_plans_screen.dart';
import 'package:flutter/material.dart';

class CoachHomeScreen extends StatefulWidget {
  const CoachHomeScreen({super.key});

  @override
  State<CoachHomeScreen> createState() => _CoachHomeScreenState();
}

class _CoachHomeScreenState extends State<CoachHomeScreen> {
  int currentIndex = 0;

  final pages = const [CoachDashboardTab(), CoachPlansScreen()];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: pages[currentIndex],

      bottomNavigationBar: Container(
        margin: const EdgeInsets.all(16),

        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(24),

          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.08),
              blurRadius: 20,
              offset: const Offset(0, 8),
            ),
          ],
        ),

        child: ClipRRect(
          borderRadius: BorderRadius.circular(24),

          child: BottomNavigationBar(
            currentIndex: currentIndex,

            onTap: (value) {
              setState(() {
                currentIndex = value;
              });
            },

            backgroundColor: Colors.white,

            elevation: 0,

            selectedItemColor: Colors.blue.shade700,
            unselectedItemColor: Colors.grey.shade500,

            selectedLabelStyle: const TextStyle(fontWeight: FontWeight.bold),

            items: const [
              BottomNavigationBarItem(
                icon: Icon(Icons.dashboard_rounded),
                label: 'Dashboard',
              ),

              BottomNavigationBarItem(
                icon: Icon(Icons.fitness_center),
                label: 'Plans',
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class CoachDashboardTab extends StatelessWidget {
  const CoachDashboardTab({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            colors: [Color(0xff0f172a), Color(0xff1e293b), Color(0xff334155)],
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
          ),
        ),

        child: SafeArea(
          child: SingleChildScrollView(
            padding: const EdgeInsets.all(20),

            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,

              children: [
                Row(
                  children: [
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,

                        children: [
                          Text(
                            'Welcome Coach 💪',
                            style: TextStyle(
                              color: Colors.white.withOpacity(0.8),
                              fontSize: 16,
                            ),
                          ),

                          const SizedBox(height: 8),

                          const Text(
                            'Coach Dashboard',
                            style: TextStyle(
                              fontSize: 32,
                              fontWeight: FontWeight.bold,
                              color: Colors.white,
                            ),
                          ),
                        ],
                      ),
                    ),

                    Container(
                      decoration: BoxDecoration(
                        color: Colors.white.withOpacity(0.12),
                        borderRadius: BorderRadius.circular(16),
                      ),

                      child: IconButton(
                        onPressed: () => NavigateHomeScreen.logout(context),

                        icon: const Icon(Icons.logout, color: Colors.white),
                      ),
                    ),
                  ],
                ),

                const SizedBox(height: 40),

                Container(
                  width: double.infinity,
                  padding: const EdgeInsets.all(24),

                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(28),

                    gradient: LinearGradient(
                      colors: [
                        Colors.deepPurple.shade500,
                        Colors.blue.shade900,
                      ],
                    ),
                  ),

                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,

                    children: [
                      Row(
                        children: [
                          Container(
                            padding: const EdgeInsets.all(14),

                            decoration: BoxDecoration(
                              color: Colors.white.withOpacity(0.18),
                              shape: BoxShape.circle,
                            ),

                            child: const Icon(
                              Icons.workspace_premium,
                              color: Colors.white,
                              size: 30,
                            ),
                          ),

                          const Spacer(),

                          const Icon(
                            Icons.auto_graph,
                            color: Colors.white,
                            size: 34,
                          ),
                        ],
                      ),

                      const SizedBox(height: 24),

                      const Text(
                        'Build Strong Athletes',
                        style: TextStyle(
                          fontSize: 28,
                          fontWeight: FontWeight.bold,
                          color: Colors.white,
                        ),
                      ),

                      const SizedBox(height: 12),

                      Text(
                        'Create workout plans, assign exercises, and help clients transform their fitness journey.',
                        style: TextStyle(
                          color: Colors.white.withOpacity(0.9),
                          height: 1.5,
                          fontSize: 15,
                        ),
                      ),
                    ],
                  ),
                ),

                const SizedBox(height: 32),

                const Text(
                  'Overview',
                  style: TextStyle(
                    fontSize: 22,
                    fontWeight: FontWeight.bold,
                    color: Colors.white,
                  ),
                ),

                const SizedBox(height: 20),

                Row(
                  children: [
                    Expanded(
                      child: _buildCard(
                        icon: Icons.people,
                        title: 'Clients',
                        value: '25',
                      ),
                    ),

                    const SizedBox(width: 16),

                    Expanded(
                      child: _buildCard(
                        icon: Icons.assignment,
                        title: 'Plans',
                        value: '14',
                      ),
                    ),
                  ],
                ),

                const SizedBox(height: 16),

                Row(
                  children: [
                    Expanded(
                      child: _buildCard(
                        icon: Icons.check_circle,
                        title: 'Completed',
                        value: '40',
                      ),
                    ),

                    const SizedBox(width: 16),

                    Expanded(
                      child: _buildCard(
                        icon: Icons.trending_up,
                        title: 'Growth',
                        value: '+18%',
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildCard({
    required IconData icon,
    required String title,
    required String value,
  }) {
    return Container(
      padding: const EdgeInsets.all(20),

      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(24),
      ),

      child: Column(
        children: [
          Container(
            padding: const EdgeInsets.all(12),

            decoration: BoxDecoration(
              color: Colors.deepPurple.shade50,
              shape: BoxShape.circle,
            ),

            child: Icon(icon, color: Colors.deepPurple),
          ),

          const SizedBox(height: 16),

          Text(
            value,
            style: const TextStyle(fontSize: 26, fontWeight: FontWeight.bold),
          ),

          const SizedBox(height: 6),

          Text(title, style: TextStyle(color: Colors.grey.shade600)),
        ],
      ),
    );
  }
}
