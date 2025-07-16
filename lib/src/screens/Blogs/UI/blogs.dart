import 'package:flutter/material.dart';
import '../../../../style/Colors.dart';
import '../../../../style/Fonts.dart';
import '../../../../style/BaseScreen.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../Search/UI/search_screen.dart';
import '../Logic/Blogs_cubit.dart';
import '../Logic/Blogs_state.dart';
import '../Blogs Details/BlogsDetails.dart';
import 'package:google_fonts/google_fonts.dart';

class Blog {
  final String id;
  final String name;
  final String instagram;
  final String linkedin;
  final String facebook;
  final String twitter;
  final String image;
  final String description;
  final DateTime createdAt;

  Blog({
    required this.id,
    required this.name,
    required this.instagram,
    required this.linkedin,
    required this.facebook,
    required this.twitter,
    required this.image,
    required this.description,
    required this.createdAt,
  });
}

class BlogCard extends StatelessWidget {
  final Blog blog;
  const BlogCard({Key? key, required this.blog}) : super(key: key);

  // دالة تحدد إذا كان النص عربي
  bool isArabic(String text) {
    final arabicReg = RegExp(r'[\u0600-\u06FF]');
    return arabicReg.hasMatch(text);
  }

  // دالة تحدد إذا كان النص عربي بالكامل
  bool isPureArabic(String text) {
    final arabicReg = RegExp(r'^[\u0600-\u06FF\s]+\$');
    return arabicReg.hasMatch(text.trim());
  }

  // دالة تحدد إذا كان النص عربي بدءًا بحرف عربي
  bool isArabicStart(String text) {
    final arabicReg = RegExp(r'^[\u0600-\u06FF]');
    return arabicReg.hasMatch(text.trim());
  }

