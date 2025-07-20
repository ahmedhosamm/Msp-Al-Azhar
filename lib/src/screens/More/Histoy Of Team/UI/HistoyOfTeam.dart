import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../../style/BaseScreen.dart';
import '../../../../../style/Colors.dart';
import '../../../../../style/Fonts.dart';
import '../../../../../style/CustomAppBar.dart';
import '../Logic/Histoy_cubit.dart';
import '../Logic/Histoy_state.dart';

class HistoyOfTeamScreen extends StatelessWidget {
  const HistoyOfTeamScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => HistoyCubit()..fetchHistory(),
      child: Scaffold(
        backgroundColor: AppColors.neutral100,
        body: SafeArea(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const CustomAppBar(title: 'Histoy Of Team'),
              Expanded(
                child: BaseScreen(
                  child: BlocBuilder<HistoyCubit, HistoyState>(
                    builder: (context, state) {
                      if (state is HistoyLoading) {
                        return const Center(child: CircularProgressIndicator());
                      } else if (state is HistoyLoaded) {
                        final reversedList = state.historyList.reversed.toList();
                        return LayoutBuilder(
                          builder: (context, constraints) {
                            final timelineWidth = 600.0;
                            final timelineCenter = timelineWidth / 2 - 1;
                            return Stack(
                              children: [
                                // الخط الرأسي في خلفية الصفحة كلها
                                Positioned(
                                  left: (constraints.maxWidth - timelineWidth) / 2 + timelineCenter,
                                  top: 0,
                                  bottom: 0,
                                  child: Container(
                                    width: 2,
                                    color: AppColors.primary700.withOpacity(0.5),
                                  ),
                                ),
                                // عناصر التايملاين فوق الخط
                                RefreshIndicator(
                                  onRefresh: () async {
                                    context.read<HistoyCubit>().fetchHistory();
                                  },
                                  child: ListView.separated(
                                    physics: const AlwaysScrollableScrollPhysics(),
                                    itemCount: reversedList.length,
                                    separatorBuilder: (_, __) => const SizedBox(height: 32),
                                    itemBuilder: (context, index) {
                                      final item = reversedList[index];
                                      return Center(
                                        child: SizedBox(
                                          width: timelineWidth,
                                          child: Column(
                                            mainAxisSize: MainAxisSize.min,
                                            children: [
                                              Center(
                                                child: Container(
                                                  padding: const EdgeInsets.symmetric(vertical: 6, horizontal: 24),
                                                  decoration: BoxDecoration(
                                                    color: AppColors.neutral100,
                                                    border: Border.all(color: AppColors.primary700, width: 1),
                                                    borderRadius: BorderRadius.circular(8),
                                                  ),
                                                  child: Text(
                                                    item.date == '2024/2023' ? ' 2024/2023' : item.date,
                                                    style: AppTexts.highlightEmphasis.copyWith(color: AppColors.neutral1000),
                                                  ),
                                                ),
                                              ),
                                              const SizedBox(height: 24),
                                              Center(
                                                child: Container(
                                                  padding: const EdgeInsets.symmetric(vertical: 8, horizontal: 24),
                                                  decoration: BoxDecoration(
                                                    color: AppColors.neutral100,
                                                    border: Border.all(color: AppColors.primary700, width: 1),
                                                    borderRadius: BorderRadius.circular(8),
                                                  ),
                                                  child: Text(
                                                    item.name,
                                                    style: AppTexts.highlightAccent.copyWith(color: AppColors.neutral1000),
                                                  ),
                                                ),
                                              ),
                                              SizedBox(
                                                height: 48,
                                                child: Center(
                                                  child: Stack(
                                                    alignment: Alignment.center,
                                                    children: [
                                                      Container(
                                                        width: 32,
                                                        height: 32,
                                                        decoration: BoxDecoration(
                                                          shape: BoxShape.circle,
                                                          border: Border.all(color: AppColors.primary700, width: 4),
                                                          color: AppColors.neutral100,
                                                        ),
                                                      ),
                                                      Container(
                                                        width: 12,
                                                        height: 12,
                                                        decoration: BoxDecoration(
                                                          shape: BoxShape.circle,
                                                          color: AppColors.primary700,
                                                        ),
                                                      ),
                                                    ],
                                                  ),
                                                ),
                                              ),
                                              Center(
                                                child: Container(
                                                  width: double.infinity,
                                                  margin: const EdgeInsets.symmetric(horizontal: 8),
                                                  padding: const EdgeInsets.symmetric(vertical: 16, horizontal: 12),
                                                  decoration: BoxDecoration(
                                                    color: AppColors.neutral100,
                                                    border: Border.all(color: AppColors.primary700, width: 1),
                                                    borderRadius: BorderRadius.circular(16),
                                                  ),
                                                  child: Column(
                                                    children: [
                                                      Container(
                                                        decoration: BoxDecoration(
                                                          border: Border.all(
                                                            color: AppColors.neutral400,
                                                            width: 1,
                                                          ),
                                                          borderRadius: BorderRadius.circular(12),
                                                        ),
                                                        child: ClipRRect(
                                                          borderRadius: BorderRadius.circular(12),
                                                          child: Image.network(
                                                            item.image,
                                                            width: 70,
                                                            height: 70,
                                                            fit: BoxFit.cover,
                                                          ),
                                                        ),
                                                      ),
                                                      const SizedBox(height: 16),
                                                      Text(
                                                        item.description,
                                                        style: AppTexts.contentEmphasis.copyWith(color: AppColors.neutral900),
                                                        textAlign: TextAlign.center,
                                                      ),
                                                    ],
                                                  ),
                                                ),
                                              ),
                                            ],
                                          ),
                                        ),
                                      );
                                    },
                                  ),
                                ),
                              ],
                            );
                          },
                        );
                      } else if (state is HistoyError) {
                        return Center(child: Text('حدث خطأ: ${state.message}', style: AppTexts.featureAccent));
                      }
                      return const SizedBox();
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
