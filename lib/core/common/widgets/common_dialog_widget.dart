import 'package:flutter/material.dart';

import '../app_const.dart';

class CommonDialogWidget extends StatelessWidget {
  final IconData icon;
  final String title;
  final String desc;
  final String buttonText;
  final VoidCallback onTapEvent;
  final Color iconColor;
  const CommonDialogWidget({
    required this.onTapEvent,
    required this.icon,
    required this.title,
    required this.desc,
    required this.buttonText,
    required this.iconColor,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(10.0),
        side: BorderSide(color: Colors.grey.withValues(alpha: 0.3)),
      ),
      backgroundColor: AppConst.glassmorphicColor,
      content: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisSize: MainAxisSize.min,
        children: [
          SizedBox(height: 10.0),
          Container(
            height: 80,
            width: 80,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(50.0),
              color: AppConst.primaryColor.withValues(alpha: 0.1),
            ),
            child: Icon(icon, size: 50, color: iconColor),
          ),
          SizedBox(height: 30.0),
          Text(
            title,
            style: Theme.of(
              context,
            ).textTheme.displaySmall!.copyWith(color: AppConst.mainTextColor),
          ),
          SizedBox(height: 10.0),
          Text(
            desc,
            style: Theme.of(
              context,
            ).textTheme.titleMedium!.copyWith(color: AppConst.secTextColor),
            textAlign: TextAlign.center,
          ),
          SizedBox(height: 30.0),
          GestureDetector(
            onTap: onTapEvent,
            child: Container(
              padding: const EdgeInsets.all(10.0),
              width: MediaQuery.sizeOf(context).width,
              decoration: BoxDecoration(
                color: AppConst.primaryColor,
                borderRadius: BorderRadius.circular(10.0),
                border: Border.all(color: Colors.grey.withValues(alpha: 0.3)),
              ),
              child: Row(
                mainAxisAlignment: .center,
                crossAxisAlignment: .center,
                children: [
                  Text(
                    buttonText,
                    style: Theme.of(context).textTheme.titleMedium!.copyWith(
                      color: Colors.black,
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
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
