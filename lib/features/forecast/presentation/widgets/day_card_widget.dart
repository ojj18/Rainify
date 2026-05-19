import 'package:flutter/material.dart';

import '../../../../core/common/app_const.dart';
import '../../../../core/common/common_function.dart';
import '../../data/model/forecast_model.dart';

class DayCardWidget extends StatelessWidget {
  final Forecastday forecastday;
  const DayCardWidget({required this.forecastday, super.key});

  @override
  Widget build(BuildContext context) {
    return Card(
      child: Padding(
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
                        style: Theme.of(context).textTheme.titleSmall!.copyWith(
                          fontSize: 10.0,
                          color: AppConst.primaryColor,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                  ],
                ),

                const SizedBox(width: 20.0),

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
                        style: Theme.of(context).textTheme.titleSmall!.copyWith(
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
    );
  }
}
