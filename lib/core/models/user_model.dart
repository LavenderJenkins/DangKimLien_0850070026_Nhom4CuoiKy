class UserModel {
  final String id;
  final String username;
  final String avatar;
  String? accessToken;
  bool? isOnline = false;

  UserModel({
    required this.id,
    required this.username,
    required this.avatar,
    this.accessToken,
    this.isOnline,
  });

  factory UserModel.fromJson(Map<String, dynamic> json) {
    return UserModel(
      id: json['id'],
      username: json['username'],
      avatar: json['avatar'],
      accessToken: json['accessToken'],
      isOnline: json['isOnline'],
    );
  }

  toJson() {
    Map<String, dynamic> data = {
      "id": id,
      "avatar": avatar,
      "username": username,
      "accessToken": accessToken,
      "isOnline": isOnline,
    };
    return data;
  }
}
