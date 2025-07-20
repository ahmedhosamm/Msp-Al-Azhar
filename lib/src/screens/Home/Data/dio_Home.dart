import 'package:dio/dio.dart';

class HomeGalleryModel {
  final String id;
  final String name;
  final String image;
  final DateTime createdAt;
  final DateTime updatedAt;

  HomeGalleryModel({
    required this.id,
    required this.name,
    required this.image,
    required this.createdAt,
    required this.updatedAt,
  });

  factory HomeGalleryModel.fromJson(Map<String, dynamic> json) {
    return HomeGalleryModel(
      id: json['_id'],
      name: json['name'],
      image: json['image'],
      createdAt: DateTime.parse(json['createdAt']),
      updatedAt: DateTime.parse(json['updatedAt']),
    );
  }
}

class HomeGalleryRepository {
  final Dio _dio = Dio();

  Future<List<HomeGalleryModel>> fetchGalleryImages() async {
    final response = await _dio.get('https://api.msp-alazhar.tech/galleryClient/get');
    print('Home Gallery fetchAll response: ' + response.data.toString());
    final allImages = (response.data['results'] as List)
        .map((e) => HomeGalleryModel.fromJson(e))
        .toList()
        .reversed
        .toList();
    
    // Take only 6 random images
    allImages.shuffle();
    final selectedImages = allImages.take(6).toList();
    print('Selected ${selectedImages.length} images for home gallery');
    print('Images: ${selectedImages.map((img) => img.name).toList()}');
    return selectedImages;
  }
}
