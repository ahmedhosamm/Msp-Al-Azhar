import 'package:flutter_bloc/flutter_bloc.dart';
import '../Data/dio_Gallery.dart';
import 'Gallery_state.dart';

class GalleryCubit extends Cubit<GalleryState> {
  final GalleryRepository repository;
  GalleryCubit(this.repository) : super(GalleryInitial());

  void fetchAll() async {
    emit(GalleryLoading());
    try {
      final images = await repository.fetchAll();
      emit(GalleryLoaded(images));
    } catch (e) {
      emit(GalleryError(e.toString()));
    }
  }

  void fetchEvents() async {
    emit(GalleryLoading());
    try {
      final images = await repository.fetchEvents();
      emit(GalleryLoaded(images));
    } catch (e) {
      emit(GalleryError(e.toString()));
    }
  }

  void fetchSessions() async {
    emit(GalleryLoading());
    try {
      final images = await repository.fetchSessions();
      emit(GalleryLoaded(images));
    } catch (e) {
      emit(GalleryError(e.toString()));
    }
  }
}
