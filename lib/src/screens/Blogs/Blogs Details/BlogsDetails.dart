import '../../../../style/BaseScreen.dart';
import '../../../../style/Colors.dart';
import '../../../../style/Fonts.dart';
import '../UI/blogs.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import 'package:url_launcher/url_launcher.dart';

class BlogsDetails extends StatelessWidget {
  final Blog blog;
  const BlogsDetails({Key? key, required this.blog}) : super(key: key);

  bool isArabic(String text) {
    final arabicReg = RegExp(r'[\u0600-\u06FF]');
    return arabicReg.hasMatch(text);
  }

  void _launchUrl(BuildContext context, String url) async {
    String fixedUrl = url.trim();
    if (!fixedUrl.startsWith('http')) {
      fixedUrl = 'https://$fixedUrl';
    }
    final uri = Uri.parse(fixedUrl);
    if (await canLaunchUrl(uri)) {
      await launchUrl(uri, mode: LaunchMode.externalApplication);
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('لا يمكن فتح الرابط')),
      );
    }
  }

  List<Map<String, String>> getSocialLinks() {
    return [
      if (blog.linkedin.isNotEmpty)
        {'icon': 'linkedin', 'url': blog.linkedin},
      if (blog.facebook.isNotEmpty)
        {'icon': 'facebook', 'url': blog.facebook},
      if (blog.instagram.isNotEmpty)
        {'icon': 'instagram', 'url': blog.instagram},
    ];
  }

  Widget _buildSocialIcon(String iconName) {
    switch (iconName) {
      case 'linkedin':
        return Image.asset('assets/img/icons/linkedin_Done.png', width: 24, height: 24);
      case 'facebook':
        return Icon(Icons.facebook, size: 24, color: AppColors.primary700);
      case 'instagram':
        return Image.asset('assets/img/icons/instagram_Done.png', width: 24, height: 24);
      default:
        return SizedBox.shrink();
    }
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
          Expanded(
            child: Center(
              child: Text(
                'Blog Details',
                style: AppTexts.heading3Accent.copyWith(color: AppColors.neutral100),
                overflow: TextOverflow.ellipsis,
                maxLines: 1,
              ),
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
              child: SingleChildScrollView(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    ClipRRect(
                      borderRadius: BorderRadius.circular(12),
                      child: Image.network(
                        blog.image,
                        alignment: Alignment.topCenter,
                      ),
                    ),
                    const SizedBox(height: 16),
                    Directionality(
                      textDirection: isArabic(blog.name) ? TextDirection.rtl : TextDirection.ltr,
                      child: Text(
                        blog.name,
                        style: GoogleFonts.cairo(
                          fontSize: 20,
                          fontWeight: FontWeight.w600, // أو FontWeight.bold لو عايز تخليه عريض
                          color: AppColors.neutral1000,           // اللون اللي تحبه
                        ),
                        textAlign: TextAlign.start,
                      ),
                    ),
                    const SizedBox(height: 12),
                    Directionality(
                      textDirection: isArabic(blog.description) ? TextDirection.rtl : TextDirection.ltr,
                      child: Text(
                        blog.description,
                        style: GoogleFonts.cairo(
                          fontSize: 14,
                          fontWeight: FontWeight.w500, // أو FontWeight.bold لو عايز تخليه عريض
                          color: AppColors.neutral600,           // اللون اللي تحبه
                        ),
                        textAlign: TextAlign.start,
                      ),
                    ),
                    const SizedBox(height: 16),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        ...getSocialLinks().map((s) => Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 8.0),
                          child: InkWell(
                            onTap: () => _launchUrl(context, s['url']!),
                            borderRadius: BorderRadius.circular(8),
                            child: Container(
                              decoration: BoxDecoration(
                                border: Border.all(color: AppColors.primary700),
                                borderRadius: BorderRadius.circular(8),
                                color: Colors.white,
                              ),
                              padding: const EdgeInsets.all(12),
                              child: _buildSocialIcon(s['icon']!),
                            ),
                          ),
                        )),
                      ],
                    ),
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
