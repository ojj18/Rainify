import 'package:flutter/material.dart';
import 'package:rainify/core/common/app_const.dart';

class NotificationWidget extends StatefulWidget {
  const NotificationWidget({super.key});

  @override
  State<NotificationWidget> createState() => _NotificationWidgetState();
}

class _NotificationWidgetState extends State<NotificationWidget> {
  bool isAlert = true;
  bool isSummaries = true;
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20.0),
      child: Column(
        mainAxisAlignment: .start,
        crossAxisAlignment: .start,
        children: [
          const SizedBox(height: 20.0),
          Text(
            "Notification".toUpperCase(),
            style: Theme.of(context).textTheme.titleMedium!.copyWith(
              fontWeight: FontWeight.bold,
              letterSpacing: 0,
            ),
          ),
          const SizedBox(height: 10.0),
          Card(
            child: Column(
              mainAxisAlignment: .start,
              crossAxisAlignment: .start,
              children: [
                Padding(
                  padding: const EdgeInsetsGeometry.symmetric(
                    horizontal: 20.0,
                    vertical: 20.0,
                  ),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Expanded(
                        child: Column(
                          mainAxisAlignment: .start,
                          crossAxisAlignment: .start,
                          children: [
                            Text(
                              "Severe Weather Alert",
                              style: Theme.of(context).textTheme.displayMedium!
                                  .copyWith(
                                    fontSize: 16,
                                    fontWeight: FontWeight.bold,
                                  ),
                            ),
                            const SizedBox(height: 5),
                            Text(
                              "Instant push alerts for emergency conditionss",
                              style: Theme.of(
                                context,
                              ).textTheme.titleMedium!.copyWith(fontSize: 12),
                            ),
                          ],
                        ),
                      ),
                      Switch(
                        trackColor: WidgetStatePropertyAll(
                          AppConst.primaryColor,
                        ),
                        trackOutlineColor: WidgetStatePropertyAll(
                          AppConst.primaryColor,
                        ),
                        thumbColor: WidgetStatePropertyAll(Colors.white),
                        value: isAlert,
                        onChanged: (value) {
                          isAlert = value;
                          setState(() {});
                        },
                      ),
                    ],
                  ),
                ),
                Divider(),
                Padding(
                  padding: const EdgeInsetsGeometry.symmetric(
                    horizontal: 20.0,
                    vertical: 20.0,
                  ),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Expanded(
                        child: Column(
                          mainAxisAlignment: .start,
                          crossAxisAlignment: .start,
                          children: [
                            Text(
                              "Daily Summaries",
                              style: Theme.of(context).textTheme.displayMedium!
                                  .copyWith(
                                    fontSize: 16,
                                    fontWeight: FontWeight.bold,
                                  ),
                            ),
                            const SizedBox(height: 5),
                            Text(
                              "Receive a morning forecast overview",
                              style: Theme.of(
                                context,
                              ).textTheme.titleMedium!.copyWith(fontSize: 12),
                            ),
                          ],
                        ),
                      ),
                      Switch(
                        trackColor: WidgetStatePropertyAll(
                          AppConst.primaryColor,
                        ),
                        trackOutlineColor: WidgetStatePropertyAll(
                          AppConst.primaryColor,
                        ),
                        thumbColor: WidgetStatePropertyAll(Colors.white),
                        value: isSummaries,
                        onChanged: (value) {
                          isSummaries = value;
                          setState(() {});
                        },
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
