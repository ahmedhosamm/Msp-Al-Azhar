import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';
import '../../../../style/Colors.dart';
import '../../../../style/Fonts.dart';
import '../../../../style/BaseScreen.dart';

class TeamScreen extends StatelessWidget {
  final List<Map<String, dynamic>> teamMembers = [
    {"_id": "68271ef64713a0a1f4a1a789", "name": "Ahmed Mabrouk Fawzy", "phone": "49", "track": "PR Head", "linkedin": "https://www.linkedin.com/in/ahmed-el-rubai-22406b277?utm_source=share&utm_campaign=share_via&utm_content=profile&utm_medium=android_app", "facebook": "https://www.facebook.com/profile.php?id=100049298132978", "behanceOrGithub": "", "linktree": "https://linktr.ee/AhmedMabrouk1", "image": "https://api.msp-alazhar.tech/1747394294318.png", "description": "As Head of Public Relations, I specialized in event organization, audience engagement, and crisis management. I lead PR strategies, oversee teams, and enhance the club’s public image through effective communication and community outreach. \r\n", "createdAt": "2025-05-16T11:18:14.335Z", "updatedAt": "2025-05-16T12:43:22.345Z", "__v": 0 },
    {"_id": "67f9370ac0182460f423e224", "name": "Mohamed Ramadan", "phone": "47", "track": "Lead Back-end MSP'25", "linkedin": "https://www.linkedin.com/in/mohamed-ramadan-saudi/", "facebook": "https://wa.me/message/E5LHXSAU6T6NH1", "behanceOrGithub": "https://github.com/MohamedRamadanSaudi", "linktree": "", "image": "https://api.msp-alazhar.tech/1744385802145.jpg", "description": "I Build Software", "createdAt": "2025-04-11T15:36:42.147Z", "updatedAt": "2025-05-13T07:55:19.765Z", "__v": 0 },
    {"_id": "67f5200cc0182460f423d48f", "name": "‏Shahd Sayed", "phone": "46", "track": "Vice Head Developers MSP'25", "linkedin": "https://www.linkedin.com/in/shahd-sayed-2766a7278/?utm_source=share&utm_campaign=share_via&utm_content=profile&utm_medium=android_app", "facebook": "https://www.facebook.com/shahad.sayed.1232?locale=ar_AR", "behanceOrGithub": "https://github.com/Shahd-Sayed", "linktree": "", "image": "https://api.msp-alazhar.tech/1744117772134.jpeg", "description": "CFO At OI ROV TEAM & Full-Stack Web Developer", "createdAt": "2025-04-08T13:09:32.139Z", "updatedAt": "2025-05-13T07:55:13.276Z", "__v": 0 },
    {"_id": "67f52150c0182460f423d4a3", "name": "‏Nada Ewis", "phone": "44", "track": "Vice Head Developers MSP'25", "linkedin": "https://www.linkedin.com/in/nada-ewis-76631924b/", "facebook": "https://www.facebook.com/", "behanceOrGithub": "", "linktree": "", "image": "https://api.msp-alazhar.tech/1744118096619.png", "description": "Student in the faculty of Commerce section at AL- Azhar university.\r\nLeader HR at MSP tech club AL-Azhar University team.", "createdAt": "2025-04-08T13:14:56.645Z", "updatedAt": "2025-05-13T07:55:06.439Z", "__v": 0 },
    {"_id": "681674dac0182460f423f1d1", "name": "‏Ibrahim Ashraf", "phone": "42", "track": "Head Techoons MSP'25", "linkedin": "https://www.linkedin.com/in/ibrahim-ashraf-qassem", "facebook": "https://www.facebook.com/share/1XQ98gjKXm/", "behanceOrGithub": "https://github.com/En-Ibrahim", "linktree": "", "image": "https://api.msp-alazhar.tech/1746302170068.jpeg", "description": "Passionate Backend Java Developer skilled in Spring Boot, Hibernate, and RESTful APIs, with expertise in scalable architecture, database optimization, and seamless API integration.\r\n", "createdAt": "2025-05-03T19:56:10.070Z", "updatedAt": "2025-05-16T02:19:33.513Z", "__v": 0 },
    {"_id": "67f91371c0182460f423e0fb", "name": "Mohammed Gamal", "phone": "41", "track": "Head Marketing MSP'25", "linkedin": "https://www.linkedin.com/in/mohammedgamalmm/", "facebook": "https://www.facebook.com/mohammedgamal.mm", "behanceOrGithub": "", "linktree": "https://link.gettap.co/mohammedgamal.mm", "image": "https://api.msp-alazhar.tech/1744376689738.png", "description": "Hello! I’m Mohamed Gamal, a student in the Psychology Department at Al-Azhar University, with a passion for marketing and business.\r\n\r\n", "createdAt": "2025-04-11T13:04:49.740Z", "updatedAt": "2025-05-13T07:54:10.136Z", "__v": 0 },
    {"_id": "67f8ff4bc0182460f423df76", "name": "Menna Yasser", "phone": "40", "track": "Vice Head Marketing MSP'25", "linkedin": "https://www.linkedin.com/in/menna-yasser-elshabrawi-", "facebook": "https://www.facebook.com/share/18nC5UGMzd/", "behanceOrGithub": "", "linktree": "", "image": "https://api.msp-alazhar.tech/1744371531348.png", "description": "This is Menna Yasser, studied Business Administration from Al-Azhar University. Two years experience in Marketing especially in Social Media Management since Season MPS'24.", "createdAt": "2025-04-11T11:38:51.353Z", "updatedAt": "2025-04-11T13:20:42.410Z", "__v": 0 },
    {"_id": "67f9132ec0182460f423e0f3", "name": "Menna Sayed", "phone": "39", "track": "Vice Head Marketing MSP'25", "linkedin": "https://www.linkedin.com/in/menna-sayed-b9457527b", "facebook": "https://www.facebook.com/share/1FNSz2NwxW/", "behanceOrGithub": "", "linktree": "", "image": "https://api.msp-alazhar.tech/1744566412360.jpg", "description": "Specializing in marketing, specifically content creation.\r\nJoined the MSP team in 2023, in addition to working in several other teams as a Marketing coordinator / Content Creator", "createdAt": "2025-04-11T13:03:42.519Z", "updatedAt": "2025-05-13T07:53:59.713Z", "__v": 0 },
  ];
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

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Container(
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
        Expanded(
          child: BaseScreen(
            child: ListView.separated(
              itemCount: teamMembers.length,
              separatorBuilder: (context, i) => SizedBox(height: 16),
              itemBuilder: (context, i) => _buildTeamCard(teamMembers[i]),
            ),
          ),
        ),
      ],
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
      case 'facebook':
        return Icon(Icons.facebook, size: 18, color: AppColors.neutral800);
      default:
        return Icon(Icons.web, size: 18, color: AppColors.neutral800);
    }
  }

  Widget _buildTeamCard(Map<String, dynamic> member) {
    final socialLinks = [
      if (member['facebook'] != null && member['facebook'].toString().isNotEmpty)
        {'icon': 'facebook', 'url': member['facebook']},
      if (member['linkedin'] != null && member['linkedin'].toString().isNotEmpty)
        {'icon': 'linkedin', 'url': member['linkedin']},
      if (member['behanceOrGithub'] != null && member['behanceOrGithub'].toString().isNotEmpty)
        ..._getBehanceOrGithubIcons(member['behanceOrGithub']),
      if (member['linktree'] != null && member['linktree'].toString().isNotEmpty)
        {'icon': 'linktree', 'url': member['linktree']},
    ].take(3).toList();
    return Card(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(12),
        side: BorderSide(color: AppColors.neutral600),
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
                CircleAvatar(
                  radius: 24,
                  backgroundColor: Colors.transparent,
                  child: ClipOval(
                    child: Image.network(
                      member['image'],
                      width: 56,
                      height: 56,
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
                        border: Border.all(color: AppColors.neutral400),
                        borderRadius: BorderRadius.circular(4),
                        color: AppColors.neutral100,
                      ),
                      padding: EdgeInsets.all(8),
                      child: _buildSocialIcon(s['icon']),
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
  }
}
