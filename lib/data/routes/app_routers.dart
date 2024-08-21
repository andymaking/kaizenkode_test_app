import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

import '../../feature/bottom_navigation/bottom_navigation.dart';
import '../../feature/chat_details/chat_detail_screen.dart';
import '../../feature/chat_home/screen/chat_home_page.dart';
import '../../feature/create_post/screens/create_post_ui.dart';
import '../../feature/home/screens/home_screen.dart';
import '../../feature/splash/splash_screen.dart';
import 'consumer_go_router.dart';

class AppRouter {
  static GoRouter router = GoRouter(
    initialLocation: AppRoute.splash,
    routes: [
      GoRoute(
        path: '/',
        builder: (context, state) => Scaffold(),
      ),
      GoRoute(
        path: AppRoute.splash,
        builder: (context, state) => const SplashScreen(),
      ),
      GoRoute(
        path: AppRoute.createPost,
        builder: (context, state) => const CreatePostScreen(),
      ),
      GoRoute(
        path: AppRoute.chatDetails,
        builder: (context, state) {
          // Access the :id parameter
          final String? chatId = state.pathParameters['id'];
          return ChatDetailScreen(chatId: chatId);
        },
      ),
      StatefulShellRoute.indexedStack(
        branches: [
          StatefulShellBranch(routes: [
            ConsumerGoRoute(
              path: AppRoute.homeScreen,
              builder: (context, state, ref) => const HomeScreen(),
            ),
          ]),
          StatefulShellBranch(routes: [
            ConsumerGoRoute(
              path: AppRoute.searchScreen,
              builder: (context, state, ref) => const Scaffold(),
            ),
          ]),
          StatefulShellBranch(routes: [
            ConsumerGoRoute(
              path: AppRoute.chatHome,
              builder: (context, state, ref) => const ChatHomeScreen(),
            ),
          ]),
          StatefulShellBranch(routes: [
            ConsumerGoRoute(
              path: AppRoute.profile,
              builder: (context, state, ref) => const Scaffold(),
            ),
          ]),
        ],
        builder: (context, state, navigationShell) => MainView(
          navigationShell: navigationShell,
        ),
      ),
    ],
  );
}

class AppRoute {
  static const String splash = '/splash';
  static const String homeScreen = '/home';
  static const String searchScreen = '/search';
  static const String createPost = '/create';
  static const String chatHome = '/chat';
  static const String chatDetails = '/chat/:id';
  static const String profile = '/profile';
}