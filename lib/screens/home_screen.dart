import 'package:demoapp/app_colors.dart';
import 'package:flutter/material.dart';
import 'package:demoapp/model/posts_response.dart'; // Adjust import path as per your project
import 'package:demoapp/services/apis.dart'; // Adjust import path as per your project

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Center(
          child: Text(
            'DEMO APP',
            style: TextStyle(fontWeight: FontWeight.w500),
          ),
        ),
        actions: [
          Stack(
            children: <Widget>[
              IconButton(
                icon: const Icon(Icons.notifications_none, size: 28),
                onPressed: () {
                  // Handle the notification button press
                },
              ),
              Positioned(
                right: 15,
                top: 12,
                child: Container(
                  decoration: BoxDecoration(
                    color: primaryColor, // Example color, replace with your primaryColor
                    borderRadius: BorderRadius.circular(6),
                  ),
                  constraints: const BoxConstraints(
                    minWidth: 12,
                    minHeight: 12,
                  ),
                ),
              )
            ],
          ),
        ],
        elevation: 2,
        backgroundColor: Colors.white,
      ),
      drawer: const Drawer(),
      body: Column(
        children: [
          const SizedBox(height: 10),
          Row(
            children: [
              Expanded(
                child: Padding(
                  padding: const EdgeInsets.only(left: 8.0),
                  child: Container(
                    decoration: BoxDecoration(
                      color: Colors.blue[50],
                      borderRadius: BorderRadius.circular(20.0),
                    ),
                    child: const TextField(
                      decoration: InputDecoration(
                        hintText: 'Search messages',
                        hintStyle: TextStyle(color: Colors.grey),
                        prefixIcon: Icon(Icons.search, color: Colors.grey),
                        border: InputBorder.none,
                      ),
                    ),
                  ),
                ),
              ),
              const SizedBox(width: 5.0),
              IconButton(
                icon: const Icon(Icons.tune, color: Colors.blue),
                onPressed: () {
                  // Handle filter button press
                },
              ),
            ],
          ),
          const SizedBox(height: 10),
          Expanded(
            child: FutureBuilder<List<PostResponse>>(
              future: API.getPosts(),
              builder: (context, snapshot) {
                if (snapshot.connectionState == ConnectionState.waiting) {
                  return const Center(child: CircularProgressIndicator());
                } else if (snapshot.hasError) {
                  return Center(child: Text('Error: ${snapshot.error}'));
                } else if (snapshot.hasData) {
                  List<PostResponse> posts = snapshot.data!;
                  return ListView.builder(
                    itemCount: posts.length,
                    itemBuilder: (context, index) {
                      PostResponse post = posts[index];
                      return Padding(
                        padding: const EdgeInsets.all(12.0),
                        child: Card(
                          elevation: 2,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(12.0),
                          ),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.stretch,
                            children: [
                              // title
                              Text(
                                post.title ?? '',
                                style: const TextStyle(
                                  fontSize: 18,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                              const SizedBox(height: 8),
                              // Image
                              AspectRatio(
                                aspectRatio: 16 / 9, // Adjust aspect ratio as needed
                                child: ClipRRect(
                                  borderRadius: const BorderRadius.vertical(top: Radius.circular(12.0)),
                                  child: Image.network(
                                    post.image![0], // Displaying the first image only for simplicity
                                    fit: BoxFit.cover,
                                  ),
                                ),
                              ),
                              Padding(
                                padding: const EdgeInsets.all(12.0),
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    // Description
                                    Text(
                                      post.description ?? '',
                                      style: TextStyle(color: Colors.grey[600]),
                                    ),
                                    const SizedBox(height: 8),
                                    // Event Location if available
                                    if (post.eventLocation != null)
                                      Text(
                                        'Event Location: ${post.eventLocation!.type}',
                                        style: const TextStyle(fontWeight: FontWeight.bold),
                                      ),
                                    const SizedBox(height: 8),
                                    // Event Time if available
                                    if (post.eventStartAt != null && post.eventEndAt != null)
                                      Text(
                                        'Event Time: ${post.eventStartAt} - ${post.eventEndAt}',
                                        style: const TextStyle(fontWeight: FontWeight.bold),
                                      ),
                                    const SizedBox(height: 16),
                                    // Interaction buttons/icons
                                    Row(
                                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                      children: [
                                        Row(
                                          children: [
                                            const Icon(Icons.favorite_border, size: 24),
                                            const SizedBox(width: 4),
                                            Text(
                                              '${post.likes ?? 0}',
                                              style: const TextStyle(fontSize: 16),
                                            ),
                                          ],
                                        ),
                                        Row(
                                          children: [
                                            const Icon(Icons.mode_comment_outlined, size: 24),
                                            const SizedBox(width: 4),
                                            Text(
                                              '${post.comments?.length ?? 0}',
                                              style: const TextStyle(fontSize: 16),
                                            ),
                                          ],
                                        ),
                                        const Row(
                                          children: [
                                            Icon(Icons.share, size: 24),
                                            SizedBox(width: 4),
                                            Text(
                                              'Share',
                                              style: TextStyle(fontSize: 16),
                                            ),
                                          ],
                                        ),
                                      ],
                                    ),
                                  ],
                                ),
                              ),
                            ],
                          ),
                        ),
                      );
                    },
                  );
                } else {
                  return const Center(child: Text('No data available'));
                }
              },
            ),
          ),
        ],
      ),
    );
  }
}
