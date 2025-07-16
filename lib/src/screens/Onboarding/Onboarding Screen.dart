import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import '../../../style/Colors.dart';
import '../../../style/Fonts.dart';
import '../Home/UI/home.dart';
import '../../../main.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

// Bloc States
abstract class OnboardingState {}
class OnboardingInitial extends OnboardingState {
  final int currentIndex;
  OnboardingInitial(this.currentIndex);
}
class OnboardingNavigate extends OnboardingState {}

// Bloc Cubit
class OnboardingCubit extends Cubit<OnboardingState> {
  final PageController pageController = PageController();
  final int pageCount;
  int currentIndex = 0;
  OnboardingCubit(this.pageCount) : super(OnboardingInitial(0));

  void goToPage(int index) {
    currentIndex = index;
    emit(OnboardingInitial(currentIndex));
  }

  void nextPage() {
    if (currentIndex < pageCount - 1) {
      currentIndex++;
      pageController.nextPage(duration: const Duration(milliseconds: 300), curve: Curves.easeInOutExpo);
      emit(OnboardingInitial(currentIndex));
    } else {
      emit(OnboardingNavigate());
    }
  }

  void previousPage() {
    if (currentIndex > 0) {
      currentIndex--;
      pageController.previousPage(duration: const Duration(milliseconds: 300), curve: Curves.easeInOutExpo);
      emit(OnboardingInitial(currentIndex));
    }
  }
}

