import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import '../../../style/Colors.dart';
import '../../../style/Fonts.dart';
import '../Home/UI/home.dart';
import '../../../main.dart';


class Onboarding extends StatefulWidget {
  const Onboarding({Key? key}) : super(key: key);

  @override
  State<Onboarding> createState() => _OnboardingState();
}

class _OnboardingState extends State<Onboarding> {
  final _pageController = PageController();
  int currentIndex = 0;

  final List<OnboardingPage> _pages = [
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

  @override
  Widget build(BuildContext context) {
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
                  onPressed: () => Navigator.push(
                    context,
                    MaterialPageRoute(builder: (_) => MyHomePage(title: 'Flutter Demo Home Page')),
                  ),
                  child: Text(
                    "Skip",
                    style: AppTexts.highlightAccent.copyWith(
                      color: AppColors.primary700,
                      decoration: TextDecoration.underline,
                      decorationColor: AppColors.neutral600,
                    ),
                  ),
                ),
              ),
          ],
        ),
        body: PageView.builder(
          controller: _pageController,
          itemCount: _pages.length,
          onPageChanged: (index) {
            setState(() {
              currentIndex = index;
            });
          },
          itemBuilder: (context, index) {
            return _buildPage(_pages[index], index, isSmallScreen);
          },
        ),
      ),
    );
  }

  Widget _buildPage(OnboardingPage page, int index, bool isSmallScreen) {
    return Stack(
      alignment: Alignment.bottomCenter,
      children: [
        // Image
        Positioned.fill(
          child: Image.asset(
            page.image,
            fit: BoxFit.contain,
            scale: isSmallScreen ? 1.0 : 0.8,
          ),
        ),
        
        // Content Container
        Container(
          color: AppColors.neutral100,
          child: IntrinsicHeight(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                // Progress Indicator
                LinearProgressIndicator(
                  value: (index + 1) / _pages.length,
                  color: AppColors.primary700,
                ),
                
                // Content
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 18),
                  child: Column(
                    children: [
                      SizedBox(height: isSmallScreen ? 16 : 32),
                      
                      // Title
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
                      
                      // Description
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
                      
                      // Page Indicators
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: List.generate(_pages.length, (i) {
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
                      
                      // Navigation Buttons
                      if (index == 1) _buildNavigationButtons() 
                      else _buildSingleButton(index),
                      
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

  Widget _buildNavigationButtons() {
    return Row(
      children: [
        Expanded(
          child: ConstrainedBox(
            constraints: const BoxConstraints(
              minWidth: double.infinity,
              minHeight: 54,
            ),
            child: OutlinedButton(
              onPressed: () {
                _pageController.previousPage(
                  duration: const Duration(milliseconds: 300),
                  curve: Curves.easeInOutExpo,
                );
              },
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
              onPressed: () {
                _pageController.nextPage(
                  duration: const Duration(milliseconds: 300),
                  curve: Curves.easeInOutExpo,
                );
              },
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

  Widget _buildSingleButton(int index) {
    return ConstrainedBox(
      constraints: const BoxConstraints(
        minWidth: double.infinity,
        minHeight: 54,
      ),
      child: ElevatedButton(
        onPressed: () {
          if (index == 2) {
            Navigator.pushReplacement(
              context,
              MaterialPageRoute(builder: (_) => MyHomePage(title: 'Flutter Demo Home Page')),
            );
          } else {
            _pageController.nextPage(
              duration: const Duration(milliseconds: 500),
              curve: Curves.easeInOutExpo,
            );
          }
        },
        style: ButtonStyle(
          backgroundColor: MaterialStateProperty.all(AppColors.primary700),
          shape: MaterialStateProperty.all(
            RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(8),
            ),
          ),
        ),
        child: Text(
          index == 2 ? "Let,s Start" : "Next",
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
