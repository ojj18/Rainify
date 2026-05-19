import 'package:flutter/material.dart';
import 'package:package_info_plus/package_info_plus.dart';
import 'package:rainify/core/common/app_const.dart';
import 'package:rainify/features/settings/presentation/widgets/general_setting_widget.dart';
import 'package:rainify/features/settings/presentation/widgets/location_setting_widget.dart';
import 'package:rainify/features/settings/presentation/widgets/notification_widget.dart';

import '../../../../core/common/widgets/bottom_navbar_widget.dart';
import '../widgets/left_slide_animation.dart';

class SettingScreen extends StatefulWidget {
  const SettingScreen({super.key});

  @override
  State<SettingScreen> createState() => _SettingScreenState();
}

class _SettingScreenState extends State<SettingScreen> {
  PackageInfo info = PackageInfo(
    appName: 'Unknown',
    packageName: 'Unknown',
    version: 'Unknown',
    buildNumber: 'Unknown',
    buildSignature: 'Unknown',
    installerStore: 'Unknown',
  );
  @override
  void initState() {
    _initPackageInfo();
    super.initState();
  }

  Future<void> _initPackageInfo() async {
    final packageInfo = await PackageInfo.fromPlatform();
    setState(() {
      info = packageInfo;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: Icon(
          Icons.settings_outlined,
          color: Theme.of(context).iconTheme.color,
          size: 24,
        ),

        title: Text(
          "Settings",
          style: Theme.of(
            context,
          ).textTheme.displayLarge!.copyWith(fontSize: 20),
        ),
      ),
      body: CustomScrollView(
        physics: const BouncingScrollPhysics(),
        slivers: [
          SliverList(
            delegate: SliverChildListDelegate([
              LeftSlideAnimation(child: GeneralSettingWidget()),
              const SizedBox(height: 20.0),
              LeftSlideAnimation(child: NotificationWidget()),
              const SizedBox(height: 20.0),
              LeftSlideAnimation(child: LocationSettingWidget()),
              const SizedBox(height: 30.0),
              Center(
                child: Text(
                  "atmosphere premium v${info.version}",
                  style: Theme.of(context).textTheme.titleMedium!.copyWith(
                    fontSize: 12,
                    color: AppConst.secTextColor,
                  ),
                ),
              ),
              const SizedBox(height: 30.0),
            ]),
          ),
        ],
      ),
      bottomNavigationBar: const BottomNavbarWidget(),
    );
  }
}
