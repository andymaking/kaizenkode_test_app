import 'dart:convert';

import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../model/post_model.dart';

class DashBoardState {
  final bool isLoading;
  final List<PostModel> publicPosts;
  final List<PostModel> businessPosts;
  final List<String> businessTopics;
  final List<String> publicTopics;

  DashBoardState({
    required this.isLoading,
    required this.publicPosts,
    required this.businessPosts,
    required this.businessTopics,
    required this.publicTopics,
  });

  DashBoardState copyWith({
    bool? isLoading,
    List<PostModel>? publicPosts,
    List<PostModel>? businessPosts,
    List<String>? businessTopics,
    List<String>? publicTopics,
  }) {
    return DashBoardState(
      isLoading: isLoading ?? this.isLoading,
      publicPosts: publicPosts ?? this.publicPosts,
      businessPosts: businessPosts ?? this.businessPosts,
      publicTopics: publicTopics ?? this.publicTopics,
      businessTopics: businessTopics ?? this.businessTopics,
    );
  }
}

class DashBoardProvider extends StateNotifier<DashBoardState> {

  DashBoardProvider()
      : super(DashBoardState(
    isLoading: false,
    publicPosts: [],
    businessPosts: [],
    businessTopics: [],
    publicTopics: [],
  )
  ) {
    // Initialize the provider by getting cached data and then fetching fresh data
    _initializeDashboardData();
  }

  set setLoading(bool value) {
    state = state.copyWith(isLoading: value);
  }

  set setPublicPost(List<PostModel> value) {
    state = state.copyWith(publicPosts: value);
  }

  set setBusinessPost(List<PostModel> value) {
    state = state.copyWith(businessPosts: value);
  }

  set setBusinessTopic(List<String> value) {
    state = state.copyWith(businessTopics: value);
  }

  set setPublicTopic(List<String> value) {
    state = state.copyWith(publicTopics: value);
  }

  Future<void> _initializeDashboardData() async {
    List<PostModel> public = posts.where((e)=> e.isPublic == true).toList();
    List<PostModel> business = posts.where((e)=> e.isPublic != true).toList();
    List<String> bTopicList = getUniqueTopics(business);
    List<String> pTopicList = getUniqueTopics(public);
    setBusinessPost = business;
    setPublicPost = public;
    setPublicTopic = pTopicList;
    setBusinessTopic = bTopicList;
  }

  List<String> getUniqueTopics(List<PostModel> posts) {
    // Extract non-null topics, convert to Set to remove duplicates, then to List
    final topics = posts
        .map((post) => post.topic ?? "")
        .where((topic) => topic.isNotEmpty)
        .toSet()
        .toList();

    return topics;
  }

