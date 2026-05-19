import 'dart:io';

import 'package:flutter/material.dart';

import '../../data/model/forcast_main_model.dart';

class CurrentDetailsWidget extends StatelessWidget {
  final ForcastModel forcastData;
  const CurrentDetailsWidget({required this.forcastData, super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            "Current details".toUpperCase(),
            style: Theme.of(context).textTheme.titleMedium!.copyWith(
              fontWeight: FontWeight.bold,
              letterSpacing: 0,
            ),
          ),
          const SizedBox(height: 10.0),
          GridView(
            physics: const NeverScrollableScrollPhysics(),
            shrinkWrap: true,
            gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 2,
              crossAxisSpacing: 10.0,
              mainAxisSpacing: 10.0,
              childAspectRatio: Platform.isAndroid ? 1.4 : 1.5,
            ),
            children: [
              getDetailsCard(
                detailIcon: Icons.wb_sunny_outlined,
                detailTitle: "uv index",
                detailValue: forcastData.current!.uv.toString(),
                detailsSymbols: "High",
                context: context,
              ),
              getDetailsCard(
                detailIcon: Icons.visibility_outlined,
                detailTitle: "visibility",
                detailValue: forcastData.current!.visKm.toString(),
                detailsSymbols: "km",
                context: context,
              ),
              getDetailsCard(
                detailIcon: Icons.vertical_align_center,
                detailTitle: "pressure",
                detailValue: forcastData.current!.pressureMb.toString(),
                detailsSymbols: "hPa",
                context: context,
              ),
              getDetailsCard(
                detailIcon: Icons.umbrella_outlined,
                detailTitle: "Rain",
                detailValue: forcastData.current!.chanceForRain.toString(),
                detailsSymbols: "%",
                context: context,
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget getDetailsCard({
    required String detailTitle,
    required IconData detailIcon,
    required String detailValue,
    required String detailsSymbols,
    required BuildContext context,
  }) {
    return Card(
      child: Padding(
        padding: const EdgeInsetsGeometry.symmetric(
          horizontal: 20.0,
          vertical: 20.0,
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            Row(
              crossAxisAlignment: .center,
              children: [
                Icon(detailIcon, size: 18),
                const SizedBox(width: 10.0),
                Text(
                  detailTitle.toUpperCase(),
                  style: Theme.of(context).textTheme.titleMedium!.copyWith(
                    letterSpacing: 0,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ],
            ),
            const SizedBox(height: 15.0),
            Row(
              crossAxisAlignment: .end,
              children: [
                Text(
                  detailValue,
                  style: Theme.of(context).textTheme.titleSmall!.copyWith(
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const SizedBox(width: 10.0),
                Text(
                  detailsSymbols,
                  style: Theme.of(context).textTheme.titleMedium!.copyWith(
                    letterSpacing: 0,
                    fontSize: 16,
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
