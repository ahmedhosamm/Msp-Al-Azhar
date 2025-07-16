import 'dart:async';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../../../../style/Colors.dart';
import '../../../../style/Fonts.dart';
import '../Onboarding/Onboarding Screen.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

// Bloc States
abstract class SplashState {}
class SplashInitial extends SplashState {}
class SplashNavigate extends SplashState {
  final Widget nextScreen;
  SplashNavigate(this.nextScreen);
}

// Bloc Cubit
class SplashCubit extends Cubit<SplashState> {
  SplashCubit() : super(SplashInitial());

  Future<void> startSplash() async {
    await Future.delayed(const Duration(seconds: 3));
    final prefs = await SharedPreferences.getInstance();
    final hasSeenOnboarding = prefs.getBool('hasSeenOnboarding') ?? false;
    final isLoggedIn = prefs.getBool('is_logged_in') ?? false;
    Widget nextScreen;
    if (!hasSeenOnboarding) {
      await prefs.setBool('hasSeenOnboarding', true);
      nextScreen = Onboarding();
    } else if (isLoggedIn) {
      nextScreen = Onboarding();
    } else {
      nextScreen = Onboarding();
    }
    emit(SplashNavigate(nextScreen));
  }
}

class SplashScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => SplashCubit()..startSplash(),
      child: BlocListener<SplashCubit, SplashState>(
        listener: (context, state) {
          if (state is SplashNavigate) {
            Navigator.pushReplacement(
              context,
              MaterialPageRoute(builder: (_) => state.nextScreen),
            );
          }
        },
        child: Scaffold(
          backgroundColor: AppColors.primary700,
          body: Center(
            child: FadeTransition(
              opacity: AlwaysStoppedAnimation(1.0),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Container(
                    width: 150,
                    height: 150,
                    decoration: BoxDecoration(
                      image: DecorationImage(
                        image: AssetImage('assets/img/MSPLogo.png'),
                      ),
                    ),
                  ),
                  Text(
                    "Welcome To MSP",
                    style: AppTexts.heading2Bold.copyWith(
                      color: AppColors.neutral100,
                    ),
                  ),
                  const SizedBox(height: 16),
                  Text(
                    "program initiated in 2001 by Microsoft",
                    style: AppTexts.contentEmphasis.copyWith(
                      color: AppColors.neutral100,
                    ),
                    textAlign: TextAlign.center,
                  ),
                ],
              ),
            ),
          ),
          bottomNavigationBar: Padding(
            padding: const EdgeInsets.only(bottom: 40),
            child: CircularProgressIndicator(
              valueColor: AlwaysStoppedAnimation<Color>(AppColors.neutral100),
            ),
          ),
        ),
      ),
    );
  }
}
