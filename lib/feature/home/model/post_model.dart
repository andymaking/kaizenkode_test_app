class PostModel {
  String? name;
  String? topic;
  String? body;
  String? createdAt;
  bool? isPublic;
  String? profilePicture;
  String? postImage;

  PostModel({this.name, this.topic, this.createdAt, this.isPublic, this.profilePicture, this.body, this.postImage});

  PostModel.fromJson(Map<String, dynamic> json) {
    topic = json['topic'];
    name = json['name'];
    createdAt = json["createdAt"];
    isPublic = json["isPublic"];
    profilePicture = json["profilePicture"];
    body = json["body"];
    postImage = json["postImage"];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['name'] = name;
    data['topic'] = topic;
    data['isPublic'] = isPublic;
    data['body'] = body;
    data['profilePicture'] = profilePicture;
    data['postImage'] = postImage;
    data['createdAt'] = createdAt;
    return data;
  }
}