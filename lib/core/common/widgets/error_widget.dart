import 'package:flutter/material.dart';

import '../app_const.dart';

class CommonErrorWidget extends StatelessWidget {
  final VoidCallback onTapEvent;
  const CommonErrorWidget({required this.onTapEvent, super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: CustomScrollView(
        slivers: [
          SliverFillRemaining(
            hasScrollBody: false,
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 50.0),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Icon(Icons.cloud_off_outlined, size: 120),
                  SizedBox(height: 30.0),
                  Text(
                    "Unable to load weather",
                    style: Theme.of(context).textTheme.displaySmall!.copyWith(
                      color: AppConst.mainTextColor,
                    ),
                  ),
                  SizedBox(height: 10.0),
                  Text(
                    "The atmosphere is a bit too cloudy to connect right now. please check your signal.",
                    style: Theme.of(context).textTheme.titleMedium!.copyWith(
                      color: AppConst.secTextColor,
                    ),
                    textAlign: TextAlign.center,
                  ),
                  SizedBox(height: 30.0),
                  GestureDetector(
                    onTap: onTapEvent,
                    child: Container(
                      padding: const EdgeInsets.all(20.0),
                      width: MediaQuery.sizeOf(context).width * 0.3,
                      decoration: BoxDecoration(
                        color: AppConst.glassmorphicColor,
                        borderRadius: BorderRadius.circular(50.0),
                        border: Border.all(
                          color: Colors.grey.withValues(alpha: 0.3),
                        ),
                      ),
                      child: Row(
                        mainAxisAlignment: .center,
                        crossAxisAlignment: .center,
                        children: [
                          Icon(Icons.refresh_outlined, size: 20),
                          const SizedBox(width: 5.5),
                          Text(
                            "Retry",
                            style: Theme.of(context).textTheme.titleMedium!
                                .copyWith(
                                  color: AppConst.mainTextColor,
                                  fontWeight: FontWeight.bold,
                                ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
