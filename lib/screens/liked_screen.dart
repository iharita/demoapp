import 'package:demoapp/model/posts_response.dart';
import 'package:demoapp/screens/home_screen.dart';
import 'package:flutter/material.dart';

class LikedListScreen extends StatefulWidget {
  const LikedListScreen({super.key});

  @override
  State<LikedListScreen> createState() => _LikedListScreenState();
}

class _LikedListScreenState extends State<LikedListScreen> {
  List<PostResponse> posts = [];
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Liked Screen'),
      ),
      body: ListView.builder(
        itemCount: posts.length,
        itemBuilder: (context, index) {
          PostResponse post = posts[index];
          bool isLiked = posts[index].likedUsers?.contains(userName) ?? false;
          // int likeCount = likesCount[post.sId!] ?? 0;

          return Padding(
            padding: const EdgeInsets.only(top: 8.0),
            child: Card(
              color: Colors.white,
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
                            style: const TextStyle(fontWeight: FontWeight.bold),
                          ),
                        const SizedBox(height: 8),
                        if (post.eventStartAt != null &&
                            post.eventEndAt != null)
                          Text(
                            'Event Time: ${post.eventStartAt} - ${post.eventEndAt}',
                            style: const TextStyle(fontWeight: FontWeight.bold),
                          ),
                        const SizedBox(height: 16),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            GestureDetector(
                              onTap: () => toggleLike(posts[index]),
                              child: Row(
                                children: [
                                  Icon(
                                    isLiked
                                        ? Icons.thumb_up
                                        : Icons.thumb_up_alt_outlined,
                                    size: 24,
                                    color: isLiked ? Colors.blue : Colors.grey,
                                  ),
                                  const SizedBox(width: 4),
                                  Text(
                                    post.likedUsers != null
                                        ? post.likedUsers!.length.toString()
                                        : "",
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
                                  Icons.mode_comment_outlined,
                                  size: 24,
                                  color: Colors.grey,
                                ),
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
                                Icon(Icons.share, size: 24, color: Colors.grey),
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
    );
  }

  void toggleLike(PostResponse post) {
    setState(() {
      if (posts.contains(post)) {
        posts.remove(post);
        post.likedUsers?.remove(userName);
      } else {
        post.likedUsers?.add(userName);
        posts.add(post);
      }
    });
  }
}
