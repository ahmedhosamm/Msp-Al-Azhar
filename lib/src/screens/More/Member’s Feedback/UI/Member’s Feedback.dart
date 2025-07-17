import 'package:flutter/material.dart';
import '../../../../../style/CustomAppBar.dart';

class MembersFeedbackScreen extends StatelessWidget {
  const MembersFeedbackScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Column(
        children: const [
          CustomAppBar(title: 'Member’s Feedback'),
          Expanded(
            child: Center(
              child: Text('Member’s Feedback Content Here'),
            ),
          ),
        ],
      ),
    );
  }
}
