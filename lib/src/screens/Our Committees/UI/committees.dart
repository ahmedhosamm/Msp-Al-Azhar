import 'package:flutter/material.dart';
import '../../../../style/BaseScreen.dart';
import '../../../../style/Colors.dart';
import '../../../../style/Fonts.dart';
import '../../../../style/CustomAppBar.dart';

class OurCommitteesScreen extends StatelessWidget {
  const OurCommitteesScreen({Key? key}) : super(key: key);

  String _getCommitteeImage(int index) {
    switch (index) {
      case 0:
        return 'assets/img/icons/Home Developers.png';
      case 1:
        return 'assets/img/icons/Home Human resources ( HR ).png';
      case 2:
        return 'assets/img/icons/Public relations  ( PR ) Home.png';
      case 3:
        return 'assets/img/icons/Marketing Home.png';
      default:
        return 'assets/img/icons/Marketing Home.png';
    }
  }

  String _getCommitteeName(int index) {
    switch (index) {
      case 0:
        return 'Developers';
      case 1:
        return 'Human resources ( HR )';
      case 2:
        return 'Public relations ( PR )';
      case 3:
        return 'Marketing';
      default:
        return 'Marketing';
    }
  }

  String _getCommitteeDescription(int index) {
    switch (index) {
      case 0:
        return 'Technical development and programming team responsible for building digital solutions and applications.';
      case 1:
        return 'Human resources management team handling recruitment, training, and team development.';
      case 2:
        return 'Public relations team managing communications, events, and external relationships.';
      case 3:
        return 'Marketing team responsible for branding, campaigns, and promotional activities.';
      default:
        return 'Marketing team responsible for branding, campaigns, and promotional activities.';
    }
  }

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
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Explore Our Committees',
                      style: AppTexts.heading2Bold.copyWith(
                        color: AppColors.neutral900,
                      ),
                    ),
                    const SizedBox(height: 8),
                    Text(
                      'Discover the different teams that make MSP Al-Azhar successful',
                      style: AppTexts.contentRegular.copyWith(
                        color: AppColors.neutral600,
                      ),
                    ),
                    const SizedBox(height: 24),
                    Expanded(
                      child: GridView.builder(
                        gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                          crossAxisCount: 2,
                          crossAxisSpacing: 16,
                          mainAxisSpacing: 16,
                          childAspectRatio: 0.85,
                        ),
                        itemCount: 4,
                        itemBuilder: (context, index) {
                          return _buildCommitteeCard(index);
                        },
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildCommitteeCard(int index) {
    return Container(
      decoration: BoxDecoration(
        color: AppColors.neutral100,
        borderRadius: BorderRadius.circular(12),
        border: Border.all(
          color: AppColors.neutral300,
          width: 1,
        ),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.05),
            blurRadius: 8,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Container(
              width: 80,
              height: 80,
              decoration: BoxDecoration(
                color: AppColors.primary100,
                borderRadius: BorderRadius.circular(12),
              ),
              child: Padding(
                padding: const EdgeInsets.all(16),
                child: Image.asset(
                  _getCommitteeImage(index),
                  fit: BoxFit.contain,
                  errorBuilder: (context, error, stackTrace) {
                    return Icon(
                      Icons.group,
                      color: AppColors.primary700,
                      size: 32,
                    );
                  },
                ),
              ),
            ),
            const SizedBox(height: 12),
            Text(
              _getCommitteeName(index),
              style: AppTexts.featureEmphasis.copyWith(
                color: AppColors.neutral900,
              ),
              textAlign: TextAlign.center,
              maxLines: 2,
              overflow: TextOverflow.ellipsis,
            ),
            const SizedBox(height: 8),
            Text(
              _getCommitteeDescription(index),
              style: AppTexts.captionRegular.copyWith(
                color: AppColors.neutral600,
              ),
              textAlign: TextAlign.center,
              maxLines: 3,
              overflow: TextOverflow.ellipsis,
            ),
          ],
        ),
      ),
    );
  }
}
