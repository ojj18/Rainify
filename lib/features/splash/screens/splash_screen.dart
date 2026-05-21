import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

import '../../../core/common/app_route.dart';
import '../../../core/utils/location_service.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen>
    with TickerProviderStateMixin {
  bool isLocationServiceEnabled = false;

  @override
  void didChangeDependencies() async {
    final locationSettings = LocationService();
    isLocationServiceEnabled = await locationSettings.checkLocationPermission(
      context,
    );
    if (isLocationServiceEnabled) navigatorToDashboard();
    super.didChangeDependencies();
  }

  Future<void> navigatorToDashboard() async {
    await Future.delayed(Duration(seconds: 3));

    if (!mounted) return;

    FirebaseAuth.instance.userChanges().listen((User? user) {
      if (user != null) {
        if (mounted) {
          context.go(RouteName.dashboardScreen);
        }
      } else {
        if (mounted) {
          context.go(RouteName.loginScreen);
        }
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: CustomScrollView(
        slivers: [
          SliverFillRemaining(
            hasScrollBody: false,
            child: Center(
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Container(
                    height: 150,
                    width: 150,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(10.0),
                      image: const DecorationImage(
                        image: AssetImage("assets/images/app_logo.png"),
                        fit: BoxFit.cover,
                      ),
                    ),
                  ),

                  const SizedBox(height: 16),

                  Text(
                    "Rainify",
                    style: Theme.of(context).textTheme.displayLarge,
                  ),

                  const SizedBox(height: 8),

                  Text(
                    "Precision Atmosphere".toUpperCase(),
                    style: Theme.of(context).textTheme.titleLarge,
                  ),
                  const SizedBox(height: 20),
                  SizedBox(
                    width: 200,
                    child: LinearProgressIndicator(
                      borderRadius: BorderRadius.circular(10),
                      backgroundColor: Theme.of(
                        context,
                      ).scaffoldBackgroundColor,
                      color: Theme.of(context).progressIndicatorTheme.color,
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
}
