import 'package:fitness_planner_frontend/core/utils/navigate_home_screen.dart';
import 'package:flutter/material.dart';

import 'client_home_screen.dart';
import 'coach_home_screen.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    super.initState();

    NavigateHomeScreen.checkLogin(context);
  }

  @override
  Widget build(BuildContext context) {
    return const Scaffold(body: Center(child: CircularProgressIndicator()));
  }
}
