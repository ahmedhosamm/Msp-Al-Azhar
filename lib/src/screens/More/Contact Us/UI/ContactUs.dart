import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';

import '../../../../../style/BaseScreen.dart';
import '../../../../../style/Colors.dart';
import '../../../../../style/Fonts.dart';
import '../../../../../style/CustomAppBar.dart';

class ContactUsScreen extends StatelessWidget {
  const ContactUsScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final List<_SocialInfo> socials = [
      _SocialInfo(
        iconPath: 'assets/img/icons/facebook_Icon.png',
        label: 'facebook',
        url: 'https://www.facebook.com/AlAzharTC',
      ),
      _SocialInfo(
        iconPath: 'assets/img/icons/instagram _Icon.png',
        label: 'instagram',
        url: 'https://www.instagram.com/mspalazhar/',
      ),
      _SocialInfo(
        iconPath: 'assets/img/icons/Email_Icon.png',
        label: 'LinkedIn',
        url: 'https://www.linkedin.com/company/msp-tech-club-al-azhar-university/posts/?feedView=all',
      ),
      _SocialInfo(
        iconPath: 'assets/img/icons/Web_Icon.png',
        label: 'Website',
        url: 'https://www.msp-alazhar.tech/',
      ),
      _SocialInfo(
        iconPath: 'assets/img/icons/whatsapp_Icon.png',
        label: 'whatsapp',
        url: 'https://whatsapp.com/channel/0029VbAba19IiRou060LHR0v',
      ),
      _SocialInfo(
        iconPath: 'assets/img/icons/Emial_Icon.png',
        label: 'Email',
        url: 'mailto:msp.alazhar@gmail.com',
      ),
      _SocialInfo(
        iconPath: 'assets/img/icons/Location_Icon.png',
        label: 'Location',
        url: 'https://maps.app.goo.gl/qHWbDFUsjKb6zpuz7',
      ),

    ];
    return Scaffold(
      backgroundColor: AppColors.neutral100,
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const CustomAppBar(title: 'Contact Us'),
          Expanded(
            child: BaseScreen(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  for (int i = 0; i < socials.length; i++) ...[
                    buildSocialButton(socials[i].iconPath, socials[i].label, socials[i].url),
                    if (i != socials.length - 1) const SizedBox(height: 16),
                  ]
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget buildSocialButton(String iconPath, String label, String url) {
    return SizedBox(
      width: double.infinity,
      child: ElevatedButton.icon(
        style: ElevatedButton.styleFrom(
          backgroundColor: AppColors.neutral100,
          foregroundColor: AppColors.primary700,
          side: BorderSide(color: AppColors.primary700),
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
          padding: const EdgeInsets.symmetric(vertical: 12, horizontal: 12),
          alignment: Alignment.centerLeft,
          minimumSize: const Size.fromHeight(0),
        ),
        icon: Image.asset(iconPath, width: 36, height: 36),
        label: Text(label, style: AppTexts.featureStandard),
        onPressed: () async {
          final uri = Uri.parse(url);
          if (await canLaunchUrl(uri)) {
            await launchUrl(uri, mode: LaunchMode.externalApplication);
          }
        },
      ),
    );
  }
}

class _SocialInfo {
  final String iconPath;
  final String label;
  final String url;
  _SocialInfo({required this.iconPath, required this.label, required this.url});
}