  // دالة لفتح الرابط
  void _launchUrl(BuildContext context, String url) async {
    // تأكد أن الرابط يبدأ بـ https أو http
    String fixedUrl = url.trim();
    if (!fixedUrl.startsWith('http')) {
      fixedUrl = 'https://$fixedUrl';
    }
    final uri = Uri.parse(fixedUrl);
    if (await canLaunchUrl(uri)) {
      await launchUrl(uri, mode: LaunchMode.externalApplication);
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('The link cannot be opened')),
      );
    }
  }
  // ملاحظة: تأكد من إضافة صلاحية الإنترنت في AndroidManifest.xml و LSApplicationQueriesSchemes في Info.plist
  // إذا استمرت المشكلة، جرب فتح الرابط في متصفح خارجي على نفس الجهاز للتأكد من صحة الرابط

  Widget _buildSocialIcon(String iconName) {
    switch (iconName) {
      case 'linkedin':
        return Image.asset('assets/img/icons/linkedin.png', width: 18, height: 18);
      case 'facebook':
        return Icon(Icons.facebook, size: 18, color: AppColors.neutral1000);
      case 'instagram':
        return Image.asset('assets/img/icons/instagram.png', width: 18, height: 18); // استخدم أيقونة انستجرام الحقيقية لو متوفرة
      default:
        return SizedBox.shrink();
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

  String getMonthName(int month) {
    const months = [
      '', 'January', 'February', 'March', 'April', 'May', 'June',
      'July', 'August', 'September', 'October', 'November', 'December'
    ];
    return months[month];
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (_) => BlogsDetails(blog: blog),
          ),
        );
      },
      child: Directionality(
        textDirection: isArabic(blog.name) ? TextDirection.rtl : TextDirection.ltr,
        child: Card(
          margin: EdgeInsets.zero, // إزالة أي مساحة خارجية بين الكروت
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
                Stack(
                  children: [
                    ClipRRect(
                      borderRadius: BorderRadius.circular(8),
                      child: Image.network(
                        blog.image,
                        height: 135,
                        width: double.infinity,
                        fit: BoxFit.cover,
                        alignment: Alignment.topCenter,
                      ),
                    ),
                    Positioned(
                      top: 8,
                      left: 8,
                      child: Container(
                        padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 4),
                        decoration: BoxDecoration(
                          color: AppColors.neutral100,
                          borderRadius: BorderRadius.circular(8),
                          boxShadow: [
                            BoxShadow(
                              color: AppColors.neutral1000,
                              blurRadius: 2,
                            ),
                          ],
                        ),
                        child: Column(
                          children: [
                            Text(
                              blog.createdAt.day.toString(),
                              style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
                            ),
                            Text(
                              getMonthName(blog.createdAt.month),
                              style: const TextStyle(fontSize: 10, color: AppColors.neutral600),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 12),
                Text(
                  blog.name,
                  style: isArabic(blog.name)
                      ? GoogleFonts.cairo(
                          fontSize: 18,
                          fontWeight: FontWeight.w600,
                          color: AppColors.neutral1000,
                        )
                      : AppTexts.highlightBold,
                  textAlign: TextAlign.start,
                  maxLines: 2,
                  overflow: TextOverflow.ellipsis,
                ),
                const SizedBox(height: 4),
                Text(
                  blog.description,
                  maxLines: 2,
                  overflow: TextOverflow.ellipsis,
                  style: isArabic(blog.description)
                      ? GoogleFonts.cairo(
                          fontSize: 14,
                          fontWeight: FontWeight.w400,
                          color: AppColors.neutral600,
                        )
                      : AppTexts.contentRegular.copyWith(color: AppColors.neutral600),
                  textAlign: TextAlign.start,
                ),
                const SizedBox(height: 8),
                Divider(
                  color: AppColors.neutral600,    // اللون
                  thickness: 1,          // السُمك
                ),
                const SizedBox(height: 8),
                Directionality(
                  textDirection: TextDirection.ltr,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      ...getSocialLinks().map((s) => Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 6.0),
                        child: InkWell(
                          onTap: () => _launchUrl(context, s['url']!),
                          child: Container(
                            decoration: BoxDecoration(
                              border: Border.all(color: AppColors.neutral1000),
                              borderRadius: BorderRadius.circular(4),
                              color: AppColors.neutral100,
                            ),
                            padding: const EdgeInsets.all(8),
                            child: _buildSocialIcon(s['icon']!),
                          ),
                        ),
                      )),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

// ويدجت لعرض العنوان والعدد
class SectionCountHeader extends StatelessWidget {
  final String sectionName;
  final int count;
  const SectionCountHeader({required this.sectionName, required this.count, Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                Text(
                  'Results for ',
                  style: AppTexts.featureStandard.copyWith(color: AppColors.neutral600),
                ),
                Text(
                  '"$sectionName"',
                  style: AppTexts.featureEmphasis.copyWith(color: AppColors.primary700),
                ),
              ],
            ),
          ],
        ),
        const Spacer(),
        Text(
          count.toString(),
          style: AppTexts.featureBold.copyWith(color: AppColors.primary700),
        ),
      ],
    );
  }
}

class BlogsScreen extends StatelessWidget {
  const BlogsScreen({Key? key}) : super(key: key);

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
      child: Row(
        children: [
          const SizedBox(width: 40),
          Expanded(
            child: Center(
              child: Text(
                title,
                style: AppTexts.heading3Accent.copyWith(color: AppColors.neutral100),
                overflow: TextOverflow.ellipsis,
                maxLines: 1,
              ),
            ),
          ),
          Container(
            width: 50,
            height: 50,
            padding: const EdgeInsets.all(0),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(8),
            ),
            child: IconButton(
              icon: Icon(Icons.search, color: AppColors.primary700),
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (_) => SearchScreen()),
                );
              },
              iconSize: 24,
              padding: EdgeInsets.zero,
              constraints: BoxConstraints(),
            ),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => BlogsCubit()..fetchBlogs(),
      child: Scaffold(
        backgroundColor: AppColors.neutral100,
        body: Column(
          children: [
            _buildAppBar(context, 'Our Blogs'),
            Expanded(
              child: BaseScreen(
                child: BlocBuilder<BlogsCubit, BlogsState>(
                  builder: (context, state) {
                    return RefreshIndicator(
                      onRefresh: () async {
                        context.read<BlogsCubit>().fetchBlogs();
                      },
                      child: Builder(
                        builder: (context) {
                          if (state is BlogsLoading) {
                            return Center(
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  const CircularProgressIndicator(),
                                  const SizedBox(height: 16),
                                  Text('Loading Blog Posts' ,
                                    style: AppTexts.highlightEmphasis.copyWith(
                                        color: AppColors.neutral1000
                                    ),
                                  ),
                                ],
                              ),
                            );
                          } else if (state is BlogsLoaded) {
                            final blogs = state.blogs;
                            return Column(
                              children: [
                                SectionCountHeader(sectionName: 'Our Blogs', count: blogs.length),
                                SizedBox(height: 12),
                                Expanded(
                                  child: ListView.separated(
                                    padding: EdgeInsets.zero,
                                    itemCount: blogs.length,
                                    itemBuilder: (context, index) => BlogCard(blog: blogs[index]),
                                    separatorBuilder: (context, index) => const SizedBox(height: 16),
                                  ),
                                ),
                              ],
                            );
                          } else if (state is BlogsError) {
                            return Center(
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  SizedBox(
                                    height: 160,
                                    child: Image.asset(
                                      'assets/img/sorry.png',
                                      fit: BoxFit.contain,
                                      errorBuilder: (context, error, stackTrace) => Icon(Icons.error_outline, size: 100, color: AppColors.neutral600),
                                    ),
                                  ),
                                  const SizedBox(height: 24),
                                  Text(
                                    "Sorry, Ce Couldn't Cind Anything",
                                    style: AppTexts.heading3Accent.copyWith(color: AppColors.neutral1000),
                                  ),
                                  const SizedBox(height: 8),
                                  Text(
                                    "There Was A Problem Fetching The Blogs. Please Check Your Internet Connection Or Try Again..",
                                    style: AppTexts.contentRegular.copyWith(color: AppColors.neutral400),
                                    textAlign: TextAlign.center,
                                  ),
                                  const SizedBox(height: 24),
                                  ElevatedButton(
                                    onPressed: () {
                                      context.read<BlogsCubit>().fetchBlogs();
                                    },
                                    style: ElevatedButton.styleFrom(
                                      backgroundColor: AppColors.primary700,
                                      foregroundColor: AppColors.neutral100,
                                      padding: const EdgeInsets.symmetric(horizontal: 32, vertical: 12),
                                      shape: RoundedRectangleBorder(
                                        borderRadius: BorderRadius.circular(8),
                                      ),
                                    ),
                                    child: Text('Refresh', style: AppTexts.featureBold.copyWith(color: AppColors.neutral100)),
                                  ),
                                ],
                              ),
                            );
                          }
                          return const SizedBox();
                        },
                      ),
                    );
                  },
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
