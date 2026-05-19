import 'package:flutter/material.dart';
import 'package:rainify/core/common/app_const.dart';

import '../../../../core/common/common_function.dart';
import '../../data/model/forcast_main_model.dart';
import '../../data/model/forcast_model.dart';

class SevenDaysForcastWidget extends StatefulWidget {
  final ForcastModel forcastData;
  const SevenDaysForcastWidget({required this.forcastData, super.key});

  @override
  State<SevenDaysForcastWidget> createState() => _SevenDaysForcastWidgetState();
}

class _SevenDaysForcastWidgetState extends State<SevenDaysForcastWidget> {
  List<Forecastday> filterDayData = [];

  @override
  void initState() {
    filterDayData = widget.forcastData.forecast!.forecastday!.where((item) {
      return DateTime.parse(item.date!).isAfter(DateTime.now());
    }).toList();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20.0, vertical: 30.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            "7-day forecast".toUpperCase(),
            style: Theme.of(context).textTheme.titleMedium!.copyWith(
              fontWeight: FontWeight.bold,
              letterSpacing: 0,
            ),
          ),
          const SizedBox(height: 10.0),
          Card(
            child: ListView.builder(
              padding: EdgeInsets.zero,
              itemCount: filterDayData.length,
              physics: const NeverScrollableScrollPhysics(),
              shrinkWrap: true,
              itemBuilder: (context, index) {
                Forecastday forecastday = filterDayData[index];
                bool isLastIndex = index == filterDayData.length - 1;

                return Column(
                  children: [forcastWidget(context, forecastday, isLastIndex)],
                );
              },
            ),
          ),
        ],
      ),
    );
  }

  Widget forcastWidget(
    BuildContext context,
    Forecastday forecastday,
    bool isLastIndex,
  ) {
    return Column(
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
              Text(
                dayFormatter(forecastday.date!),
                style: Theme.of(context).textTheme.titleSmall!.copyWith(
                  fontSize: 14,
                  fontWeight: FontWeight.bold,
                ),
              ),
              Image.network(
                'https:${forecastday.day!.condition!.icon!}',
                color: AppConst.primaryColor,
                fit: BoxFit.cover,
                height: 40,
                width: 40,
              ),
              Row(
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        forecastday.day!.maxtempC.toString(),
                        style: Theme.of(context).textTheme.titleSmall!.copyWith(
                          fontSize: 14,
                          color: AppConst.primaryColor,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      const SizedBox(width: 1),
                      Align(
                        alignment: Alignment.topCenter,
                        child: Text(
                          "o",
                          style: Theme.of(context).textTheme.titleSmall!
                              .copyWith(
                                fontSize: 10.0,
                                color: AppConst.primaryColor,
                                fontWeight: FontWeight.bold,
                              ),
                        ),
                      ),
                    ],
                  ),

                  Container(
                    height: 1.5,
                    width: 10,
                    color: AppConst.primaryColor,
                    margin: const EdgeInsets.symmetric(horizontal: 10.0),
                  ),

                  Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        forecastday.day!.mintempC.toString(),
                        style: Theme.of(context).textTheme.titleSmall!.copyWith(
                          fontSize: 14,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      const SizedBox(width: 1),
                      Align(
                        alignment: Alignment.topCenter,
                        child: Text(
                          "o",
                          style: Theme.of(context).textTheme.titleSmall!
                              .copyWith(
                                fontSize: 10.0,
                                fontWeight: FontWeight.bold,
                              ),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ],
          ),
        ),
        if (!isLastIndex)
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20.0),
            child: Divider(),
          ),
      ],
    );
  }
}
