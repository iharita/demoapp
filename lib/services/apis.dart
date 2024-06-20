import 'dart:convert';

import 'package:demoapp/model/posts_response.dart';
import 'package:http/http.dart' as http;

abstract class API {
  static const String _baseUrl = 'https://post-api-omega.vercel.app/api/posts?page=1';

  static Future<List<PostResponse>> getPosts(int page, int pageSize) async {
    final response = await http.get(Uri.parse(_baseUrl));
    if (response.statusCode == 200) {
      final List<dynamic> jsonData = jsonDecode(response.body);
      List<PostResponse> posts = jsonData.map((json) => PostResponse.fromJson(json)).toList();
      return posts;
    } else {
      throw Exception('Failed to load posts');
    }
  }
}
