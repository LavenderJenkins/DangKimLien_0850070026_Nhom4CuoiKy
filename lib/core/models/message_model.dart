class MessageModel {
  final String userId;
  final String username;
  final String message;
  final DateTime time;

  MessageModel({required this.userId, required this.username, required this.message, required this.time});

  factory MessageModel.fromJson(Map<String, dynamic> json) {
    return MessageModel(
      userId: json['userid'] ?? json['userId'],
      username: json['username'],
      message: json['message'],
      time: DateTime.parse(json['time']),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'userId': userId,
      'username': username,
      'message': message,
      'time': time.toIso8601String(),
    };
  }
}
