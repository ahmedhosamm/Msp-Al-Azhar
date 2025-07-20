import '../Data/dio_Home.dart';

abstract class HomeGalleryState {}

class HomeGalleryInitial extends HomeGalleryState {}
class HomeGalleryLoading extends HomeGalleryState {}
class HomeGalleryLoaded extends HomeGalleryState {
  final List<HomeGalleryModel> images;
  HomeGalleryLoaded(this.images);
}
class HomeGalleryError extends HomeGalleryState {
  final String message;
  HomeGalleryError(this.message);
} 