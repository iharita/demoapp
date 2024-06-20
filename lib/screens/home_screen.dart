import 'package:flutter/material.dart';
import 'package:demoapp/app_colors.dart'; // Assuming you have defined app_colors.dart
import 'package:demoapp/services/apis.dart';
import 'package:demoapp/model/posts_response.dart';

String userName = 'harry';

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final ScrollController scrollController = ScrollController();
  List<PostResponse> likedList = [];
  List<PostResponse> posts = [];
  Map<String, bool> likedPosts = {}; // Map to track liked status of posts
  Map<String, int> likesCount = {}; // Map to track like counts
  bool showOnlyLiked = false; // Flag to show only liked posts
  bool isLoading = false; // Flag to indicate if data is being loaded
  int page = 0; // Page number to fetch posts incrementally
  final int pageSize = 5; // Number of posts per page

  @override
  void initState() {
    super.initState();
    scrollController.addListener(_scrollListener);
    fetchPosts();
  }

  // Method to copy a post with a unique identifier
  PostResponse copyPostWithUniqueId(PostResponse original, int index) {
    return PostResponse(
      sId: '${original.sId}_$index', // Append index to original ID to make it unique
      title: original.title,
      description: original.description,
      image: original.image,
      eventLocation: original.eventLocation,
      eventStartAt: original.eventStartAt,
      eventEndAt: original.eventEndAt,
      likes: original.likes,
      likedUsers: List.from(original.likedUsers ?? []), // Make a copy of the list
      comments: List.from(original.comments ?? []), // Make a copy of the list
    );
  }

  void fetchPosts() async {
    if (isLoading) return; // Prevent multiple fetches at the same time
    setState(() {
      isLoading = true;
    });

    try {
      List<PostResponse> fetchedPosts = await API.getPosts(page, pageSize); // Adjust API to support pagination
      setState(() {
        // Append the fetched posts to the existing list
        for (int i = 0; i < fetchedPosts.length; i++) {
          posts.add(copyPostWithUniqueId(fetchedPosts[i], i + (page * pageSize)));
        }

        // Initialize liked status and like count for each post
        for (var post in fetchedPosts) {
          likedPosts[post.sId!] = likedPosts[post.sId!] ?? false; // Maintain previous like status if exists
          likesCount[post.sId!] = post.likes ?? 0; // Initialize like count from API
        }
        page++; // Increment page number
      });
    } catch (error) {
      print('Error fetching posts: $error');
    } finally {
      setState(() {
        isLoading = false;
      });
    }
  }

  void toggleLike(PostResponse post) {
    setState(() {
      if (likedList.contains(post)) {
        likedList.remove(post);
        post.likedUsers?.remove(userName);
        likedPosts[post.sId!] = false;
      } else {
        post.likedUsers?.add(userName);
        likedList.add(post);
        likedPosts[post.sId!] = true;
      }

      likesCount[post.sId!] = post.likedUsers?.length ?? 0;
    });
  }

  void _showFilterOptions(BuildContext context) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text('Filter Options'),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: <Widget>[
              ListTile(
                title: const Text('Liked Posts'),
                onTap: () {
                  setState(() {
                    showOnlyLiked = true;
                  });
                  Navigator.pop(context);
                },
              ),
              ListTile(
                title: const Text('All Posts'),
                onTap: () {
                  setState(() {
                    showOnlyLiked = false;
                  });
                  Navigator.pop(context);
                },
              ),
            ],
          ),
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    List<PostResponse> displayedPosts = showOnlyLiked
        ? likedList
        : posts; // Display liked posts only if showOnlyLiked is true

    return Scaffold(
      backgroundColor: Colors.grey.shade300,
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
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 8.0),
            child: Row(
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
                  icon: const Icon(Icons.filter_list, color: Colors.blue),
                  onPressed: () {
                    _showFilterOptions(context);
                  },
                ),
              ],
            ),
          ),
          Expanded(
            child: ListView.builder(
              padding: const EdgeInsets.symmetric(horizontal: 8.0),
              controller: scrollController,
              itemCount: displayedPosts.length + (isLoading ? 1 : 0), // Add an extra item for the loading indicator
              itemBuilder: (context, index) {
                if (index == displayedPosts.length) {
                  return const Center(
                    child: Padding(
                      padding: EdgeInsets.all(8.0),
                      child: CircularProgressIndicator(),
                    ),
                  );
                }

                PostResponse post = displayedPosts[index];
                bool isLiked = likedPosts[post.sId] ?? false;

                return Padding(
                  padding: const EdgeInsets.only(top: 8.0),
                  child: Card(
                    color: Colors.white,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.stretch,
                      children: [
                        const SizedBox(height: 5),
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
                              top: Radius.circular(12.0),
                            ),
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
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                              const SizedBox(height: 8),
                              if (post.eventStartAt != null && post.eventEndAt != null)
                                Text(
                                  'Event Time: ${post.eventStartAt} - ${post.eventEndAt}',
                                  style: const TextStyle(
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                              const SizedBox(height: 16),
                              Row(
                                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                children: [
                                  GestureDetector(
                                    onTap: () => toggleLike(post),
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
                                            fontSize: 16,
                                            color: Colors.grey,
                                          ),
                                        ),
                                        const SizedBox(width: 5),
                                        const Text(
                                          'Likes',
                                          style: TextStyle(
                                            fontSize: 16,
                                            color: Colors.grey,
                                          ),
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
                                          fontSize: 16,
                                          color: Colors.grey,
                                        ),
                                      ),
                                      const SizedBox(width: 5),
                                      const Text(
                                        'Comments',
                                        style: TextStyle(
                                          fontSize: 16,
                                          color: Colors.grey,
                                        ),
                                      ),
                                    ],
                                  ),
                                  const Row(
                                    children: [
                                      Icon(
                                        Icons.share,
                                        size: 24,
                                        color: Colors.grey,
                                      ),
                                      SizedBox(width: 5),
                                      Text(
                                        'Share',
                                        style: TextStyle(
                                          fontSize: 16,
                                          color: Colors.grey,
                                        ),
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

  void _scrollListener() {
    if (scrollController.position.pixels == scrollController.position.maxScrollExtent && !isLoading) {
      fetchPosts();
    }
  }
}