  List<PostModel> posts = [
    PostModel(
      name: "John Doe",
      topic: "Technology",
      body: "Exploring the latest trends in AI and machine learning. The advancements in these fields are astonishing, especially in natural language processing and computer vision. AI is reshaping industries, and it's fascinating to see how it evolves day by day.",
      createdAt: DateTime.utc(2024, 8, 19, 20, 44, 4, 228, 271).toIso8601String(),
      isPublic: true,
      profilePicture: "https://i.pravatar.cc/150?img=1",
      postImage: "https://img.freepik.com/free-photo/ai-robot-handshake_23-2149051125.jpg",
    ),
    PostModel(
      name: "Jane Smith",
      topic: "Travel",
      body: "A beautiful sunset at the Grand Canyon. The hues of orange and red painted across the sky were mesmerizing. It’s a reminder of nature's beauty and power. I could spend hours just soaking in the view and feeling connected to the world.",
      createdAt: DateTime.utc(2024, 8, 18, 20, 44, 4, 228, 271).toIso8601String(),
      isPublic: true,
      profilePicture: "https://i.pravatar.cc/150?img=2",
      postImage: "https://img.freepik.com/free-photo/sunset-grand-canyon_23-2149368954.jpg",
    ),
    PostModel(
      name: "Michael Johnson",
      topic: "Food",
      body: "Tried out a new recipe today - homemade sushi. It was a fun and challenging experience, but the results were worth it. The balance of flavors, the freshness of the ingredients, and the satisfaction of making it myself made the effort truly rewarding.",
      createdAt: DateTime.utc(2024, 8, 17, 20, 44, 4, 228, 271).toIso8601String(),
      isPublic: true,
      profilePicture: "https://i.pravatar.cc/150?img=3",
      postImage: "https://img.freepik.com/free-photo/homemade-sushi_23-2149368955.jpg",
    ),
    PostModel(
      name: "Emily Davis",
      topic: "Books",
      body: "Just finished reading 'The Great Gatsby' for the third time. Each read brings new insights and reflections. Fitzgerald's portrayal of the American Dream and the complexities of his characters are both thought-provoking and poignant.",
      createdAt: DateTime.utc(2024, 8, 16, 20, 44, 4, 228, 271).toIso8601String(),
      isPublic: true,
      profilePicture: "https://i.pravatar.cc/150?img=4",
      postImage: "https://img.freepik.com/free-photo/book-cover_23-2149368956.jpg",
    ),
    PostModel(
      name: "Sophia Brown",
      topic: "Fitness",
      body: "Started a new workout routine focusing on strength training. The progress has been slow but steady. It’s incredible to see how much stronger and healthier I feel with each passing week. Fitness is definitely a journey worth taking.",
      createdAt: DateTime.utc(2024, 8, 15, 20, 44, 4, 228, 271).toIso8601String(),
      isPublic: true,
      profilePicture: "https://i.pravatar.cc/150?img=5",
      postImage: "https://img.freepik.com/free-photo/fitness-workout_23-2149368957.jpg",
    ),
    PostModel(
      name: "Daniel Wilson",
      topic: "Technology",
      body: "The rise of quantum computing is set to revolutionize many fields, from cryptography to complex simulations. While it's still in its early stages, the potential applications and breakthroughs are incredibly exciting.",
      createdAt: DateTime.utc(2024, 8, 14, 20, 44, 4, 228, 271).toIso8601String(),
      isPublic: true,
      profilePicture: "https://i.pravatar.cc/150?img=6",
      postImage: "https://img.freepik.com/free-photo/quantum-computing_23-2149368958.jpg",
    ),
    PostModel(
      name: "Olivia Martinez",
      topic: "Travel",
      body: "Exploring the beautiful landscapes of Iceland has been a dream come true. The natural wonders, from geysers to glaciers, are breathtaking. Each day brings a new adventure and a deeper appreciation for the planet's beauty.",
      createdAt: DateTime.utc(2024, 8, 13, 20, 44, 4, 228, 271).toIso8601String(),
      isPublic: true,
      profilePicture: "https://i.pravatar.cc/150?img=7",
      postImage: "https://img.freepik.com/free-photo/iceland-landscape_23-2149368959.jpg",
    ),
    PostModel(
      name: "Liam Anderson",
      topic: "Food",
      body: "Had an amazing meal at a new restaurant in town. The flavors were vibrant, and the presentation was beautiful. It’s always exciting to try new cuisines and discover new favorite dishes.",
      createdAt: DateTime.utc(2024, 8, 12, 20, 44, 4, 228, 271).toIso8601String(),
      isPublic: false,
      profilePicture: "https://i.pravatar.cc/150?img=8",
      postImage: "https://img.freepik.com/free-photo/restaurant-meal_23-2149368960.jpg",
    ),
    PostModel(
      name: "Isabella Taylor",
      topic: "Books",
      body: "Currently diving into 'To Kill a Mockingbird.' Harper Lee's storytelling is both powerful and moving. The themes of justice and moral growth resonate deeply, making this a timeless and impactful read.",
      createdAt: DateTime.utc(2024, 8, 11, 20, 44, 4, 228, 271).toIso8601String(),
      isPublic: false,
      profilePicture: "https://i.pravatar.cc/150?img=9",
      postImage: "https://img.freepik.com/free-photo/book-cover_23-2149368961.jpg",
    ),
    PostModel(
      name: "Ethan Walker",
      topic: "Fitness",
      body: "Joined a local sports league and it's been a blast. The camaraderie and competitive spirit make each game exciting. It’s great to stay active and meet new people who share the same passion for sports.",
      createdAt: DateTime.utc(2024, 8, 10, 20, 44, 4, 228, 271).toIso8601String(),
      isPublic: false,
      profilePicture: "https://i.pravatar.cc/150?img=10",
      postImage: "https://img.freepik.com/free-photo/sports-league_23-2149368962.jpg",
    ),
    PostModel(
      name: "Ava Lewis",
      topic: "Technology",
      body: "Blockchain technology continues to evolve and its applications are expanding beyond cryptocurrencies. The potential for decentralized applications and secure transactions is immense, and it’s exciting to watch this space grow.",
      createdAt: DateTime.utc(2024, 8, 09, 20, 44, 4, 228, 271).toIso8601String(),
      isPublic: false,
      profilePicture: "https://i.pravatar.cc/150?img=11",
      postImage: "https://img.freepik.com/free-photo/blockchain-technology_23-2149368963.jpg",
    ),
    PostModel(
      name: "Mia Harris",
      topic: "Travel",
      body: "Explored the beautiful city of Tokyo. The blend of traditional culture with modern technology is fascinating. From historic temples to cutting-edge technology, Tokyo offers an array of experiences that are both unique and memorable.",
      createdAt: DateTime.utc(2024, 8, 08, 20, 44, 4, 228, 271).toIso8601String(),
      isPublic: true,
      profilePicture: "https://i.pravatar.cc/150?img=12",
      postImage: "https://img.freepik.com/free-photo/tokyo-city_23-2149368964.jpg",
    ),
    PostModel(
      name: "Lucas White",
      topic: "Fitness",
      body: "Started a new yoga practice and it's been a rejuvenating experience. The combination of physical postures, breathing exercises, and meditation has improved my flexibility and mental well-being. It's a holistic approach to health that I highly recommend.",
      createdAt: DateTime.utc(2024, 8, 06, 20, 44, 4, 228, 271).toIso8601String(),
      isPublic: true,
      profilePicture: "https://i.pravatar.cc/150?img=14",
      postImage: "https://img.freepik.com/free-photo/yoga-practice_23-2149368965.jpg",
    ),
    PostModel(
      name: "Ella Miller",
      topic: "Food",
      body: "Discovered a fantastic recipe for a Mediterranean salad. It’s packed with fresh vegetables, olives, and feta cheese, drizzled with a tangy lemon dressing. It’s not only delicious but also a healthy addition to any meal.",
      createdAt: DateTime.utc(2024, 8, 05, 20, 44, 4, 228, 271).toIso8601String(),
      isPublic: true,
      profilePicture: "https://i.pravatar.cc/150?img=15",
      postImage: "https://img.freepik.com/free-photo/mediterranean-salad_23-2149368966.jpg",
    ),
    PostModel(
      name: "James Taylor",
      topic: "Books",
      body: "Reading 'The Catcher in the Rye' again brings back so many memories. Holden Caulfield's journey through adolescence and his critique of society remain as relevant as ever. It's a novel that captures the complexity of growing up.",
      createdAt: DateTime.utc(2024, 8, 04, 20, 44, 4, 228, 271).toIso8601String(),
      isPublic: false,
      profilePicture: "https://i.pravatar.cc/150?img=16",
      postImage: "https://img.freepik.com/free-photo/catcher-in-the-rye_23-2149368967.jpg",
    ),
    PostModel(
      name: "Chloe King",
      topic: "Travel",
      body: "Visited the picturesque town of Santorini in Greece. The stunning blue domes and whitewashed buildings set against the backdrop of the Aegean Sea create a postcard-perfect scene. It's a place of incredible beauty and serenity.",
      createdAt: DateTime.utc(2024, 8, 03, 20, 44, 4, 228, 271).toIso8601String(),
      isPublic: false,
      profilePicture: "https://i.pravatar.cc/150?img=17",
      postImage: "https://img.freepik.com/free-photo/santorini-greece_23-2149368968.jpg",
    ),
  ];

}

final dashBoardProvider =
    StateNotifierProvider<DashBoardProvider, DashBoardState>((ref) {
  return DashBoardProvider();
});

