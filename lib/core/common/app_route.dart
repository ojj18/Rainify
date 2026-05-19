import 'package:go_router/go_router.dart';
import 'package:rainify/features/forgotpassword/presentation/screen/forgot_password_screen.dart';

import '../../features/dashboard/presentation/screens/dashboard.dart';
import '../../features/forecast/presentation/screens/forecast.dart';
import '../../features/login/presentation/screens/login_screen.dart';
import '../../features/radar/presentation/screens/radar.dart';
import '../../features/register/presentation/screens/register_screen.dart';
import '../../features/settings/presentation/screens/settings.dart';
import '../../features/splash/screens/splash_screen.dart';

class RouteName {
  static const splashScreen = '/';
  static const loginScreen = '/loginScreen';
  static const registerScreen = '/registerScreen';
  static const dashboardScreen = '/dashboardScreen';
  static const forecastScreen = '/forecastScreen';
  static const radarScreen = '/radarScreen';
  static const settingScreen = '/settingScreen';
  static const forgotPasswordScreen = '/forgotpasswordScreen';
}

GoRouter router = GoRouter(
  routes: [
    GoRoute(
      path: RouteName.splashScreen,
      name: "Spash",
      builder: (context, state) => SplashScreen(),
    ),
    GoRoute(
      path: RouteName.loginScreen,
      builder: (context, state) => LoginScreen(),
    ),
    GoRoute(
      path: RouteName.registerScreen,
      builder: (context, state) => RegisterScreen(),
    ),
    GoRoute(
      path: RouteName.dashboardScreen,
      name: "Dashboard",
      builder: (context, state) => DashboardScreen(),
    ),
    GoRoute(
      path: RouteName.forecastScreen,
      name: "Forecast",
      builder: (context, state) => ForecastScreen(),
    ),
    GoRoute(
      path: RouteName.radarScreen,
      name: "Radar",
      builder: (context, state) => RadarScreen(),
    ),
    GoRoute(
      path: RouteName.settingScreen,
      name: "Settings",
      builder: (context, state) => SettingScreen(),
    ),
    GoRoute(
      path: RouteName.forgotPasswordScreen,
      name: "forgotPassword",
      builder: (context, state) => ForgotPasswordScreen(),
    ),
  ],
);