class Onboarding extends StatelessWidget {
  const Onboarding({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final List<OnboardingPage> pages = [
      OnboardingPage(
        image: "assets/img/1_Onb.png",
        title: "Welcome To",
        subtitle: "MSP",
        description: "Passionate people with vision working together to build real impact.",
      ),
      OnboardingPage(
        image: "assets/img/2_Onb.png",
        title: "Meet Our",
        subtitle: "Team",
        description: "Passionate people with vision working together to build real impact.",
      ),
      OnboardingPage(
        image: "assets/img/3_Onb.png",
        title: "Join to Our",
        subtitle: "Committees",
        description: "Start your path, gain new skills, and grow with MSP in every step."
      ),
    ];
    return BlocProvider(
      create: (_) => OnboardingCubit(pages.length),
      child: BlocConsumer<OnboardingCubit, OnboardingState>(
        listener: (context, state) {
          if (state is OnboardingNavigate) {
            Navigator.pushReplacement(
              context,
              MaterialPageRoute(builder: (_) => MyHomePage(title: 'Flutter Demo Home Page')),
            );
          }
        },
        builder: (context, state) {
          final cubit = context.read<OnboardingCubit>();
          int currentIndex = 0;
          if (state is OnboardingInitial) {
            currentIndex = state.currentIndex;
          }
          final size = MediaQuery.of(context).size;
          final isSmallScreen = size.height < 700;
          return Directionality(
            textDirection: TextDirection.ltr,
            child: Scaffold(
              backgroundColor: AppColors.neutral100,
              appBar: AppBar(
                backgroundColor: AppColors.neutral100,
                elevation: 0,
                actions: <Widget>[
                  if (currentIndex != 2)
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 18.0),
                      child: TextButton(
                        onPressed: () => cubit.emit(OnboardingNavigate()),
                        child: Text(
                          "Skip",
                          style: AppTexts.highlightAccent.copyWith(
                            color: AppColors.primary700,
                            decoration: TextDecoration.underline,
                            decorationColor: AppColors.primary700,
                          ),
                        ),
                      ),
                    ),
                ],
              ),
              body: PageView.builder(
                controller: cubit.pageController,
                itemCount: pages.length,
                onPageChanged: (index) {
                  cubit.goToPage(index);
                },
                itemBuilder: (context, index) {
                  return _buildPage(context, cubit, pages[index], index, isSmallScreen, currentIndex);
                },
              ),
            ),
          );
        },
      ),
    );
  }

  Widget _buildPage(BuildContext context, OnboardingCubit cubit, OnboardingPage page, int index, bool isSmallScreen, int currentIndex) {
    final pages = cubit.pageCount;
    return Stack(
      alignment: Alignment.bottomCenter,
      children: [
        Positioned.fill(
          child: Image.asset(
            page.image,
            fit: BoxFit.contain,
            scale: isSmallScreen ? 1.0 : 0.8,
          ),
        ),
        Container(
          color: AppColors.neutral100,
          child: IntrinsicHeight(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                LinearProgressIndicator(
                  value: (index + 1) / pages,
                  color: AppColors.primary700,
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 18),
                  child: Column(
                    children: [
                      SizedBox(height: isSmallScreen ? 16 : 32),
                      Text.rich(
                        TextSpan(
                          children: [
                            TextSpan(
                              text: '${page.title} ',
                              style: AppTexts.heading2Accent.copyWith(
                                color: AppColors.neutral1000,
                              ),
                            ),
                            TextSpan(
                              text: page.subtitle,
                              style: AppTexts.heading2Bold.copyWith(
                                color: AppColors.primary700,
                              ),
                            ),
                          ],
                        ),
                        textAlign: TextAlign.center,
                      ),
                      SizedBox(height: isSmallScreen ? 8 : 12),
                      Text(
                        page.description,
                        textAlign: TextAlign.center,
                        style: AppTexts.contentEmphasis.copyWith(
                          color: AppColors.neutral600,
                        ),
                        maxLines: 2,
                        overflow: TextOverflow.ellipsis,
                      ),
                      SizedBox(height: isSmallScreen ? 24 : 32),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: List.generate(pages, (i) {
                          return Container(
                            margin: const EdgeInsets.symmetric(horizontal: 5.0),
                            width: i == currentIndex ? 25 : 10,
                            height: 10,
                            decoration: BoxDecoration(
                              color: i == currentIndex 
                                  ? AppColors.primary700 
                                  : AppColors.primary200,
                              borderRadius: BorderRadius.circular(5.0),
                            ),
                          );
                        }),
                      ),
                      SizedBox(height: isSmallScreen ? 20 : 28),
                      if (index == 1) _buildNavigationButtons(context, cubit) 
                      else _buildSingleButton(context, cubit, index),
                      SizedBox(height: isSmallScreen ? 16 : 24),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildNavigationButtons(BuildContext context, OnboardingCubit cubit) {
    return Row(
      children: [
        Expanded(
          child: ConstrainedBox(
            constraints: const BoxConstraints(
              minWidth: double.infinity,
              minHeight: 54,
            ),
            child: OutlinedButton(
              onPressed: () => cubit.previousPage(),
              style: OutlinedButton.styleFrom(
                side: BorderSide(
                  color: AppColors.primary700,
                  width: 2.0,
                ),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(8),
                ),
              ),
              child: Text(
                "Back",
                style: AppTexts.highlightAccent.copyWith(
                  color: AppColors.primary700,
                  height: 0,
                ),
              ),
            ),
          ),
        ),
        const SizedBox(width: 16),
        Expanded(
          child: ConstrainedBox(
            constraints: const BoxConstraints(
              minWidth: double.infinity,
              minHeight: 54,

            ),
            child: ElevatedButton(
              onPressed: () => cubit.nextPage(),
              style: ButtonStyle(
                backgroundColor: MaterialStateProperty.all(AppColors.primary700),
                shape: MaterialStateProperty.all(
                  RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(8),
                  ),
                ),
              ),
              child: Text(
                "Next",
                style: AppTexts.highlightAccent.copyWith(
                  color: AppColors.neutral100,
                  height: 0,
                ),
              ),
            ),

          ),
        ),
      ],
    );
  }

  Widget _buildSingleButton(BuildContext context, OnboardingCubit cubit, int index) {
    return ConstrainedBox(
      constraints: const BoxConstraints(
        minWidth: double.infinity,
        minHeight: 54,
      ),
      child: ElevatedButton(
        onPressed: () => cubit.nextPage(),
        style: ButtonStyle(
          backgroundColor: MaterialStateProperty.all(AppColors.primary700),
          shape: MaterialStateProperty.all(
            RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(8),
            ),
          ),
        ),
        child: Text(
          index == 2 ? "Let,s Star" : "Next",
          style: AppTexts.highlightAccent.copyWith(
            color: AppColors.neutral100,
            height: 0,
          ),
        ),
      ),

    );
  }
}

class OnboardingPage {
  final String image;
  final String title;
  final String subtitle;
  final String description;

  OnboardingPage({
    required this.image,
    required this.title,
    required this.subtitle,
    required this.description,
  });
}
