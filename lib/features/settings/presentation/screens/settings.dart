import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:package_info_plus/package_info_plus.dart';
import 'package:rainify/core/common/app_const.dart';
import 'package:rainify/core/common/app_route.dart';
import 'package:rainify/features/settings/bloc/bloc.dart';
import 'package:rainify/features/settings/bloc/bloc_event.dart';
import 'package:rainify/features/settings/bloc/bloc_state.dart';
import 'package:rainify/features/settings/presentation/widgets/general_setting_widget.dart';
import 'package:rainify/features/settings/presentation/widgets/location_setting_widget.dart';
import 'package:rainify/features/settings/presentation/widgets/notification_widget.dart';

import '../../../../core/common/widgets/bottom_navbar_widget.dart';
import '../../../../core/common/widgets/common_dialog_widget.dart';
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
    return BlocConsumer<SettingBloc, SettingState>(
      listener: (context, state) {
        if (state is SettingsLoadingState) {
          showDialog(
            context: context,
            builder: (context) => Center(child: CircularProgressIndicator()),
          );
        }
        if (state is SettingsSuccessState) {
          if (context.mounted) {
            Navigator.pop(context);
          }
          context.go(RouteName.loginScreen);
        }
        if (state is SettingsErrorState) {
          if (context.mounted) {
            Navigator.pop(context);
          }
          showDialog(
            barrierDismissible: false,
            context: context,
            builder: (context) => CommonDialogWidget(
              iconColor: AppConst.errorColor,
              onTapEvent: () {
                Navigator.pop(context);
              },
              icon: Icons.error,
              title: "Auth Failed",
              desc:
                  state.errrorMessage ??
                  "Something went wrong while creating your account. Please check your internet connection or try a different email address",
              buttonText: "Okay",
            ),
          );
        }
      },
      builder: (context, state) {
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

            actions: [
              IconButton(
                onPressed: () {
                  context.read<SettingBloc>().add(SettingSuccessEvent());
                },
                icon: Icon(Icons.logout_outlined),
              ),
            ],
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
      },
    );
  }
}
