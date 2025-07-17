import 'package:dio/dio.dart';

class GalleryModel {
  final String id;
  final String name;
  final String image;
  final DateTime createdAt;
  final DateTime updatedAt;

  GalleryModel({
    required this.id,
    required this.name,
    required this.image,
    required this.createdAt,
    required this.updatedAt,
  });

  factory GalleryModel.fromJson(Map<String, dynamic> json) {
    return GalleryModel(
      id: json['_id'],
      name: json['name'],
      image: json['image'],
      createdAt: DateTime.parse(json['createdAt']),
      updatedAt: DateTime.parse(json['updatedAt']),
    );
  }
}

class GalleryRepository {
  final Dio _dio = Dio();

  Future<List<GalleryModel>> fetchAll() async {
    final response = await _dio.get('https://api.msp-alazhar.tech/galleryClient/get');
    print('fetchAll response: ' + response.data.toString());
    return (response.data['results'] as List)
        .map((e) => GalleryModel.fromJson(e))
        .toList()
        .reversed
        .toList();
  }

  Future<List<GalleryModel>> fetchEvents() async {
    final response = await _dio.get('https://api.msp-alazhar.tech/galleryClient/getEvents');
    print('fetchEvents response: ' + response.data.toString());
    return (response.data['results'] as List)
        .map((e) => GalleryModel.fromJson(e))
        .toList()
        .reversed
        .toList();
  }

  Future<List<GalleryModel>> fetchSessions() async {
    final response = await _dio.get('https://api.msp-alazhar.tech/galleryClient/getSessions');
    print('fetchSessions response: ' + response.data.toString());
    return (response.data['results'] as List)
        .map((e) => GalleryModel.fromJson(e))
        .toList()
        .reversed
        .toList();
  }
}
