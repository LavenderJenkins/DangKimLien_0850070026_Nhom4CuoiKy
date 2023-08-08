import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:mc_application/app_data.dart';
import 'package:mc_application/core/bases/base_page_model.dart';
import 'package:mc_application/core/models/message_model.dart';
import 'package:mc_application/core/models/user_model.dart';
import 'package:mc_application/services/local_storage_service.dart';
import 'package:http/http.dart' as http;
import 'package:mc_application/services/socket_service.dart';

class ChatPageModel extends BasePageModel {
  final LocalStorageService localStorage = LocalStorageService();
  late SocketService socketService =
      SocketService.getInstance(authorizationToken: '');
  List<dynamic> messageList = [];

  String latestRoomId = '';
  final TextEditingController _messageController = TextEditingController();
  get messageController => _messageController;

  FocusNode messageInputFocus = FocusNode();

  void joinRoom(String userId) async {
    socketService.emitEvent('join-room', {"roomId": userId});
    latestRoomId = userId;
    socketService.onEvent('chatting', (data) {
      MessageModel newMessage = MessageModel.fromJson(data);
      messageList.add(newMessage);
      notifyListeners();
    });
  }

  void leaveRoom() async {
    socketService.emitEvent('leave-room', {"roomId": latestRoomId});
    socketService.offEvent('chatting');
  }

  void sendMessage() async {
    UserModel? user = await localStorage.getUserInfo();

    messageInputFocus.unfocus();
    String message = _messageController.text.trim();
    if (message.isNotEmpty) {
      // Gửi tin nhắn ở đây (thêm tin nhắn mới vào danh sách)
      MessageModel newMessage = MessageModel(
        userId: user!.id, // Thay đổi userId tùy vào người dùng hiện tại
        username:
            user.username, // Thay đổi username tùy vào người dùng hiện tại
        message: message,
        time: DateTime.now(),
      );
      socketService.emitEvent('chatting', newMessage.toJson());

      messageList.add(newMessage);
      _messageController.clear();
      notifyListeners(); // Cập nhật giao diện sau khi gửi tin nhắn
    }
  }

  Future<void> getConversationMessages(String userId) async {
    try {
      UserModel? user = await localStorage.getUserInfo();
      final response = await http.get(
          headers: {'authorization': 'Bearer ${user!.accessToken}'},
          Uri.parse('${appData.apiHost}/api/chat/$userId'));

      if (response.statusCode == 200) {
        final messageJson = jsonDecode(response.body)["data"];
        messageList =
            messageJson.map((msg) => MessageModel.fromJson(msg)).toList();
      } else {
        Fluttertoast.showToast(msg: jsonDecode(response.body)["message"]);
      }
    } catch (e) {
      Fluttertoast.showToast(msg: '$e');
    }
    notifyListeners();
  }
}
