import 'package:flutter/material.dart';
import 'Colors.dart';
import 'Fonts.dart';

class CustomAppBar extends StatelessWidget {
  final String title;
  const CustomAppBar({Key? key, required this.title}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(vertical: 32, horizontal: 16),
      decoration: BoxDecoration(
        color: AppColors.primary700,
        borderRadius: const BorderRadius.only(
          bottomLeft: Radius.circular(12),
          bottomRight: Radius.circular(12),
        ),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          GestureDetector(
            onTap: () => Navigator.pop(context),
            child: Container(
              width: 50,
              height: 50,
              padding: const EdgeInsets.all(12),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(8),
              ),
              child: Icon(Icons.arrow_back, color: AppColors.primary700),
            ),
          ),
          const SizedBox(width: 12),
          Expanded(
            child: Text(
              title,
              style: AppTexts.heading3Accent.copyWith(
                color: AppColors.neutral100,
                decoration: TextDecoration.none,
              ),
              overflow: TextOverflow.ellipsis,
              maxLines: 1,
              textAlign: TextAlign.start,
            ),
          ),
        ],
      ),
    );
  }
} 