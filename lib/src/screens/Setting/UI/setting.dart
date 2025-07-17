import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../../style/Colors.dart';
import '../../../../style/Fonts.dart';
import '../../../../style/BaseScreen.dart';

// Bloc States
abstract class SettingState {}
class SettingInitial extends SettingState {}
class SettingLoaded extends SettingState {}

// Bloc Cubit
class SettingCubit extends Cubit<SettingState> {
  SettingCubit() : super(SettingInitial());
  void load() {
    emit(SettingLoaded());
  }
}

class SettingScreen extends StatelessWidget {
  final List<_SettingItem> items = const [
    _SettingItem(
      title: 'Information about us',
      iconPath: 'assets/img/icons/Information about us.png',
      route: '/about',
    ),
    _SettingItem(
      title: 'Contact Us',
      iconPath: 'assets/img/icons/Contact Us.png',
      route: '/contact',
    ),
    _SettingItem(
      title: 'Help Center',
      iconPath: 'assets/img/icons/Help Center.png',
      route: '/faq',
    ),
    _SettingItem(
      title: 'Invite Friends',
      iconPath: 'assets/img/icons/Invite Friends.png',
      route: '/invite',
    ),
  ];

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

  Widget _buildSettingItem(BuildContext context, _SettingItem item) {
    return InkWell(
      onTap: () {
        // يمكنك إضافة التنقل هنا لاحقًا
        // Navigator.pushNamed(context, item.route);
      },
      child: Row(
        children: [
          Image.asset(
            item.iconPath,
            width: 48,
            height: 48,
          ),
          const SizedBox(width: 12),
          Expanded(
            child: Text(
              item.title,
              style: AppTexts.highlightEmphasis,
            ),
          ),
          Icon(Icons.arrow_forward_ios, size: 18, color: AppColors.primary700),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => SettingCubit()..load(),
      child: BlocBuilder<SettingCubit, SettingState>(
        builder: (context, state) {
          return Column(
            children: [
              _buildAppBar(context, 'Setting'),
              Expanded(
                child: BaseScreen(
                  child: ListView.separated(
                    padding: EdgeInsets.zero,
                    itemCount: items.length,
                    separatorBuilder: (context, index) => Column(
                      children: [
                        const SizedBox(height: 16),
                        Divider(height: 1, color: AppColors.neutral300),
                        const SizedBox(height: 16),
                      ],
                    ),
                    itemBuilder: (context, index) => _buildSettingItem(context, items[index]),
                  ),
                ),
              ),
            ],
          );
        },
      ),
    );
  }
}

class _SettingItem {
  final String title;
  final String iconPath;
  final String route;
  const _SettingItem({required this.title, required this.iconPath, required this.route});
}
