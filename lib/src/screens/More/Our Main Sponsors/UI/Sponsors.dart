import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../../../style/BaseScreen.dart';
import '../../../../../style/Colors.dart';
import '../../../../../style/Fonts.dart';
import '../../../../../style/CustomAppBar.dart';
import '../Data/dio_Sponsors.dart';
import '../Logic/Sponsors_cubit.dart';
import '../Logic/Sponsors_state.dart';


class OurMainSponsorsScreen extends StatelessWidget {
  const OurMainSponsorsScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => SponsorsCubit(SponsorsRepository())..fetchSponsors(),
      child: Scaffold(
        backgroundColor: AppColors.neutral100,
        body: SafeArea(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const CustomAppBar(title: 'Our Main Sponsors'),
              Expanded(
                child: BaseScreen(
                child: BlocBuilder<SponsorsCubit, SponsorsState>(
                  builder: (context, state) {
                    if (state is SponsorsLoading) {
                      return const Center(child: CircularProgressIndicator());
                    } else if (state is SponsorsFailure) {
                      return Center(child: Text(state.error, style: AppTexts.highlightEmphasis));
                    } else if (state is SponsorsSuccess) {
                      final sponsors = state.sponsors;
                      if (sponsors.isEmpty) {
                        return const Center(child: Text('No sponsors found'));
                      }
                      return RefreshIndicator(
                        onRefresh: () async {
                          context.read<SponsorsCubit>().fetchSponsors();
                        },
                        child: GridView.builder(
                          padding: EdgeInsets.zero,
                          gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                            crossAxisCount: 2,
                            crossAxisSpacing: 12,
                            mainAxisSpacing: 12,
                            childAspectRatio: 1,
                          ),
                          itemCount: sponsors.length,
                          itemBuilder: (context, index) {
                            final sponsor = sponsors[index];
                            return Card(
                              elevation: 2,
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(12),
                                side: BorderSide(
                                  color: AppColors.neutral400, // لون الشادو/الحد
                                  width: 1,
                                ),
                              ),
                              child: Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: ClipRRect(
                                  borderRadius: BorderRadius.circular(8),
                                  child: Image.network(
                                    sponsor.imageUrl,
                                    fit: BoxFit.cover,
                                    width: double.infinity,
                                    height: double.infinity,
                                    errorBuilder: (context, error, stackTrace) => const Icon(Icons.broken_image, size: 48),
                                  ),
                                ),
                              ),
                            );
                          },
                        ),
                      );
                    }
                    return const SizedBox.shrink();
                  },
                ),
                )
              ),
            ]
          ),
        ),
      ),
    );
  }
}
