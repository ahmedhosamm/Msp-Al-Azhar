import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:card_swiper/card_swiper.dart';
import 'package:url_launcher/url_launcher.dart';

import '../../../../main.dart';
import '../../../../style/BaseScreen.dart';
import '../../../../style/Colors.dart';
import '../../../../style/Fonts.dart';
import '../../OurTeam/UI/team.dart';
import '../../Search/UI/search_screen.dart';
import '../../More/Explore Our Gallery/UI/Gallery.dart';
import '../../Our Committees/UI/committees.dart';
import '../../OurTeam/Profile Details/UI/ProfileDetails.dart';
import '../Data/dio_Home.dart';
import '../Logic/Home_cubit.dart';
import '../Logic/Home_state.dart' hide HomeState;
import '../Logic/Home_gallery_cubit.dart';
import '../Logic/Home_gallery_state.dart';
import '../../OurTeam/Logic/Team_cubit.dart';
import '../../OurTeam/Logic/Team_state.dart';
import '../../OurTeam/Data/dio_Team.dart';

class HomeScreen extends StatefulWidget {
  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  int _currentImageIndex = 0;

  void _launchUrl(String url) async {
    final uri = Uri.parse(url);
    if (await canLaunchUrl(uri)) {
      await launchUrl(uri, mode: LaunchMode.externalApplication);
    }
  }

  String _getCommitteeImage(int index) {
    switch (index) {
      case 0:
        return 'assets/img/icons/Home Developers.png';
      case 1:
        return 'assets/img/icons/Home Human resources ( HR ).png';
      case 2:
        return 'assets/img/icons/Public relations  ( PR ) Home.png';
      case 3:
        return 'assets/img/icons/Marketing Home.png';
      default:
        return 'assets/img/icons/Marketing Home.png';
    }
  }

