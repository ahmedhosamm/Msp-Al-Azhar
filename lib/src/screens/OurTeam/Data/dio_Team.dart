import 'package:dio/dio.dart';

class TeamApi {
  static Future<List<dynamic>> fetchTeamMembers() async {
    final dio = Dio();
    const url = 'https://api.msp-alazhar.tech/teamMembersClient/get';
    try {
      final response = await dio.get(url);
      if (response.statusCode == 200 && response.data != null) {
        return response.data['results'] as List<dynamic>;
      } else {
        throw Exception('Failed to load team members');
      }
    } catch (e) {
      throw Exception('Error fetching team members: $e');
    }
  }
}
