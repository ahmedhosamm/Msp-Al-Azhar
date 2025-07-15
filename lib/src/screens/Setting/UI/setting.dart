import 'package:flutter/material.dart';
import '../../../../style/Colors.dart';
import '../../../../style/Fonts.dart';

class SettingScreen extends StatelessWidget {
  Widget _buildAppBar(BuildContext context, String title) {
    return Container(
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
          title,
          style: AppTexts.heading3Accent.copyWith(color: AppColors.neutral100),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.neutral100,
      body: Column(
        children: [
          _buildAppBar(context, 'Settings'),
          Expanded(
            child: Center(child: Text('4', style: TextStyle(fontSize: 48))),
          ),
        ],
      ),
    );
  }
}
