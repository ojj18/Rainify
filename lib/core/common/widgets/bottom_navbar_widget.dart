import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:rainify/core/common/app_const.dart';
import 'package:rainify/core/common/app_route.dart';

class BottomNavbarWidget extends StatelessWidget {
  const BottomNavbarWidget({super.key});

  @override
  Widget build(BuildContext context) {
    final String location = GoRouterState.of(context).uri.toString();

    int currentIndex = _calculateIndex(location);

    return NavigationBar(
      indicatorColor: Colors.grey.withValues(alpha: 0.3),
      elevation: 20.0,
      backgroundColor: AppConst.glassmorphicColor,

      height: MediaQuery.sizeOf(context).height * 0.08,

      selectedIndex: currentIndex,

      onDestinationSelected: (index) {
        switch (index) {
          case 0:
            context.go(RouteName.dashboardScreen);
            break;

          case 1:
            context.go(RouteName.forecastScreen);
            break;

          case 2:
            context.go(RouteName.radarScreen);
            break;

          case 3:
            context.go(RouteName.settingScreen);
            break;
        }
      },

      destinations: [
        navbutton(Icons.cloud_outlined, "Weather"),

        navbutton(Icons.calendar_month_outlined, "Forecast"),

        navbutton(Icons.radar_outlined, "Radar"),

        navbutton(Icons.settings_outlined, "Settings"),
      ],
    );
  }

  NavigationDestination navbutton(IconData buttonIcon, String buttonTitle) {
    return NavigationDestination(icon: Icon(buttonIcon), label: buttonTitle);
  }

  int _calculateIndex(String location) {
    switch (location) {
      case RouteName.forecastScreen:
        return 1;

      case RouteName.radarScreen:
        return 2;

      case RouteName.settingScreen:
        return 3;

      default:
        return 0;
    }
  }
}
