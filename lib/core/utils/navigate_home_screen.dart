import 'package:fitness_planner_frontend/core/storage/token_storage.dart';
import 'package:fitness_planner_frontend/features/auth/presentation/screens/login_screen.dart';
import 'package:fitness_planner_frontend/features/home/presentation/screens/client_home_screen.dart';
import 'package:fitness_planner_frontend/features/home/presentation/screens/coach_home_screen.dart';
import 'package:flutter/material.dart';
import 'package:jwt_decoder/jwt_decoder.dart';

import '../../../../core/storage/token_storage.dart';

class NavigateHomeScreen {
  static void goToLogin(context) {
    Navigator.pushReplacement(
      context,
      MaterialPageRoute(builder: (_) => const LoginScreen()),
    );
  }

  static Future<void> checkLogin(context) async {
    final token = await TokenStorage.getToken();

    if (token == null) {
      goToLogin(context);
      return;
    }

    final decoded = JwtDecoder.decode(token);

    final role = decoded['role'];

    if (role == 'coach') {
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (_) => const CoachHomeScreen()),
      );
    } else {
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (_) => const ClientHomeScreen()),
      );
    }
  }

  static logout(context) async {
    Navigator.pushReplacement(
      context,
      MaterialPageRoute(builder: (_) => const LoginScreen()),
    );

    await TokenStorage.clear();
  }
}
