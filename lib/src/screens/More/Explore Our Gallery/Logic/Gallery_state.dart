import '../Data/dio_Gallery.dart';

abstract class GalleryState {}

class GalleryInitial extends GalleryState {}
class GalleryLoading extends GalleryState {}
class GalleryLoaded extends GalleryState {
  final List<GalleryModel> images;
  GalleryLoaded(this.images);
}
class GalleryError extends GalleryState {
  final String message;
  GalleryError(this.message);
}
