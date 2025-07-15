import 'package:flutter/material.dart';
import 'package:dio/dio.dart';
import 'package:url_launcher/url_launcher.dart';
import '../../../../../style/BaseScreen.dart';
import '../../../../../style/Colors.dart';
import '../../../../../style/Fonts.dart';


class ProfileDetails extends StatefulWidget {
  final String memberId;
  const ProfileDetails({Key? key, required this.memberId}) : super(key: key);

  @override
  State<ProfileDetails> createState() => _ProfileDetailsState();
}

class _ProfileDetailsState extends State<ProfileDetails> with SingleTickerProviderStateMixin {
  Map<String, dynamic>? member;
  bool loading = true;
  String error = '';
  late TabController _tabController;

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 2, vsync: this);
    fetchMember();
  }

  Future<void> fetchMember() async {
    setState(() { loading = true; error = ''; });
    try {
      final dio = Dio();
      final response = await dio.get('https://api.msp-alazhar.tech/teamMembersClient/get');
      if (response.statusCode == 200 && response.data != null) {
        final results = response.data['results'] as List<dynamic>;
        final found = results.firstWhere((e) => e['_id'] == widget.memberId, orElse: () => null);
        if (found != null) {
          setState(() { member = found; loading = false; });
        } else {
          setState(() { error = 'Member not found'; loading = false; });
        }
      } else {
        setState(() { error = 'Failed to load data'; loading = false; });
      }
    } catch (e) {
      setState(() { error = 'Error: $e'; loading = false; });
    }
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
      case 'linktree':
        asset = 'assets/img/icons/linktree_Done.png';
        break;
      case 'linkedin':
        asset = 'assets/img/icons/linkedin_Done.png';
        break;
      case 'github':
        asset = 'assets/img/icons/github_Done.png';
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
        buttons.add(buildSocialButton('behance', 'Github', url));
      } else {
        buttons.add(buildSocialButton('behance', 'Portfolio', url));
      }
    }
    if (member['linktree'] != null && member['linktree'].toString().isNotEmpty) {
      buttons.add(buildSocialButton('linktree', 'Linktree', member['linktree']));
    }
    if (member['linkedin'] != null && member['linkedin'].toString().isNotEmpty) {
      buttons.add(buildSocialButton('linkedin', 'linkedin', member['linkedin']));
    }
    return buttons;
  }

  Widget _buildAppBar(BuildContext context) {
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
        mainAxisAlignment: MainAxisAlignment.start, // زر الرجوع والعنوان على اليمين
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
              child: Icon(Icons.arrow_back, color: AppColors.primary700), // السهم على اليمين
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
                  member != null ? (member!['name'] ?? '') : '',
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
    return Scaffold(
      backgroundColor: AppColors.neutral100,
      body: Column(
        children: [
          _buildAppBar(context),
          Expanded(
            child: BaseScreen(
              child: loading
                  ? const Center(child: CircularProgressIndicator())
                  : error.isNotEmpty
                      ? Center(child: Text(error))
                      : Column(
                          children: [
                            const SizedBox(height: 16),
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
                                  CircleAvatar(
                                    radius: 40,
                                    backgroundColor: Colors.transparent,
                                    backgroundImage: NetworkImage(member!['image'] ?? ''),
                                  ),
                                  const SizedBox(height: 12),
                                  Text(
                                    member!['name'] ?? '',
                                    style: AppTexts.featureEmphasis,
                                  ),
                                  const SizedBox(height: 4),
                                  Text(
                                    member!['track'] ?? '',
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
                                        member!['description'] ?? '',
                                        style: AppTexts.highlightEmphasis,
                                      ),
                                    ),
                                  ),
                                  // Contact Tab
                                  Padding(
                                    padding: const EdgeInsets.only(top: 16.0),
                                    child: Column(
                                      crossAxisAlignment: CrossAxisAlignment.stretch,
                                      children: buildContactButtons(member!),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ],
                        ),
            ),
          ),
        ],
      ),
    );
  }
}
