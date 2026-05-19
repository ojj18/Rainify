import 'package:flutter/material.dart';

import '../app_const.dart';

class UnderConstructionWidget extends StatelessWidget {
  const UnderConstructionWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return CustomScrollView(
      slivers: [
        SliverFillRemaining(
          hasScrollBody: false,
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 50.0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Icon(Icons.construction_outlined, size: 120),
                SizedBox(height: 30.0),
                Text(
                  "Under construction.",
                  style: Theme.of(context).textTheme.displaySmall!.copyWith(
                    color: AppConst.mainTextColor,
                  ),
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }
}
