import 'package:dio/dio.dart';

class SponsorModel {
  final String id;
  final String imageUrl;

  SponsorModel({required this.id, required this.imageUrl});

  factory SponsorModel.fromJson(Map<String, dynamic> json) {
    return SponsorModel(
      id: json['_id'],
      imageUrl: json['image'],
    );
  }
}

class SponsorsRepository {
  final Dio _dio = Dio();
  final String _url = 'https://api.msp-alazhar.tech/sponsorsClient/get/';

  Future<List<SponsorModel>> fetchSponsors() async {
    final response = await _dio.get(_url);
    print('Status code: ${response.statusCode}');
    print('Response data: ${response.data}');
    if (response.statusCode == 200 && response.data['results'] != null) {
      List data = response.data['results'];
      return data.map((json) => SponsorModel.fromJson(json)).toList();
    } else {
      throw Exception('Failed to load sponsors');
    }
  }
}
