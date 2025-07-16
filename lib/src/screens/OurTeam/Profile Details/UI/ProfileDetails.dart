import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:url_launcher/url_launcher.dart';
import '../../../../../style/BaseScreen.dart';
import '../../../../../style/Colors.dart';
import '../../../../../style/Fonts.dart';
import '../profile_details_cubit.dart';
import '../profile_details_state.dart';

class ProfileDetails extends StatefulWidget {
  final String memberId;
  const ProfileDetails({Key? key, required this.memberId}) : super(key: key);

  @override
  State<ProfileDetails> createState() => _ProfileDetailsState();
}

class _ProfileDetailsState extends State<ProfileDetails> with SingleTickerProviderStateMixin {
  late TabController _tabController;

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 2, vsync: this);
    // Fetch member using Cubit
    Future.microtask(() => context.read<ProfileDetailsCubit>().fetchMember(widget.memberId));
  }

  void _launchUrl(String url) async {
    final uri = Uri.parse(url);
    if (await canLaunchUrl(uri)) {
      await launchUrl(uri, mode: LaunchMode.externalApplication);
    }
  }

  Widget buildSocialButton(String icon, String label, String url) {
    IconData? iconData;
    String? asset;
    switch (icon) {
      case 'facebook':
        iconData = Icons.facebook;
        break;
      case 'behance':
        asset = 'assets/img/icons/behance_Done.png';
        break;
      case 'github':
        asset = 'assets/img/icons/Github_Done.png';
        break;
      case 'linktree':
        asset = 'assets/img/icons/linktree_Done.png';
        break;
      case 'gettap':
        asset = 'assets/img/icons/linkgettap_Done.png';
        break;
      case 'linkedin':
        asset = 'assets/img/icons/linkedin_Done.png';
        break;
    }
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 6),
      child: InkWell(
        onTap: () => _launchUrl(url),
        child: Container(
          decoration: BoxDecoration(
            border: Border.all(color: AppColors.neutral600),
            borderRadius: BorderRadius.circular(8),
          ),
          padding: const EdgeInsets.symmetric(vertical: 12, horizontal: 16),
          child: Row(
            children: [
              if (asset != null)
                Image.asset(asset, width: 24, height: 24)
              else if (iconData != null)
                Icon(iconData, color: AppColors.primary700, size: 24),
              const SizedBox(width: 16),
              Text(label, style: const TextStyle(fontSize: 16)),
            ],
          ),
        ),
      ),
    );
  }

  List<Widget> buildContactButtons(Map<String, dynamic> member) {
    final List<Widget> buttons = [];
    if (member['facebook'] != null && member['facebook'].toString().isNotEmpty) {
      buttons.add(buildSocialButton('facebook', 'Facebook', member['facebook']));
    }
    if (member['behanceOrGithub'] != null && member['behanceOrGithub'].toString().isNotEmpty) {
      final url = member['behanceOrGithub'];
      if (url.toLowerCase().contains('behance')) {
        buttons.add(buildSocialButton('behance', 'Behance', url));
      } else if (url.toLowerCase().contains('github')) {
        buttons.add(buildSocialButton('github', 'Github', url));
      } else {
        buttons.add(buildSocialButton('linktree', 'linktree', url));
      }
    }
    if (member['linktree'] != null && member['linktree'].toString().isNotEmpty) {
      final url = member['linktree'];
      final lowerUrl = url.toLowerCase();
      if (lowerUrl.contains('linktree')) {
        buttons.add(buildSocialButton('linktree', 'Linktree', url));
      } else if (lowerUrl.contains('gettap')) {
        buttons.add(buildSocialButton('gettap', 'Personal Profile', url));
      } else {
        buttons.add(buildSocialButton('linktree', 'linktree', url));
      }
    }
    if (member['linkedin'] != null && member['linkedin'].toString().isNotEmpty) {
      buttons.add(buildSocialButton('linkedin', 'linkedin', member['linkedin']));
    }
    return buttons;
  }

  Widget _buildAppBar(BuildContext context, ProfileDetailsState state) {
    String? name;
    bool loading = false;
    if (state is ProfileDetailsLoading) {
      loading = true;
    } else if (state is ProfileDetailsLoaded) {
      name = state.member['name'] ?? '';
    }
    return Container(
      padding: const EdgeInsets.symmetric(vertical: 32, horizontal: 16),
      decoration: BoxDecoration(
        color: AppColors.primary700,
        borderRadius: const BorderRadius.only(
          bottomLeft: Radius.circular(12),
          bottomRight: Radius.circular(12),
        ),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          GestureDetector(
            onTap: () => Navigator.pop(context),
            child: Container(
              width: 50,
              height: 50,
              padding: const EdgeInsets.all(12),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(8),
              ),
              child: Icon(Icons.arrow_back, color: AppColors.primary700),
            ),
          ),
          const SizedBox(width: 12),
          loading
              ? SizedBox(
                  width: 24,
                  height: 24,
                  child: CircularProgressIndicator(
                    color: AppColors.neutral100,
                    strokeWidth: 2.5,
                  ),
                )
              : Text(
                  name ?? '',
                  style: AppTexts.heading3Accent.copyWith(
                    color: AppColors.neutral100,
                  ),
                ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => ProfileDetailsCubit()..fetchMember(widget.memberId),
      child: BlocBuilder<ProfileDetailsCubit, ProfileDetailsState>(
        builder: (context, state) {
          return Scaffold(
            backgroundColor: AppColors.neutral100,
            body: Column(
              children: [
                _buildAppBar(context, state),
                Expanded(
                  child: BaseScreen(
                    child: () {
                      if (state is ProfileDetailsLoading) {
                        return const Center(child: CircularProgressIndicator());
                      } else if (state is ProfileDetailsError) {
                        return Center(child: Text(state.message));
                      } else if (state is ProfileDetailsLoaded) {
                        final member = state.member;
                        return Column(
                          children: [
                            Container(
                              width: double.infinity,
                              padding: const EdgeInsets.all(12),
                              decoration: BoxDecoration(
                                border: Border.all(color: AppColors.neutral600),
                                borderRadius: BorderRadius.circular(12),
                                color: Colors.white,
                              ),
                              child: Column(
                                children: [
                                  Container(
                                    width: 75,
                                    height: 75,
                                    decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(8),
                                      border: Border.all(color: AppColors.neutral200, width: 0.5),
                                      image: DecorationImage(
                                        image: NetworkImage(member['image'] ?? ''),
                                        fit: BoxFit.cover,
                                      ),
                                    ),
                                  ),
                                  const SizedBox(height: 12),
                                  Text(
                                    member['name'] ?? '',
                                    style: AppTexts.featureEmphasis,
                                  ),
                                  const SizedBox(height: 4),
                                  Text(
                                    member['track'] ?? '',
                                    style: AppTexts.contentRegular.copyWith(color: AppColors.neutral500),
                                  ),
                                ],
                              ),
                            ),
                            const SizedBox(height: 16),
                            TabBar(
                              controller: _tabController,
                              indicator: UnderlineTabIndicator(
                                borderSide: BorderSide(width: 3.0, color: AppColors.primary700),
                                insets: EdgeInsets.zero,
                              ),
                              labelColor: AppColors.primary700,
                              unselectedLabelColor: AppColors.neutral400,
                              labelStyle: AppTexts.highlightEmphasis,
                              tabs: const [
                                Tab(text: 'About'),
                                Tab(text: 'Contact'),
                              ],
                            ),
                            Expanded(
                              child: TabBarView(
                                controller: _tabController,
                                children: [
                                  // About Tab
                                  Padding(
                                    padding: const EdgeInsets.only(top: 16.0),
                                    child: Align(
                                      alignment: Alignment.topLeft,
                                      child: Text(
                                        member['description'] ?? '',
                                        style: AppTexts.highlightEmphasis,
                                      ),
                                    ),
                                  ),
                                  // Contact Tab
                                  Padding(
                                    padding: const EdgeInsets.only(top: 16.0),
                                    child: Column(
                                      crossAxisAlignment: CrossAxisAlignment.stretch,
                                      children: buildContactButtons(member),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ],
                        );
                      }
                      return const SizedBox();
                    }(),
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
