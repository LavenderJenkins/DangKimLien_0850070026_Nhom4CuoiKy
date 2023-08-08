class ConversationModel {
  final String id;
  final String username;
  final String latestMessage;
  final DateTime time;
  String? accessToken;
  bool? isOnline = false;

  ConversationModel({
    required this.id,
    required this.username,
    required this.latestMessage,
    required this.time,
    this.accessToken,
    this.isOnline,
  });

  factory ConversationModel.fromJson(Map<String, dynamic> json) {
    return ConversationModel(
      id: json['id'],
      username: json['username'],
      latestMessage: json['latestMessage'],
      time: DateTime.parse(json['time']),
      isOnline: json['isOnline'],
    );
  }

  toJson() {
    Map<String, dynamic> data = {
      "id": id,
      "username": username,
      "latestMessage": latestMessage,
      "time": time,
      "isOnline": isOnline,
    };
    return data;
  }
}
