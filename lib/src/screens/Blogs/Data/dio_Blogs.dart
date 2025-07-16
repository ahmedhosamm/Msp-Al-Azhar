import 'package:dio/dio.dart';
import '../UI/blogs.dart';

class BlogsApi {
  static Future<List<Blog>> getBlogs() async {
    final dio = Dio();
    const url = 'https://api.msp-alazhar.tech/blogsClient/get';
    try {
      final response = await dio.get(url);
      final List data = response.data['results'];
      return data.reversed.map((e) => Blog(
        id: e['_id'],
        name: e['name'],
        instagram: e['instagram'],
        linkedin: e['linkedin'],
        facebook: e['facebook'],
        twitter: e['twitter'],
        image: e['image'],
        description: (e['description'] ?? '').replaceAll('\r\n', ' ').replaceAll('\n', ' '),
        createdAt: DateTime.parse(e['createdAt']),
      )).toList();
    } catch (e) {
      throw Exception('فشل في جلب البيانات');
    }
  }
}
