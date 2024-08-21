import 'dart:convert';
import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:image_picker/image_picker.dart';
import 'package:intl/intl.dart';
import 'package:kaizenkode_test_app/data/routes/app_routers.dart';
import 'package:kaizenkode_test_app/feature/chat_home/model/chat_model.dart';
import 'package:kaizenkode_test_app/widgets/custom_snackbar.dart';


class CreatePostState {
  final bool isLoading;
  final List<String> images;
  final List<String> types;
  final String? selectedPostType;
  final String? selectedTopic;

  CreatePostState({
    required this.isLoading,
    required this.images,
    required this.types,
    this.selectedPostType,
    this.selectedTopic,
  });

  CreatePostState copyWith({
    bool? isLoading,
    List<String>? images,
    List<String>? types,
    String? selectedPostType,
    String? selectedTopic,
  }) {
    return CreatePostState(
      isLoading: isLoading ?? this.isLoading,
      images: images ?? this.images,
      types: types ?? this.types,
      selectedPostType: selectedPostType ?? this.selectedPostType,
      selectedTopic: selectedTopic ?? this.selectedTopic
    );
  }
}

class CreatePostProvider extends StateNotifier<CreatePostState> {

  CreatePostProvider()
      : super(CreatePostState(
    isLoading: false,
    images: [],
    types: [],
    selectedPostType: null,
    selectedTopic: null,
  )){
    setAllTypes = postType;
  }

  set setAllTypes(List<String> value) {
    state = state.copyWith(types: value);
  }

  set setLoading(bool value) {
    state = state.copyWith(isLoading: value);
  }

  set seSelectPostType(String? value) {
    state = state.copyWith(selectedPostType: value);
  }

  set seSelectPostTopic(String? value) {
    state = state.copyWith(selectedTopic: value);
  }

  set deleteImage(String? val) {
    state = state.copyWith(images: []);
  }

  List<String> postType = ["Public", "Business"];

  changePostTopic(String? val){
    if(state.selectedTopic == val){
      seSelectPostTopic = null;
    }else{
      seSelectPostTopic = val;
    }
  }

  removeImage()async{
    deleteImage= "";
  }

  TextEditingController messageController = TextEditingController();

  onChanged(String? val){

  }

  submit(BuildContext context){
    if(state.selectedTopic == null){
      showSnackBar("Select topic to proceed", context);
    }else if(state.selectedPostType == null){
      showSnackBar("Select post type to proceed", context);
    }else if(messageController.text.trim().isEmpty){
      showSnackBar("Enter text to proceed", context);
    }else {
      showSnackBar("Post created successfully", context, success: true);
      context.go(AppRoute.homeScreen);
    }
  }

  changePostType(String? val){
    log(state.selectedPostType.toString());
    log(val.toString());
    if(state.selectedPostType == val){
      print("here");
      seSelectPostType = null;
    }else{
      seSelectPostType = val;
    }
  }

  set setPickImage(String imagePath) {
    List<String> images = state.images;

    images.add(imagePath);

    state = state.copyWith(images: images);
  }

  TextEditingController textEditingController = TextEditingController();

  pickImage({ImageSource? imageSource}) async {
    try {
      final pickedImage = await ImagePicker().pickImage(
          source: imageSource?? ImageSource.gallery
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

final createPostProvider =
StateNotifierProvider<CreatePostProvider, CreatePostState>((ref) {
  return CreatePostProvider();
});

