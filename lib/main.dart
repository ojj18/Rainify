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
import 'package:rainify/features/forgotpassword/bloc/bloc.dart';
import 'package:rainify/features/forgotpassword/data/provider/forgot_password_provider.dart';
import 'package:rainify/features/forgotpassword/data/reprository/forgot_password_repo.dart';
import 'package:rainify/features/login/bloc/bloc.dart';
import 'package:rainify/features/login/data/provider/login_provider.dart';
import 'package:rainify/features/login/data/repository/login_repo.dart';
import 'package:rainify/features/radar/bloc/bloc.dart';
import 'package:rainify/features/radar/data/provider/radar_provider.dart';
import 'package:rainify/features/radar/data/reprository/radar_repo.dart';
import 'package:rainify/features/register/bloc/bloc.dart';
import 'package:rainify/features/register/data/provider/register_provider.dart';
import 'package:rainify/features/register/data/repository/register_repo.dart';
import 'package:rainify/features/settings/bloc/bloc.dart';
import 'package:rainify/features/settings/data/provider/settings_provider.dart';
import 'package:rainify/features/settings/data/repository/settings_repo.dart';
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
        RepositoryProvider(
          create: (context) =>
              RegisterRepository(registerProvider: RegisterProvider()),
        ),
        RepositoryProvider(
          create: (context) => LoginRepository(loginProvider: LoginProvider()),
        ),
        RepositoryProvider(
          create: (context) =>
              SettingsRepository(settingsProvider: SettingsProvider()),
        ),
        RepositoryProvider(
          create: (context) => ForgotPasswordRepository(
            forgotPasswordProvider: ForgotPasswordProvider(),
          ),
        ),
        RepositoryProvider(
          create: (context) => RadarRepository(radarProvider: RadarProvider()),
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
          BlocProvider(
            create: (context) =>
                RegisterBloc(context.read<RegisterRepository>()),
          ),
          BlocProvider(
            create: (context) => LoginBloc(context.read<LoginRepository>()),
          ),
          BlocProvider(
            create: (context) =>
                SettingBloc(context.read<SettingsRepository>()),
          ),
          BlocProvider(
            create: (context) =>
                ForgotPasswordBloc(context.read<ForgotPasswordRepository>()),
          ),
          BlocProvider(
            create: (context) => RadarBloc(context.read<RadarRepository>()),
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
