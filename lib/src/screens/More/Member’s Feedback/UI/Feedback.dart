import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../../../style/BaseScreen.dart';
import '../../../../../style/Colors.dart';
import '../../../../../style/CustomAppBar.dart';
import '../../../../../style/Fonts.dart';
import '../Logic/Feedback_cubit.dart';
import '../Logic/Feedback_state.dart';
import '../Data/dio_Feedback.dart';

class MembersFeedbackScreen extends StatelessWidget {
  const MembersFeedbackScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => FeedbackCubit()..fetchReviews(),
      child: Scaffold(
        backgroundColor: AppColors.neutral100,
        body: SafeArea(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const CustomAppBar(title: 'Member’s Feedback'),
              Expanded(
                child: BaseScreen(
                  child: BlocBuilder<FeedbackCubit, FeedbackState>(
                    builder: (context, state) {
                      if (state is FeedbackLoading) {
                        return const Center(child: CircularProgressIndicator());
                      } else if (state is FeedbackLoaded) {
                        if (state.reviews.isEmpty) {
                          return Center(child: Text('No feedback yet.', style: AppTexts.highlightEmphasis));
                        }
                        return ListView.separated(
                          itemCount: state.reviews.length,
                          separatorBuilder: (_, __) => const SizedBox(height: 24),
                          itemBuilder: (context, index) {
                            final review = state.reviews[index];
                            return FeedbackCard(review: review);
                          },
                        );
                      } else if (state is FeedbackError) {
                        return Center(child: Text(state.message, style: AppTexts.highlightEmphasis));
                      }
                      return const SizedBox.shrink();
                    },
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class FeedbackCard extends StatelessWidget {
  final ReviewModel review;
  const FeedbackCard({Key? key, required this.review}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Card(
      color: AppColors.neutral100,
      margin: EdgeInsets.zero,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(12),
        side: BorderSide(
          color: AppColors.neutral600,
          width: 1,
        ),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: const EdgeInsets.fromLTRB(16, 16, 16, 0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  review.title,
                  style: AppTexts.featureBold,
                ),
                const SizedBox(height: 8),
                Text(
                  review.review,
                  style: AppTexts.highlightEmphasis.copyWith(color: AppColors.neutral600),
                  maxLines: 4,
                  overflow: TextOverflow.ellipsis,
                  textDirection: TextDirection.rtl,
                ),
              ],
            ),
          ),
          const SizedBox(height: 12),
          Container(
            decoration: BoxDecoration(
              color: AppColors.primary700,
              borderRadius: const BorderRadius.only(
                bottomLeft: Radius.circular(12),
                bottomRight: Radius.circular(12),
              ),
            ),
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
            child: Row(
              children: [
                CircleAvatar(
                  radius: 24,
                  backgroundImage: NetworkImage(review.photo),
                  backgroundColor: AppColors.neutral200,
                ),
                const SizedBox(width: 8),
                Expanded(
                  child: Text(
                    review.reviewerName,
                    style: AppTexts.highlightBold.copyWith(color: AppColors.neutral100),
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
