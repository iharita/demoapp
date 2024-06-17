import 'package:flutter_test/flutter_test.dart';
import 'package:demoapp/model/posts_response.dart'; // Adjust import path as per your project
import 'package:demoapp/services/apis.dart'; // Adjust import path as per your project

void main() {
  test('Test API', () async {
    final List<PostResponse> response = await API.getPosts();

    // Ensure response is not null and has at least one item
    expect(response, isNotNull);
    expect(response.isNotEmpty, true);

    // Example assertion for checking a property of PostResponse
    expect(response.first.eventLocation, isNotNull); // Adjust as per your actual logic
  });
}
