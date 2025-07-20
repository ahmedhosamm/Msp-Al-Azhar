import 'package:flutter/material.dart';
import '../../../../style/BaseScreen.dart';
import '../../../../style/Colors.dart';
import '../../../../style/Fonts.dart';
import '../../../../style/CustomAppBar.dart';

class OurCommitteesScreen extends StatelessWidget {
  const OurCommitteesScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.neutral100,
      body: SafeArea(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const CustomAppBar(title: 'Our Committees'),
            Expanded(
              child: BaseScreen(
              child: Center(
                child: Text(
                  'Committees content goes here...',
                  style: AppTexts.highlightEmphasis,
                ),
              ),
            ),
          ),
        ],
      ),
    )
    );
  }
}
