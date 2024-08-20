import 'dart:convert';

List<ChatModel> getResponseDataListFromJson(String str) =>
    List<ChatModel>.from(
        json.decode(str).map((x) => ChatModel.fromJson(x)));

class ChatModel {
  String? name;
  String? id;
  String? lastMessage;
  String? createdAt;
  String? profilePicture;
  List<Chats>? chats;

  ChatModel(
      {this.name,
        this.id,
        this.lastMessage,
        this.createdAt,
        this.profilePicture,
        this.chats});

  ChatModel.fromJson(Map<String, dynamic> json) {
    name = json['name'];
    id = json['id'];
    lastMessage = json['last_message'];
    createdAt = json['createdAt'];
    profilePicture = json['profilePicture'];
    if (json['chats'] != null) {
      chats = <Chats>[];
      json['chats'].forEach((v) {
        chats!.add(new Chats.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['name'] = this.name;
    data['id'] = this.id;
    data['last_message'] = this.lastMessage;
    data['createdAt'] = this.createdAt;
    data['profilePicture'] = this.profilePicture;
    if (this.chats != null) {
      data['chats'] = this.chats!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class Chats {
  String? chat;
  String? userID;
  String? createdAt;

  Chats({this.chat, this.userID, this.createdAt});

  Chats.fromJson(Map<String, dynamic> json) {
    chat = json['chat'];
    userID = json['userID'];
    createdAt = json['createdAt'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['chat'] = this.chat;
    data['userID'] = this.userID;
    data['createdAt'] = this.createdAt;
    return data;
  }
}
