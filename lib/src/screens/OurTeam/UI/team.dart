import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:url_launcher/url_launcher.dart';
import '../Logic/Team_cubit.dart';
import '../Logic/Team_state.dart';
import '../../../../style/Colors.dart';
import '../../../../style/Fonts.dart';
import '../../../../style/BaseScreen.dart';
import '../Profile Details/UI/ProfileDetails.dart';

class TeamScreen extends StatelessWidget {
  const TeamScreen({Key? key}) : super(key: key);

  void _launchUrl(String url) async {
    final uri = Uri.parse(url);
    if (await canLaunchUrl(uri)) {
      await launchUrl(uri, mode: LaunchMode.externalApplication);
    }
  }

  List<Map<String, String>> _getBehanceOrGithubIcons(String url) {
    final lower = url.toLowerCase();
    if (lower.contains('behance')) {
      return [
        {'icon': 'behance', 'url': url},
      ];
    } else if (lower.contains('github')) {
      return [
        {'icon': 'github', 'url': url},
      ];
    }
    return [
      {'icon': 'web', 'url': url},
    ];
  }

  List<Map<String, String>> _getLinktreeOrGettapIcons(String url) {
    final lower = url.toLowerCase();
    if (lower.contains('linktree')) {
      return [
        {'icon': 'linktree', 'url': url},
      ];
    } else if (lower.contains('gettap')) {
      return [
        {'icon': 'gettap', 'url': url},
      ];
    }
    return [
      {'icon': 'web', 'url': url},
    ];
  }

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
      create: (_) => TeamCubit()..fetchTeamMembers(),
      child: Column(
        children: [
          _buildAppBar(context, 'Our Team'
          
          ),
          Expanded(
            child: BaseScreen(
              child: BlocBuilder<TeamCubit, TeamState>(
                builder: (context, state) {
                  if (state is TeamLoading) {
                    return const Center(child: CircularProgressIndicator());
                  } else if (state is TeamLoaded) {
                    final teamMembers = state.teamMembers;
                    return ListView.separated(
                      itemCount: teamMembers.length,
                      separatorBuilder: (context, i) => const SizedBox(height: 16),
                      itemBuilder: (context, i) => _buildTeamCard(context, teamMembers[i]),
                    );
                  } else if (state is TeamError) {
                    return Center(child: Text(state.message));
                  }
                  return const SizedBox();
                },
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildSocialIcon(String iconName) {
    switch (iconName) {
      case 'linkedin':
        return Image.asset('assets/img/icons/linkedin.png', width: 18, height: 18);
      case 'linktree':
        return Image.asset('assets/img/icons/linktree.png', width: 18, height: 18);
      case 'behance':
        return Image.asset('assets/img/icons/behance.png', width: 18, height: 18);
      case 'github':
        return Image.asset('assets/img/icons/github.png', width: 18, height: 18);
      case 'gettap':
        return Image.asset('assets/img/icons/linkgettap.png', width: 18, height: 18);
      case 'facebook':
        return Icon(Icons.facebook, size: 18, color: AppColors.neutral800);
      default:
        return Image.asset('assets/img/icons/linktree.png', width: 18, height: 18);
    }
  }

  Widget _buildTeamCard(BuildContext context, Map<String, dynamic> member) {
    final socialLinks = [
      if (member['facebook'] != null && member['facebook'].toString().isNotEmpty)
        {'icon': 'facebook', 'url': member['facebook']},
      if (member['linkedin'] != null && member['linkedin'].toString().isNotEmpty)
        {'icon': 'linkedin', 'url': member['linkedin']},
      if (member['behanceOrGithub'] != null && member['behanceOrGithub'].toString().isNotEmpty)
        ..._getBehanceOrGithubIcons(member['behanceOrGithub']),
      if (member['linktree'] != null && member['linktree'].toString().isNotEmpty)
        ..._getLinktreeOrGettapIcons(member['linktree']),
    ];
    return InkWell(
      borderRadius: BorderRadius.circular(12),
      onTap: () {
        Navigator.of(context).push(
          MaterialPageRoute(
            builder: (_) => ProfileDetails(memberId: member['_id']),
          ),
        );
      },
      child: Card(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(12),
          side: BorderSide(color: AppColors.primary700),
        ),
        elevation: 0,
        color: AppColors.neutral100,
        child: Padding(
          padding: const EdgeInsets.all(12.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                children: [
                  Container(
                    width: 50,
                    height: 50,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(4),
                      border: Border.all(color: AppColors.neutral200, width: 0.5),
                      image: DecorationImage(
                        image: NetworkImage(member['image']),
                        fit: BoxFit.cover,
                        alignment: Alignment.topCenter,
                      ),
                    ),
                  ),
                  SizedBox(width: 12),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          member['name'],
                          style: AppTexts.highlightAccent,
                        ),
                        Text(
                          member['track'],
                          style: AppTexts.contentRegular,
                        ),
                      ],
                    ),
                  ),
                ],
              ),
              SizedBox(height: 12),
              Text(
                member['description'],
                style: AppTexts.contentRegular,
                maxLines: 2,
                overflow: TextOverflow.ellipsis,
              ),
              SizedBox(height: 16),
              Row(
                children: [
                  ...socialLinks.map<Widget>((s) => Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 6.0),
                    child: InkWell(
                      onTap: () => _launchUrl(s['url']!),
                      child: Container(
                        decoration: BoxDecoration(
                          border: Border.all(color: AppColors.neutral1000),
                          borderRadius: BorderRadius.circular(4),
                          color: AppColors.neutral100,
                        ),
                        padding: EdgeInsets.all(8),
                        child: _buildSocialIcon(s['icon']),
                      ),
                    ),
                  )),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
