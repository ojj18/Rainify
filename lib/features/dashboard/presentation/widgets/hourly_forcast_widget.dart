import 'package:flutter/material.dart';
import 'package:rainify/features/dashboard/data/model/forcast_main_model.dart';
import '../../../../core/common/app_const.dart';
import '../../../../core/common/common_function.dart';
import '../../data/model/hour_model.dart';

class HourlyForcaseWidget extends StatefulWidget {
  final ForcastModel forcastData;
  const HourlyForcaseWidget({required this.forcastData, super.key});

  @override
  State<HourlyForcaseWidget> createState() => _HourlyForcaseWidgetState();
}

class _HourlyForcaseWidgetState extends State<HourlyForcaseWidget> {
  List<Hour> filteredHours = [];
  @override
  void initState() {
    if (widget.forcastData.forecast!.forecastday!.isNotEmpty) {
      filteredHours = widget.forcastData.forecast!.forecastday!.first.hour!
          .where((item) {
            final itemTime = DateTime.parse(item.time!);

            return itemTime.isAfter(DateTime.now());
          })
          .toList();
    }
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            "Hourly forecast".toUpperCase(),
            style: Theme.of(context).textTheme.titleMedium!.copyWith(
              fontWeight: FontWeight.bold,
              letterSpacing: 0,
            ),
          ),
          const SizedBox(height: 10.0),
          SizedBox(
            height: MediaQuery.sizeOf(context).height * 0.2,
            child: ListView.builder(
              physics: const BouncingScrollPhysics(),
              scrollDirection: Axis.horizontal,
              itemCount: filteredHours.length,
              itemBuilder: (context, index) {
                Hour hourData = filteredHours[index];
                return timeCardWidget(hourData);
              },
            ),
          ),
        ],
      ),
    );
  }

  Widget timeCardWidget(Hour hour) {
    return Card(
      child: Padding(
        padding: const EdgeInsetsGeometry.symmetric(
          horizontal: 20.0,
          vertical: 20.0,
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(timeFormatter(hour.time!)),
            Image.network(
              'https:${hour.condition!.icon!}',
              color: AppConst.primaryColor,
              fit: BoxFit.cover,
              height: 60,
              width: 60,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  hour.tempC.toString(),
                  style: Theme.of(
                    context,
                  ).textTheme.titleSmall!.copyWith(fontSize: 14),
                ),
                const SizedBox(width: 1),
                Align(
                  alignment: Alignment.topCenter,
                  child: Text(
                    "o",
                    style: Theme.of(
                      context,
                    ).textTheme.titleSmall!.copyWith(fontSize: 10.0),
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
