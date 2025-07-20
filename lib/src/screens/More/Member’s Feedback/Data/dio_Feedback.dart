import 'package:dio/dio.dart';

class ReviewModel {
  final String id;
  final String reviewerName;
  final String title;
  final String review;
  final String photo;
  final String createdAt;

  ReviewModel({
    required this.id,
    required this.reviewerName,
    required this.title,
    required this.review,
    required this.photo,
    required this.createdAt,
  });

  factory ReviewModel.fromJson(Map<String, dynamic> json) {
    return ReviewModel(
      id: json['_id'] ?? '',
      reviewerName: json['reviewerName'] ?? '',
      title: json['title'] ?? '',
      review: json['review'] ?? '',
      photo: json['photo'] ?? '',
      createdAt: json['createdAt'] ?? '',
    );
  }
}

class FeedbackApi {
  static Future<List<ReviewModel>> fetchReviews() async {
    final dio = Dio();
    final url = 'https://api.msp-alazhar.tech/reviews';
    try {
      final response = await dio.get(url);
      final data = response.data;
      if (data is Map && data.containsKey('results') && data['results'] is List) {
        final reviewsList = data['results'] as List;
        final reviews = reviewsList.map((item) => ReviewModel.fromJson(item)).toList();
        // عكس ترتيب الريفيوهات
        return reviews.reversed.toList();
      } else {
        throw Exception('Failed to load reviews: Unexpected data format');
      }
    } catch (e) {
      throw Exception('Failed to load reviews: $e');
    }
  }
}