import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../style/Colors.dart';
import '../../../../style/Fonts.dart';

// Bloc States
abstract class HomeState {}
class HomeInitial extends HomeState {}
class HomeLoaded extends HomeState {}

// Bloc Cubit
class HomeCubit extends Cubit<HomeState> {
  HomeCubit() : super(HomeInitial());
  void load() {
    emit(HomeLoaded());
  }
}

class HomeScreen extends StatelessWidget {
  Widget _buildAppBar(BuildContext context, String title) {
    return Container(
      padding: const EdgeInsets.symmetric(vertical: 32, horizontal: 16),
      decoration: BoxDecoration(
        color: AppColors.primary700,
        borderRadius: const BorderRadius.only(
          bottomLeft: Radius.circular(12),
          bottomRight: Radius.circular(12),
        ),
      ),
      child: Center(
        child: Text(
          title,
          style: AppTexts.heading3Accent.copyWith(color: AppColors.neutral100),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => HomeCubit()..load(),
      child: BlocBuilder<HomeCubit, HomeState>(
        builder: (context, state) {
          return Scaffold(
            backgroundColor: AppColors.neutral100,
            body: Column(
              children: [
                _buildAppBar(context, 'Home'),
                Expanded(
                  child: Center(child: Text('1', style: TextStyle(fontSize: 48))),
                ),
              ],
            ),
          );
        },
      ),
    );
  }
}
