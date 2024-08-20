import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:kaizenkode_test_app/feature/chat_home/model/chat_model.dart';


class ChatHomeState {
  final bool isLoading;
  final List<ChatModel> allChats;

  ChatHomeState({
    required this.isLoading,
    required this.allChats,
  });

  ChatHomeState copyWith({
    bool? isLoading,
    List<ChatModel>? allChats,
  }) {
    return ChatHomeState(
      isLoading: isLoading ?? this.isLoading,
      allChats: allChats ?? this.allChats,
    );
  }
}

class ChatProvider extends StateNotifier<ChatHomeState> {

  ChatProvider()
      : super(ChatHomeState(
    isLoading: false,
    allChats: [],
  )
  ) {
    // Initialize the provider by getting cached data and then fetching fresh data
    _initializeDashboardData();
  }

  set setLoading(bool value) {
    state = state.copyWith(isLoading: value);
  }

  set setChat(List<ChatModel> value) {
    state = state.copyWith(allChats: value);
  }

  Future<void> _initializeDashboardData() async {
    List<ChatModel> chat = getResponseDataListFromJson(jsonEncode(chats));
    setChat = chat;
    print(chat.length);
  }

  goToChat(String id, BuildContext context){
    final chatId = id;

    // Navigate to the chat details screen with the chat ID
    context.push('/chat/$chatId');
  }