  String _getCommitteeName(int index) {
    switch (index) {
      case 0:
        return 'Developers';
      case 1:
        return 'Human resources ( HR )';
      case 2:
        return 'Public relations ( PR )';
      case 3:
        return 'Marketing';
      default:
        return 'Marketing';
    }
  }
  Widget _buildHeader() {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: AppColors.primary700,
        borderRadius: const BorderRadius.only(
          bottomLeft: Radius.circular(12),
          bottomRight: Radius.circular(12),
        ),
      ),
      child: Row(
        children: [
          // Profile Picture
          Container(
            width: 54,
            height: 54,
            decoration: BoxDecoration(
              color: AppColors.neutral100,
              borderRadius: BorderRadius.circular(4), // <-- زوايا مستديرة
              image: const DecorationImage(
                image: AssetImage('assets/img/Logo.png'),
                fit: BoxFit.cover,
              ),
            ),
          ),
          const SizedBox(width: 12),
          // User Info
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Hello to MSP AI-Azhar 👋',
                  style: AppTexts.heading3Bold.copyWith(
                    color: AppColors.neutral100,
                  ),
                  overflow: TextOverflow.ellipsis,
                ),
                const SizedBox(height: 4),
                Text(
                  'Best Student Digital Education Agency',
                  style: AppTexts.captionRegular.copyWith(
                    color: Colors.white.withOpacity(0.8),
                  ),
                  overflow: TextOverflow.ellipsis,
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
  Widget _buildSearchBar(BuildContext context) {
    return GestureDetector(
      onTap: () {
        Navigator.of(context).push(
          MaterialPageRoute(
            builder: (context) => const SearchScreen(),
          ),
        );
      },
      child: Container(
        decoration: BoxDecoration(
          color: AppColors.neutral100,
          borderRadius: BorderRadius.circular(12),
          border: Border.all(color: AppColors.neutral600, width: 1),
        ),
        child: TextField(
          enabled: false, // Make it read-only
          style: AppTexts.heading3Accent.copyWith(color: AppColors.neutral1000),
          decoration: InputDecoration(
            hintText: 'Search for a Blog or Team member...',
            hintStyle: AppTexts.contentRegular.copyWith(color: AppColors.neutral600),
            border: InputBorder.none,
            contentPadding: EdgeInsets.symmetric(horizontal: 12, vertical: 12),
            prefixIcon: Icon(
              Icons.search,
              color: AppColors.neutral600,
              size: 24,
            ),
          ),
        ),
      ),
    );
  }
  Widget _buildSectionHeader(String title, VoidCallback? onViewAll) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Expanded(
          child: Text(
            title,
            style: AppTexts.featureAccent.copyWith(
              color: AppColors.neutral900,
            ),
            overflow: TextOverflow.ellipsis,
          ),
        ),
        if (onViewAll != null)
          GestureDetector(
            onTap: onViewAll,
            child: Text(
              'View All',
              style: AppTexts.contentEmphasis.copyWith(
                color: AppColors.primary700,
                decoration: TextDecoration.underline,
                decorationColor: AppColors.primary700,
              ),
            ),
          ),
      ],
    );
  }
    Widget _buildGallerySection() {
    return BlocBuilder<HomeGalleryCubit, HomeGalleryState>(
      builder: (context, state) {
        return Builder(
          builder: (context) {
            final screenWidth = MediaQuery.of(context).size.width;
            return Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                _buildSectionHeader('Explore Our Gallery', () {
                  Navigator.of(context).push(
                    MaterialPageRoute(
                      builder: (context) => const GalleryScreen(),
                    ),
                  );
                }),
                const SizedBox(height: 12),
                Column(
                  children: [
                    SizedBox(
                      height: 220, // Increased height to accommodate pagination dots
                      child: state is HomeGalleryLoading
                          ? const Center(child: CircularProgressIndicator())
                          : state is HomeGalleryLoaded && state.images.isNotEmpty
                              ? Column(
                                  children: [
                                    Swiper(
                                      layout: SwiperLayout.STACK,
                                      itemWidth: screenWidth - 32.0, // Full width minus padding
                                      itemHeight: 200.0,
                                      onIndexChanged: (index) {
                                        // Update pagination dots when swiper changes
                                        setState(() {
                                          _currentImageIndex = index;
                                        });
                                      },
                                      itemBuilder: (context, index) {
                                    final image = state.images[index];
                                    return Container(
                                      decoration: BoxDecoration(
                                        borderRadius: BorderRadius.circular(12),
                                        border: Border.all(
                                          color: AppColors.neutral400,
                                          width: 1,
                                        ),
                                        boxShadow: [
                                          BoxShadow(
                                            color: Colors.black.withOpacity(0.1),
                                            blurRadius: 8,
                                            offset: const Offset(0, 3),
                                          ),
                                        ],
                                      ),
                                      child: ClipRRect(
                                        borderRadius: BorderRadius.circular(12),
                                        child: Image.network(
                                          image.image,
                                          width: double.infinity,
                                          height: double.infinity,
                                          fit: BoxFit.cover,
                                          alignment: Alignment.center,
                                        ),
                                      ),
                                    );
                                  },
                                  itemCount: 6,
                                ),
                                const SizedBox(height: 12),
                                // Custom pagination dots
                                Row(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: List.generate(6, (index) {
                                    return Container(
                                      margin: const EdgeInsets.symmetric(horizontal: 4),
                                      width: 8,
                                      height: 8,
                                      decoration: BoxDecoration(
                                        shape: BoxShape.circle,
                                        color: index == _currentImageIndex 
                                            ? AppColors.primary700 
                                            : AppColors.neutral300,
                                      ),
                                    );
                                  }),
                                ),
                              ],
                            )
                          : const Center(
                              child: Icon(
                                Icons.image,
                                size: 40,
                                color: Colors.grey,
                              ),
                            ),
                    // Custom pagination dots
                    ),
                  ],
                ),
              ],
            );
          },
        );
      },
    );
  }
  Widget _buildCommitteesGrid() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        _buildSectionHeader('Our Committees', () {
          Navigator.of(context).push(
            MaterialPageRoute(
              builder: (context) => const OurCommitteesScreen(),
            ),
          );
        }),
        const SizedBox(height: 12),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: List.generate(4, (index) {
            return Expanded(
              child: Container(
                margin: const EdgeInsets.symmetric(horizontal: 4),
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Container(
                      width: 60,
                      height: 60,
                      constraints: BoxConstraints(
                        minHeight: 60,
                        maxHeight: 80,
                      ),
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(12),
                      ),
                      child: ClipRRect(
                      borderRadius: BorderRadius.circular(12),
                      child: Image.asset(
                        _getCommitteeImage(index),
                        width: 60,
                        height: 60,
                        fit: BoxFit.cover,
                        errorBuilder: (context, error, stackTrace) {
                          return Container(
                            color: AppColors.primary100,
                            child: Icon(
                              Icons.image,
                              color: AppColors.primary700,
                              size: 28,
                            ),
                          );
                        },
                      ),
                    ),
                    ),
                    const SizedBox(height: 6),
                    Text(
                      _getCommitteeName(index),
                      style: AppTexts.highlightAccent.copyWith(
                        color: AppColors.neutral900,
                        fontSize: 11,
                      ),
                      textAlign: TextAlign.center,
                      overflow: TextOverflow.ellipsis,
                      maxLines: 1,
                    ),
                  ],
                ),
              ),
            );
          }),
        ),
      ],
    );
  }
  Widget _buildTeamProfiles() {
    return BlocBuilder<TeamCubit, TeamState>(
      builder: (context, state) {
        return Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            _buildSectionHeader('Our Team', () {
              Navigator.of(context).pushReplacement(
                MaterialPageRoute(
                  builder: (context) => MyHomePage(title: 'MSP Al-Azhar', initialIndex: 2),
                ),
              );
            }),
            const SizedBox(height: 8),
            if (state is TeamLoading)
              const Center(
                child: CircularProgressIndicator(),
              )
            else if (state is TeamLoaded && state.teamMembers.isNotEmpty)
              SingleChildScrollView(
                scrollDirection: Axis.horizontal,
                child: Row(
                  children: state.teamMembers.take(5).map((member) {
                    return _buildProfileCard(
                      member['name'] ?? 'Unknown',
                      member['track'] ?? 'Member',
                      member['image'] ?? '',
                      member['facebook'] ?? '',
                      member['linkedin'] ?? '',
                      member['behanceOrGithub'] ?? '',
                      member['linktree'] ?? '',
                      member['_id'] ?? '',
                    );
                  }).toList(),
                ),
              )
            else
              const Center(
                child: Padding(
                  padding: EdgeInsets.all(20.0),
                  child: Text('No team members available'),
                ),
              ),
          ],
        );
      },
    );
  }
  Widget _buildProfileCard(String name, String role, String imagePath, String facebook, String linkedin, String behanceOrGithub, String linktree, String memberId) {
    final socialLinks = _getSocialLinks(behanceOrGithub, linktree);
    return GestureDetector(
      onTap: () {
        Navigator.of(context).push(
          MaterialPageRoute(
            builder: (context) => ProfileDetails(memberId: memberId),
          ),
        );
      },
      child: Container(
        width: 165,
        margin: const EdgeInsets.only(right: 12),
        padding: const EdgeInsets.all(12),
        decoration: BoxDecoration(
          color: AppColors.neutral100,
          borderRadius: BorderRadius.circular(12),
          border: Border.all(
            color: AppColors.neutral600,
              width: 1
          ),
        ),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            // Profile Picture
            Container(
              width: 75,
              height: 75,
              child: ClipRRect(
                borderRadius: BorderRadius.circular(6),
                child: imagePath.startsWith('http')
                    ? Image.network(
                        imagePath,
                        fit: BoxFit.cover,
                        alignment: Alignment.topCenter,
                        errorBuilder: (context, error, stackTrace) {
                          return Container(
                            color: AppColors.primary100,
                            child: Icon(
                              Icons.person,
                              color: AppColors.primary700,
                              size: 32,
                            ),
                          );
                        },
                      )
                    : Image.asset(
                        imagePath,
                        fit: BoxFit.cover,
                        alignment: Alignment.topCenter,
                        errorBuilder: (context, error, stackTrace) {
                          return Container(
                            color: AppColors.primary100,
                            child: Icon(
                              Icons.person,
                              color: AppColors.primary700,
                              size: 32,
                            ),
                          );
                        },
                      ),
              ),
            ),
            const SizedBox(height: 8),
            // Name
            Text(
              name,
              style: AppTexts.contentEmphasis.copyWith(
                color: AppColors.neutral900,
              ),
              textAlign: TextAlign.center,
              overflow: TextOverflow.ellipsis,
              maxLines: 1,
            ),
            const SizedBox(height: 4),
            // Role
            Text(
              role,
              style: AppTexts.captionRegular.copyWith(
                color: AppColors.neutral600,
              ),
              textAlign: TextAlign.center,
              overflow: TextOverflow.ellipsis,
              maxLines: 1,
            ),
            const SizedBox(height: 8),
            // Social Icons
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                if (facebook.isNotEmpty)
                  GestureDetector(
                    onTap: () => _launchUrl(facebook),
                    child: _buildSocialIcon('facebook'),
                  ),
                if (linkedin.isNotEmpty)
                  GestureDetector(
                    onTap: () => _launchUrl(linkedin),
                    child: _buildSocialIcon('linkedin'),
                  ),
                ...socialLinks.take(1).map((link) => GestureDetector(
                  onTap: () => _launchUrl(link),
                  child: _buildSocialIcon(_getSocialIconType(link)),
                )),
              ],
            ),
          ],
        ),
      ),
    );
  }

  String _getSocialIconType(String url) {
    final lower = url.toLowerCase();
    if (lower.contains('behance')) {
      return 'behance';
    } else if (lower.contains('github')) {
      return 'github';
    } else if (lower.contains('linktree')) {
      return 'linktree';
    } else if (lower.contains('gettap')) {
      return 'linkgettap';
    }
    return 'web';
  }

  List<String> _getSocialLinks(String behanceOrGithub, String linktree) {
    List<String> links = [];
    
    if (behanceOrGithub.isNotEmpty) {
      links.add(behanceOrGithub);
    }
    
    if (linktree.isNotEmpty) {
      links.add(linktree);
    }
    
    return links;
  }

  Widget _buildSocialIcon(String iconName) {
    String? iconPath;
    IconData? iconData;
    
    switch (iconName) {
      case 'facebook':
        iconData = Icons.facebook;
        break;
      case 'linkedin':
        iconPath = 'assets/img/icons/linkedin.png';
        break;
      case 'behance':
        iconPath = 'assets/img/icons/behance.png';
        break;
      case 'github':
        iconPath = 'assets/img/icons/github.png';
        break;
      case 'linktree':
        iconPath = 'assets/img/icons/linktree.png';
        break;
      case 'linkgettap':
        iconPath = 'assets/img/icons/linkgettap.png';
        break;
      default:
        iconPath = 'assets/img/icons/linktree.png';
    }
    
    return Container(
      width: 32,
      height: 32,
      decoration: BoxDecoration(
        color: AppColors.neutral100,
        borderRadius: BorderRadius.circular(6),
        border: Border.all(
          color: AppColors.neutral1000,
            width: 0.5
        ),
      ),
      child: Padding(
        padding: const EdgeInsets.all(6.0),
        child: iconData != null
            ? Icon(
                iconData,
                color: AppColors.neutral1000,
                size: 18,
              )
            : Image.asset(
                iconPath!,
                width: 20,
                height: 20,
                errorBuilder: (context, error, stackTrace) {
                  return Icon(
                    Icons.link,
                    color: AppColors.neutral1000,
                    size: 18,
                  );
                },
              ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(create: (_) => HomeCubit()..load()),
        BlocProvider(create: (_) => HomeGalleryCubit(HomeGalleryRepository())..fetchGalleryImages()),
        BlocProvider(create: (_) => TeamCubit()..fetchTeamMembers()),
      ],
      child: BlocBuilder<HomeCubit, HomeState>(
        builder: (context, state) {
          return Scaffold(
            backgroundColor: AppColors.neutral100,
            body: SafeArea(
              child: Column(
                children: [
                  _buildHeader(),
                  Expanded(
                    child: BaseScreen(
                      child: RefreshIndicator(
                        color: AppColors.primary700,
                        backgroundColor: AppColors.neutral100,
                        strokeWidth: 3.0,
                        onRefresh: () async {
                          // Refresh all data
                          context.read<HomeCubit>().load();
                          // Refresh gallery data
                          context.read<HomeGalleryCubit>().fetchGalleryImages();
                          // Refresh team data
                          context.read<TeamCubit>().fetchTeamMembers();
                        },
                        child: SingleChildScrollView(
                          child: Column(
                            children: [
                              _buildSearchBar(context),
                              const SizedBox(height: 24),
                              _buildGallerySection(),
                              const SizedBox(height: 24),
                              _buildCommitteesGrid(),
                              const SizedBox(height: 24),
                              _buildTeamProfiles(),
                              const SizedBox(height: 24), // Increased bottom padding
                            ],
                          ),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}
