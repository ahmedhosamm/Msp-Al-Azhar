import 'package:flutter/material.dart';
import '../../../../../style/BaseScreen.dart';
import '../../../../../style/Colors.dart';
import '../../../../../style/CustomAppBar.dart';
import '../../../../../style/Fonts.dart';

class MembersFeedbackScreen extends StatelessWidget {
  const MembersFeedbackScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: AppColors.neutral100,
        body: SafeArea(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const CustomAppBar(title: 'Member’s Feedback'),
              Expanded(
                child: BaseScreen(
                  child: Center(
                    child: Text(
                      'Member’s Feedback Content Here',
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
