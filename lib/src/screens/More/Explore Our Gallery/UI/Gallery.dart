import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../../../../style/CustomAppBar.dart';
import '../../../../../../style/BaseScreen.dart';
import '../../../../../../style/Colors.dart';
import '../../../../../../style/Fonts.dart';
import '../Data/dio_Gallery.dart';
import '../Logic/Gallery_cubit.dart';
import '../Logic/Gallery_state.dart';

class GalleryScreen extends StatelessWidget {
  const GalleryScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => GalleryCubit(GalleryRepository())..fetchAll(),
      child: const _GalleryBody(),
    );
  }
}

class _GalleryBody extends StatefulWidget {
  const _GalleryBody({Key? key}) : super(key: key);

  @override
  State<_GalleryBody> createState() => _GalleryBodyState();
}

class _GalleryBodyState extends State<_GalleryBody> with SingleTickerProviderStateMixin {
  late TabController _tabController;

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 3, vsync: this);
    _tabController.addListener(() {
      if (_tabController.indexIsChanging) return;
      setState(() {});
      final cubit = context.read<GalleryCubit>();
      switch (_tabController.index) {
        case 0:
          cubit.fetchAll();
          break;
        case 1:
          cubit.fetchEvents();
          break;
        case 2:
          cubit.fetchSessions();
          break;
      }
    });
  }

  @override
  void dispose() {
    _tabController.dispose();
    super.dispose();
  }

  Widget _tabItem({required IconData icon, required String label, required bool selected}) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Icon(icon, color: selected ? AppColors.primary700 : AppColors.neutral700, size: 20),
        const SizedBox(width: 4),
        Text(
          label,
          style: AppTexts.highlightBold.copyWith(
            color: selected ? AppColors.primary700 : AppColors.neutral700,
          ),
        ),
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.neutral100,
      body: SafeArea(
        child: Column(
          children: [
            CustomAppBar(title: 'Explore our Gallery'),
            Expanded(
              child: BaseScreen(
                child: Column(
                  children: [
                    TabBar(
                        controller: _tabController,
                        indicatorColor: AppColors.primary700,
                        indicatorWeight: 3,
                        labelPadding: const EdgeInsets.symmetric(vertical: 0),
                        tabs: [
                          _tabItem(icon: Icons.photo, label: 'All', selected: _tabController.index == 0),
                          _tabItem(icon: Icons.event, label: 'Events', selected: _tabController.index == 1),
                          _tabItem(icon: Icons.group, label: 'Sessions', selected: _tabController.index == 2),
                        ],
                      ),
                    Expanded(
                      child: BlocBuilder<GalleryCubit, GalleryState>(
                        builder: (context, state) {
                          print('GalleryState: ' + state.toString());
                          if (state is GalleryLoading) {
                            return const Center(child: CircularProgressIndicator());
                          } else if (state is GalleryLoaded) {
                            print('Loaded images: ' + state.images.length.toString());
                            if (state.images.isEmpty) {
                              return const Center(child: Text('No images found'));
                            }
                            final images = state.images;
                            return Padding(
                              padding: EdgeInsets.zero,
                              child: RefreshIndicator(
                                onRefresh: () async {
                                  context.read<GalleryCubit>().fetchAll();
                                },
                                child: GridView.builder(
                                  gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                                    crossAxisCount: 2,
                                    crossAxisSpacing: 12,
                                    mainAxisSpacing: 12,
                                    childAspectRatio: 1,
                                  ),
                                  itemCount: images.length,
                                  itemBuilder: (context, index) {
                                    print('IMAGE URL: ${images[index].image}');
                                    return ClipRRect(
                                      borderRadius: BorderRadius.circular(16),
                                      child: Image.network(
                                        images[index].image,
                                        fit: BoxFit.cover,
                                        errorBuilder: (c, e, s) => const Icon(Icons.broken_image),
                                        height: 220,
                                        loadingBuilder: (context, child, loadingProgress) {
                                          if (loadingProgress == null) return child;
                                          return Center(child: CircularProgressIndicator());
                                        },
                                      ),
                                    );
                                  },
                                ),
                              ),
                            );
                          } else if (state is GalleryError) {
                            return Center(child: Text('Error: ${state.message}'));
                          }
                          return const SizedBox();
                        },
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
