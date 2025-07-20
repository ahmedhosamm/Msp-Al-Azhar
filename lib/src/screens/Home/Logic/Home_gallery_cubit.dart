import 'package:flutter_bloc/flutter_bloc.dart';
import '../Data/dio_Home.dart';
import 'Home_gallery_state.dart';

class HomeGalleryCubit extends Cubit<HomeGalleryState> {
  final HomeGalleryRepository repository;
  HomeGalleryCubit(this.repository) : super(HomeGalleryInitial());

  void fetchGalleryImages() async {
    emit(HomeGalleryLoading());
    try {
      final images = await repository.fetchGalleryImages();
      emit(HomeGalleryLoaded(images));
    } catch (e) {
      emit(HomeGalleryError(e.toString()));
    }
  }
} 