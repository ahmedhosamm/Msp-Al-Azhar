import 'package:flutter/material.dart';

import 'Colors.dart';

class BaseScreen extends StatelessWidget {
  final Widget child;
  final EdgeInsets padding;

  const BaseScreen({
    Key? key,
    required this.child,
    this.padding = const EdgeInsets.only(top: 24.0, left: 16.0, right: 16.0),
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.neutral100,
      body: Padding(
        padding: padding,
        child: child,
      ),
    );
  }
}

