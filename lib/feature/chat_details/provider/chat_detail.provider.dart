import 'dart:convert';
import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:image_picker/image_picker.dart';
import 'package:intl/intl.dart';
import 'package:kaizenkode_test_app/feature/chat_home/model/chat_model.dart';


class ChatDetailHomeState {
  final bool isLoading;
  final List<ChatModel> allChats;
  final List<String> images;

  ChatDetailHomeState({
    required this.isLoading,
    required this.allChats,
    required this.images,
  });

  ChatDetailHomeState copyWith({
    bool? isLoading,
    List<ChatModel>? allChats,
    List<String>? images,
  }) {
    return ChatDetailHomeState(
      isLoading: isLoading ?? this.isLoading,
      allChats: allChats ?? this.allChats,
      images: images ?? this.images,
    );
  }
}

class ChatDetailProvider extends StateNotifier<ChatDetailHomeState> {

  ChatDetailProvider()
      : super(ChatDetailHomeState(
    isLoading: false,
    allChats: [],
    images: [],
  ));

  set setLoading(bool value) {
    state = state.copyWith(isLoading: value);
  }

  set setChat(List<ChatModel> value) {
    state = state.copyWith(allChats: value);
  }

  set setPickImage(String imagePath) {
    List<String> images = state.images;

    images.add(imagePath);

    state = state.copyWith(images: images);
  }

  TextEditingController textEditingController = TextEditingController();

  pickImage() async {
    try {
      final pickedImage = await ImagePicker().pickImage(
          source: ImageSource.gallery
      );
      if (pickedImage != null) {
        setPickImage = pickedImage.path;
      } else {
        log("Error getting images");
      }
    } catch (e) {
      log(e.toString());
    }
  }


}

final chatDetailHomeProvider =
StateNotifierProvider<ChatDetailProvider, ChatDetailHomeState>((ref) {
  return ChatDetailProvider();
});

