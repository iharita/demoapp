import 'package:demoapp/app_colors.dart';
import 'package:flutter/material.dart';
import 'package:demoapp/model/posts_response.dart';
import 'package:demoapp/services/apis.dart'; // Assuming this is where your API class is defined
import 'dart:convert';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  List<PostResponse> posts = [];
  Map<String, bool> likedPosts = {}; // Map to track liked status of posts
  Map<String, int> likesCount = {}; // Map to track like counts

  @override
  void initState() {
    super.initState();
    fetchPosts();
  }

  void fetchPosts() async {
    try {
      List<PostResponse> fetchedPosts = await API.getPosts();
      setState(() {
        posts = fetchedPosts;
        // Initialize liked status and like count for each post
        for (var post in posts) {
          likedPosts[post.sId!] = false; // Initially, no posts are liked
          likesCount[post.sId!] =
              post.likes ?? 0; // Initialize like count from API
        }
      });
    } catch (error) {
      print('Error fetching posts: $error');
    }
  }

  void toggleLike(String postId) {
    setState(() {
      if (likedPosts[postId]!) {
        // If already liked, unlike (decrement count)
        likesCount[postId] = likesCount[postId]! - 1;
      } else {
        // If not liked, like (increment count)
        likesCount[postId] = likesCount[postId]! + 1;
      }
      likedPosts[postId] = !likedPosts[postId]!; // Toggle liked status
    });
  }

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
                    color: primaryColor,
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
          Expanded(
            child: ListView.builder(
              itemCount: posts.length,
              itemBuilder: (context, index) {
                PostResponse post = posts[index];
                bool isLiked = likedPosts[post.sId!] ?? false;
                int likeCount = likesCount[post.sId!] ?? 0;

                return Padding(
                  padding: const EdgeInsets.only(top: 8.0),
                  child: Card(
                    elevation: 2,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(12.0),
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.stretch,
                      children: [
                        const SizedBox(
                          height: 5,
                        ),
                        Padding(
                          padding: const EdgeInsets.all(10.0),
                          child: Text(
                            post.title ?? '',
                            style: const TextStyle(
                              fontSize: 18,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),
                        AspectRatio(
                          aspectRatio: 16 / 9,
                          child: ClipRRect(
                            borderRadius: const BorderRadius.vertical(
                                top: Radius.circular(12.0)),
                            child: Image.network(
                              post.image![0],
                              fit: BoxFit.cover,
                            ),
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.all(10.0),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                post.description ?? '',
                                style: TextStyle(color: Colors.grey[600]),
                              ),
                              const SizedBox(height: 8),
                              if (post.eventLocation != null)
                                Text(
                                  'Event Location: ${post.eventLocation!.type}',
                                  style: const TextStyle(
                                      fontWeight: FontWeight.bold),
                                ),
                              const SizedBox(height: 8),
                              if (post.eventStartAt != null &&
                                  post.eventEndAt != null)
                                Text(
                                  'Event Time: ${post.eventStartAt} - ${post
                                      .eventEndAt}',
                                  style: const TextStyle(
                                      fontWeight: FontWeight.bold),
                                ),
                              const SizedBox(height: 16),
                              Row(
                                mainAxisAlignment: MainAxisAlignment
                                    .spaceBetween,
                                children: [
                                  GestureDetector(
                                    onTap: () => toggleLike(post.sId!),
                                    child: Row(
                                      children: [
                                        Icon(
                                          isLiked ? Icons.thumb_up : Icons
                                              .thumb_up_alt_outlined,
                                          size: 24,
                                          color: isLiked ? Colors.blue : Colors
                                              .grey,
                                        ),
                                        const SizedBox(width: 4),
                                        Text(
                                          '$likeCount',
                                          style: const TextStyle(
                                              fontSize: 16, color: Colors.grey),
                                        ),
                                        const SizedBox(width: 5),
                                        const Text(
                                          'Likes',
                                          style: TextStyle(
                                              fontSize: 16, color: Colors.grey),
                                        ),
                                      ],
                                    ),
                                  ),
                                  Row(
                                    children: [
                                      const Icon(
                                        Icons.mode_comment_outlined, size: 24,
                                        color: Colors.grey,),
                                      const SizedBox(width: 4),
                                      Text(
                                        '${post.comments?.length ?? 0}',
                                        style: const TextStyle(
                                            fontSize: 16, color: Colors.grey),
                                      ),
                                      const SizedBox(width: 5),
                                      const Text(
                                        'Comments',
                                        style: TextStyle(
                                            fontSize: 16, color: Colors.grey),
                                      ),
                                    ],
                                  ),
                                  const Row(
                                    children: [
                                      Icon(Icons.share, size: 24,
                                          color: Colors.grey),
                                      SizedBox(width: 5),
                                      Text(
                                        'Share',
                                        style: TextStyle(
                                            fontSize: 16, color: Colors.grey),
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
            ),
          ),
        ],
      ),
    );
  }
}