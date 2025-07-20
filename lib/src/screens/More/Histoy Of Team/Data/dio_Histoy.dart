import 'package:dio/dio.dart';

class TeamHistoryModel {
  final String id;
  final String name;
  final String image;
  final String description;
  final String date;

  TeamHistoryModel({
    required this.id,
    required this.name,
    required this.image,
    required this.description,
    required this.date,
  });

  factory TeamHistoryModel.fromJson(Map<String, dynamic> json) {
    return TeamHistoryModel(
      id: json['_id'] ?? '',
      name: json['name'] ?? '',
      image: json['image'] ?? '',
      description: json['description'] ?? '',
      date: json['date'] ?? '',
    );
  }
}

Future<List<TeamHistoryModel>> getHistoryData() async {
  try {
    final response = await Dio().get('https://api.msp-alazhar.tech/teamHistoryClient/get');
    final List data = response.data['results'];
    return data.map((e) => TeamHistoryModel.fromJson(e)).toList();
  } catch (e) {
    throw Exception('Failed to load team history');
  }
}