  List<Map<String, dynamic>> chats = [
    {
      "name": "John Doe",
      "id": "chat123",
      "last_message": "Hey, see you soon!",
      "createdAt": "2024-08-20T13:39:00.000Z",
      "profilePicture": "https://i.pravatar.cc/150?img=1",
      "chats": [
        {
          "chat": "https://img.freepik.com/free-photo/ai-robot-handshake_23-2149051125.jpg",
          "userID": "abcd",
          "createdAt": "2024-08-20T13:30:00.000Z"
        },
        {
          "chat": "Hello! How are you?",
          "userID": "abcd",
          "createdAt": "2024-08-20T13:31:00.000Z"
        },
        {
          "chat": "https://img.freepik.com/free-photo/homemade-sushi_23-2149368955.jpg",
          "userID": "user123",
          "createdAt": "2024-08-20T13:32:00.000Z"
        },
        {
          "chat": "What’s up?",
          "userID": "user123",
          "createdAt": "2024-08-20T13:33:00.000Z"
        },
        {
          "chat": "Just working on a project.",
          "userID": "abcd",
          "createdAt": "2024-08-20T13:34:00.000Z"
        },
        {
          "chat": "Sounds interesting. Need help?",
          "userID": "user123",
          "createdAt": "2024-08-20T13:35:00.000Z"
        },
        {
          "chat": "No, I’m good for now.",
          "userID": "abcd",
          "createdAt": "2024-08-20T13:36:00.000Z"
        },
        {
          "chat": "Cool! Let me know if you need anything.",
          "userID": "user123",
          "createdAt": "2024-08-20T13:37:00.000Z"
        },
        {
          "chat": "Will do. Thanks!",
          "userID": "abcd",
          "createdAt": "2024-08-20T13:38:00.000Z"
        },
        {
          "chat": "Hey, see you soon!",
          "userID": "user123",
          "createdAt": "2024-08-20T13:39:00.000Z"
        }
      ]
    },
    {
      "name": "Alice Smith",
      "id": "chat001",
      "last_message": "Looking forward to our meeting!",
      "createdAt": "2024-08-20T13:09:00.000Z",
      "profilePicture": "https://i.pravatar.cc/150?img=2",
      "chats": [
        {
          "chat": "Hey Alice!",
          "userID": "abcd",
          "createdAt": "2024-08-20T13:00:00.000Z"
        },
        {
          "chat": "Hi! How are you?",
          "userID": "user001",
          "createdAt": "2024-08-20T13:01:00.000Z"
        },
        {
          "chat": "I’m doing well, thanks!",
          "userID": "abcd",
          "createdAt": "2024-08-20T13:02:00.000Z"
        },
        {
          "chat": "Great to hear!",
          "userID": "user001",
          "createdAt": "2024-08-20T13:03:00.000Z"
        },
        {
          "chat": "Let's meet tomorrow.",
          "userID": "abcd",
          "createdAt": "2024-08-20T13:04:00.000Z"
        },
        {
          "chat": "Sure, what time?",
          "userID": "user001",
          "createdAt": "2024-08-20T13:05:00.000Z"
        },
        {
          "chat": "How about 3 PM?",
          "userID": "abcd",
          "createdAt": "2024-08-20T13:06:00.000Z"
        },
        {
          "chat": "Perfect, see you then!",
          "userID": "user001",
          "createdAt": "2024-08-20T13:07:00.000Z"
        },
        {
          "chat": "See you!",
          "userID": "abcd",
          "createdAt": "2024-08-20T13:08:00.000Z"
        },
        {
          "chat": "Looking forward to our meeting!",
          "userID": "user001",
          "createdAt": "2024-08-20T13:09:00.000Z"
        }
      ]
    },
    {
      "name": "Bob Johnson",
      "id": "chat002",
      "last_message": "Bye!",
      "createdAt": "2024-08-20T14:09:00.000Z",
      "profilePicture": "https://i.pravatar.cc/150?img=3",
      "chats": [
        {
          "chat": "Hi Bob!",
          "userID": "abcd",
          "createdAt": "2024-08-20T14:00:00.000Z"
        },
        {
          "chat": "Hello! What’s up?",
          "userID": "user002",
          "createdAt": "2024-08-20T14:01:00.000Z"
        },
        {
          "chat": "Just checking in.",
          "userID": "abcd",
          "createdAt": "2024-08-20T14:02:00.000Z"
        },
        {
          "chat": "Everything okay?",
          "userID": "user002",
          "createdAt": "2024-08-20T14:03:00.000Z"
        },
        {
          "chat": "Yes, all good.",
          "userID": "abcd",
          "createdAt": "2024-08-20T14:04:00.000Z"
        },
        {
          "chat": "Great to hear!",
          "userID": "user002",
          "createdAt": "2024-08-20T14:05:00.000Z"
        },
        {
          "chat": "Thanks!",
          "userID": "abcd",
          "createdAt": "2024-08-20T14:06:00.000Z"
        },
        {
          "chat": "No problem.",
          "userID": "user002",
          "createdAt": "2024-08-20T14:07:00.000Z"
        },
        {
          "chat": "Talk to you later.",
          "userID": "abcd",
          "createdAt": "2024-08-20T14:08:00.000Z"
        },
        {
          "chat": "Bye!",
          "userID": "user002",
          "createdAt": "2024-08-20T14:09:00.000Z"
        }
      ]
    },
    {
      "name": "Carol Williams",
      "id": "chat003",
      "last_message": "Got it, thanks!",
      "createdAt": "2024-08-20T14:39:00.000Z",
      "profilePicture": "https://i.pravatar.cc/150?img=4",
      "chats": [
        {
          "chat": "Hello Carol!",
          "userID": "abcd",
          "createdAt": "2024-08-20T14:30:00.000Z"
        },
        {
          "chat": "Hey there!",
          "userID": "user003",
          "createdAt": "2024-08-20T14:31:00.000Z"
        },
        {
          "chat": "How are you?",
          "userID": "abcd",
          "createdAt": "2024-08-20T14:32:00.000Z"
        },
        {
          "chat": "Good, thanks!",
          "userID": "user003",
          "createdAt": "2024-08-20T14:33:00.000Z"
        },
        {
          "chat": "Great to hear!",
          "userID": "abcd",
          "createdAt": "2024-08-20T14:34:00.000Z"
        },
        {
          "chat": "What’s new?",
          "userID": "user003",
          "createdAt": "2024-08-20T14:35:00.000Z"
        },
        {
          "chat": "Not much, just working.",
          "userID": "abcd",
          "createdAt": "2024-08-20T14:36:00.000Z"
        },
        {
          "chat": "Sounds good.",
          "userID": "user003",
          "createdAt": "2024-08-20T14:37:00.000Z"
        },
        {
          "chat": "Yes, it’s going well.",
          "userID": "abcd",
          "createdAt": "2024-08-20T14:38:00.000Z"
        },
        {
          "chat": "Got it, thanks!",
          "userID": "user003",
          "createdAt": "2024-08-20T14:39:00.000Z"
        }
      ]
    },
    {
      "name": "David Lee",
      "id": "chat004",
      "last_message": "See you soon!",
      "createdAt": "2024-08-20T15:09:00.000Z",
      "profilePicture": "https://i.pravatar.cc/150?img=5",
      "chats": [
        {
          "chat": "Hey David!",
          "userID": "abcd",
          "createdAt": "2024-08-20T15:00:00.000Z"
        },
        {
          "chat": "Hi there!",
          "userID": "user004",
          "createdAt": "2024-08-20T15:01:00.000Z"
        },
        {
          "chat": "How's it going?",
          "userID": "abcd",
          "createdAt": "2024-08-20T15:02:00.000Z"
        },
        {
          "chat": "Going well!",
          "userID": "user004",
          "createdAt": "2024-08-20T15:03:00.000Z"
        },
        {
          "chat": "Glad to hear that.",
          "userID": "abcd",
          "createdAt": "2024-08-20T15:04:00.000Z"
        },
        {
          "chat": "Thanks!",
          "userID": "user004",
          "createdAt": "2024-08-20T15:05:00.000Z"
        },
        {
          "chat": "Talk to you later.",
          "userID": "abcd",
          "createdAt": "2024-08-20T15:06:00.000Z"
        },
        {
          "chat": "Sure thing.",
          "userID": "user004",
          "createdAt": "2024-08-20T15:07:00.000Z"
        },
        {
          "chat": "Catch you later!",
          "userID": "abcd",
          "createdAt": "2024-08-20T15:08:00.000Z"
        },
        {
          "chat": "See you soon!",
          "userID": "user004",
          "createdAt": "2024-08-20T15:09:00.000Z"
        }
      ]
    },
    {
      "name": "Eva Brown",
      "id": "chat005",
      "last_message": "Thanks for everything!",
      "createdAt": "2024-08-20T16:09:00.000Z",
      "profilePicture": "https://i.pravatar.cc/150?img=6",
      "chats": [
        {
          "chat": "Hello Eva!",
          "userID": "abcd",
          "createdAt": "2024-08-20T16:00:00.000Z"
        },
        {
          "chat": "Hi! How’s everything?",
          "userID": "user005",
          "createdAt": "2024-08-20T16:01:00.000Z"
        },
        {
          "chat": "Everything’s good!",
          "userID": "abcd",
          "createdAt": "2024-08-20T16:02:00.000Z"
        },
        {
          "chat": "Awesome!",
          "userID": "user005",
          "createdAt": "2024-08-20T16:03:00.000Z"
        },
        {
          "chat": "Glad to hear that.",
          "userID": "abcd",
          "createdAt": "2024-08-20T16:04:00.000Z"
        },
        {
          "chat": "Thanks for checking in.",
          "userID": "user005",
          "createdAt": "2024-08-20T16:05:00.000Z"
        },
        {
          "chat": "No problem!",
          "userID": "abcd",
          "createdAt": "2024-08-20T16:06:00.000Z"
        },
        {
          "chat": "Catch you later!",
          "userID": "user005",
          "createdAt": "2024-08-20T16:07:00.000Z"
        },
        {
          "chat": "Definitely.",
          "userID": "abcd",
          "createdAt": "2024-08-20T16:08:00.000Z"
        },
        {
          "chat": "Thanks for everything!",
          "userID": "user005",
          "createdAt": "2024-08-20T16:09:00.000Z"
        }
      ]
    }
  ];

}

final chatHomeProvider =
StateNotifierProvider<ChatProvider, ChatHomeState>((ref) {
  return ChatProvider();
});

