import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:rainify/core/utils/notification_service.dart';
import 'package:rainify/features/dashboard/bloc/bloc.dart';
import 'package:rainify/features/dashboard/data/provider/dashboard_provider.dart';
import 'package:rainify/features/dashboard/data/reprository/dashboard_repo.dart';
import 'package:rainify/features/forecast/bloc/bloc.dart';
import 'package:rainify/features/forecast/data/provider/forecast_provider.dart';
import 'package:rainify/features/forecast/data/reprository/forecast_repo.dart';
import 'package:rainify/firebase_options.dart';

import 'core/common/app_route.dart' show router;
import 'core/common/app_theme.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);
  NotificationService().initNotification();
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiRepositoryProvider(
      providers: [
        RepositoryProvider(
          create: (context) =>
              DashboardRepository(dashboardProvider: DashboardProvider()),
        ),
        RepositoryProvider(
          create: (context) =>
              ForecastRepository(forcastProvider: ForecastProvider()),
        ),
      ],
      child: MultiBlocProvider(
        providers: [
          BlocProvider(
            create: (context) =>
                DashboardBloc(context.read<DashboardRepository>()),
          ),
          BlocProvider(
            create: (context) =>
                ForecastBloc(context.read<ForecastRepository>()),
          ),
        ],
        child: MaterialApp.router(
          debugShowCheckedModeBanner: false,
          theme: AppTheme.darkThemeMode,
          routerConfig: router,
        ),
      ),
    );
  }
}
