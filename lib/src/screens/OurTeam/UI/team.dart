import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';
import '../../../../style/Colors.dart';
import '../../../../style/Fonts.dart';

class TeamScreen extends StatelessWidget {
  final List<Map<String, dynamic>> teamMembers = [
    {
      'name': 'Ahmed Hossam Mohamed',
      'position': 'Head Flutter',
      'desc': 'Mid-Level UI-UX | Flutter Developer | Instructor UI-UX | Vice Co-Lead Technical | President @C...',
      'image': 'https://api.msp-alazhar.tech/1741244596407.jpg',
      'social': [
        {'icon': Icons.facebook, 'url': 'https://facebook.com/ahmed.hossam'},
        {'icon': Icons.linkedin, 'url': 'http://linkedin.com/in/ahmed-sherif-2b6132249'},
        {'icon': Icons.web, 'url': 'https://behance.net/ahmedhossam'},
      ]
    },
    {
      'name': 'Mostafa Abdelhakem',
      'position': 'President',
      'desc': 'President @Microsoft Student Partner | Senior Software Engineering Student | Curious Learner',
      'image': 'https://api.msp-alazhar.tech/1741244596407.jpg',
      'social': [
        {'icon': Icons.facebook, 'url': 'https://facebook.com/mostafa.abdelhakem'},
        {'icon': Icons.linkedin, 'url': 'http://linkedin.com/in/mostafa-abdelhakem'},
        {'icon': Icons.web, 'url': 'https://github.com/mostafa-abdelhakem'},
      ]
    },
    {
      'name': 'Ahmed Ali',
      'position': 'Head Flutter',
      'desc': 'Head Flutter @ MSP Al-Zhar | Head Flutter @ Control S Head Flutter | Freelancer Since 2022...',
      'image': 'https://api.msp-alazhar.tech/1741244596407.jpg',
      'social': [
        {'icon': Icons.facebook, 'url': 'https://facebook.com/ahmed.ali'},
        {'icon': Icons.linkedin, 'url': 'http://linkedin.com/in/ahmed-ali'},
        {'icon': Icons.web, 'url': 'https://github.com/ahmed-ali'},
      ]
    },
  ];

  void _launchUrl(String url) async {
    final uri = Uri.parse(url);
    if (await canLaunchUrl(uri)) {
      await launchUrl(uri, mode: LaunchMode.externalApplication);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Positioned(
          top: 0,
          left: 0,
          right: 0,
          child: Container(
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
                "Our Team",
                style: AppTexts.heading2Bold.copyWith(color: AppColors.neutral100),
              ),
            ),
          ),
        ),
        Padding(
          padding: const EdgeInsets.only(top: 110, left: 8, right: 8),
          child: ListView.separated(
            itemCount: teamMembers.length,
            separatorBuilder: (context, i) => SizedBox(height: 16),
            itemBuilder: (context, i) {
              final member = teamMembers[i];
              return Card(
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(12),
                  side: BorderSide(color: AppColors.neutral600),
                ),
                elevation: 0,
                color: AppColors.neutral100,
                child: Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        children: [
                          CircleAvatar(
                            radius: 28,
                            backgroundImage: NetworkImage(member['image']),
                          ),
                          SizedBox(width: 12),
                          Expanded(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  member['name'],
                                  style: AppTexts.heading3Bold,
                                ),
                                Text(
                                  member['position'],
                                  style: AppTexts.contentAccent,
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                      SizedBox(height: 8),
                      Text(
                        member['desc'],
                        style: AppTexts.contentRegular,
                        maxLines: 2,
                        overflow: TextOverflow.ellipsis,
                      ),
                      SizedBox(height: 12),
                      Row(
                        children: [
                          ...member['social'].map<Widget>((s) => Padding(
                            padding: const EdgeInsets.symmetric(horizontal: 4.0),
                            child: InkWell(
                              onTap: () => _launchUrl(s['url']),
                              child: Container(
                                decoration: BoxDecoration(
                                  border: Border.all(color: AppColors.neutral400),
                                  borderRadius: BorderRadius.circular(4),
                                  color: AppColors.neutral100,
                                ),
                                padding: EdgeInsets.all(8),
                                child: Icon(s['icon'], size: 20, color: AppColors.neutral800),
                              ),
                            ),
                          )),
                          Spacer(),
                          OutlinedButton(
                            style: OutlinedButton.styleFrom(
                              side: BorderSide(color: AppColors.primary700),
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(4),
                              ),
                            ),
                            onPressed: () {},
                            child: Text(
                              'More Details',
                              style: AppTexts.contentAccent.copyWith(color: AppColors.primary700),
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              );
            },
          ),
        ),
      ],
    );
  }
}
