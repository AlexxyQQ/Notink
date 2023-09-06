import 'package:flutter/material.dart';
import 'package:notink/config/router/routers.dart';
import 'package:notink/core/common/loading_screen.dart';
import 'package:notink/feature/auth/presentaion/widgets/main_auth_page.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    super.initState();
    initialDataFetch();
  }

  /// Perform some data fetcing and validation here
  Future<void> initialDataFetch() async {
    final nav = Navigator.of(context);
    // Wait for 2 seconds
    await Future.delayed(const Duration(seconds: 2));
    nav.popAndPushNamed(AppRoutes.homeRoute);
  }

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      body:
          // User BLoC or something to check the state and navigate to the next screen accordingly
          LoadingScreen(),
    );
  }
}
