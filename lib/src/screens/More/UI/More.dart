import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../../style/Colors.dart';
import '../../../../style/Fonts.dart';
import '../../../../style/BaseScreen.dart';

import '../../Our Committees/UI/committees.dart';
import '../Explore Our Gallery/UI/Gallery.dart';
import '../Information about us/InformationAboutUs.dart';
import '../Histoy Of Team/UI/HistoyOfTeam.dart';
import '../Contact Us/UI/ContactUs.dart';
import '../FAQ/UI/FAQ.dart';
import '../Our Main Sponsors/UI/Sponsors.dart';
import '../../More/Member’s Feedback/UI/Member’s Feedback.dart';
import '../../Search/UI/search_screen.dart';

// Bloc States
abstract class MoreState {}
class MoreInitial extends MoreState {}
class MoreLoaded extends MoreState {}

// Bloc Cubit
class MoreCubit extends Cubit<MoreState> {
  MoreCubit() : super(MoreInitial());
  void load() {
    emit(MoreLoaded());
  }
}

class MoreScreen extends StatelessWidget {
  final List<_MoreItem> items = const [
    _MoreItem(
      title: 'Histoy Of Team',
      iconPath: 'assets/img/icons/Histoy Of Team.png',
      route: '/Histoy Of Team',
    ),
    _MoreItem(
      title: 'Our Committees',
      iconPath: 'assets/img/icons/Our Committees.png',
      route: '/Our Committees',
    ),
    _MoreItem(
      title: 'Our Main Sponsors',
      iconPath: 'assets/img/icons/Our Main Sponsors.png',
      route: '/Our Main Sponsors',
    ),
    _MoreItem(
      title: 'Member’s Feedback',
      iconPath: 'assets/img/icons/Member’s Feedback.png',
      route: '/members_feedback',
    ),
    _MoreItem(
      title: 'Explore Our Gallery',
      iconPath: 'assets/img/icons/Gallery.png',
      route: '/Explore Our Gallery',
    ),
    _MoreItem(
      title: 'Information About Us',
      iconPath: 'assets/img/icons/Information about us.png',
      route: '/about',
    ),
    _MoreItem(
      title: 'Contact Us',
      iconPath: 'assets/img/icons/Contact Us.png',
      route: '/contact',
    ),
    _MoreItem(
      title: 'FAQ',
      iconPath: 'assets/img/icons/Help Center.png',
      route: '/faq',
    ),
    _MoreItem(
      title: 'Invite Friends',
      iconPath: 'assets/img/icons/Invite Friends.png',
      route: '/invite',
    ),
  ];

  Widget _buildAppBar(BuildContext context, String title) {
    return Container(
      padding: const EdgeInsets.symmetric(vertical: 20, horizontal: 16),
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

  Widget _buildMoreItem(BuildContext context, _MoreItem item) {
    return InkWell(
      onTap: () {
        if (item.route == '/about') {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => InformationAboutUsScreen(),
            ),
          );
        } else if (item.route == '/Histoy Of Team') {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => HistoyOfTeamScreen(),
            ),
          );
        } else if (item.route == '/contact') {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => ContactUsScreen(),
            ),
          );
        } else if (item.route == '/faq') {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => FAQScreen(),
            ),
          );
        } else if (item.route == '/Our Committees') {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => OurCommitteesScreen(),
            ),
          );
        } else if (item.route == '/Our Main Sponsors') {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => OurMainSponsorsScreen(),
            ),
          );
        } else if (item.route == '/members_feedback') {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => MembersFeedbackScreen(),
            ),
          );
        } else if (item.title == 'Explore Our Gallery') {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => GalleryScreen(),
            ),
          );
        }
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
      create: (_) => MoreCubit()..load(),
      child: BlocBuilder<MoreCubit, MoreState>(
        builder: (context, state) {
          return SafeArea(
            child: Column(
              children: [
                _buildAppBar(context, 'More'),
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
                    itemBuilder: (context, index) => _buildMoreItem(context, items[index]),
                  ),
                                  ),
                ),
              ],
            ),
          );
        },
      ),
    );
  }
}

class _MoreItem {
  final String title;
  final String iconPath;
  final String route;
  const _MoreItem({required this.title, required this.iconPath, required this.route});
}
