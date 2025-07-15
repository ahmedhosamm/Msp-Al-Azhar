import 'package:flutter/material.dart';
import '../../../../style/Colors.dart';
import '../../../../style/Fonts.dart';

class SettingScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Positioned(
          top: 0,
          left: 0,
          right: 0,
          child: Container(
            padding: const EdgeInsets.symmetric(vertical: 32, horizontal: 16),
            decoration: BoxDecoration(
              color: AppColors.primary700,
              borderRadius: const BorderRadius.only(
                bottomLeft: Radius.circular(12),
                bottomRight: Radius.circular(12),
              ),
            ),
            child: Center(
              child: Text(
                "Settings",
                style: AppTexts.heading2Bold.copyWith(color: AppColors.neutral100),
              ),
            ),
          ),
        ),
        Padding(
          padding: const EdgeInsets.only(top: 110),
          child: Center(child: Text('4', style: TextStyle(fontSize: 48))),
        ),
      ],
    );
  }
}
