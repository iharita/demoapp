import 'dart:convert';

import 'package:demoapp/model/posts_response.dart';
import 'package:http/http.dart' as http;

abstract class API{
  static const String _baseUrl = 'https://post-api-omega.vercel.app/api/posts?page=1';
  static Future<List<PostResponse>> getPosts() async {
    final response = await http.get(Uri.parse('$_baseUrl/getPosts'));
    if (response.statusCode == 200) {
      final List<dynamic> data = json.decode(response.body);
      List<PostResponse> posts = data.map((json) => PostResponse.fromJson(json)).toList();
      return posts;
    }
    else {
      throw Exception('Failed to load album');
    }
  }
}