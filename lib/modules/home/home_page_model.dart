import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:mc_application/app_data.dart';
import 'package:mc_application/core/bases/base_page_model.dart';
import 'package:mc_application/core/helpers/navigator_helper.dart';
import 'package:mc_application/core/models/conversation_model.dart';
import 'package:mc_application/core/models/user_model.dart';
import 'package:mc_application/routes/route_config.dart';
import 'package:mc_application/services/local_storage_service.dart';
import 'package:mc_application/services/socket_service.dart';
import 'package:http/http.dart' as http;

class HomePageModel extends BasePageModel {
  final LocalStorageService localStorage = LocalStorageService();
  late SocketService socket;
  late List<dynamic> conversationList = [];

  Future<void> initializeSocketService() async {
    UserModel? user = await localStorage.getUserInfo();

    socket = SocketService.getInstance(authorizationToken: user!.accessToken);
    socket.onEvent('connect', (data) => print('Socket is connected!'));
    socket.emitEvent('join-room', {"roomId": user!.id});
  }

  Future<void> onRefresh() async {
    setBusy(true);
    await getConversation();
    setBusy(false);
  }

  Future<void> getConversation() async {
    try {
      UserModel? user = await localStorage.getUserInfo();
      final response = await http.get(
          headers: {'authorization': 'Bearer ${user!.accessToken}'},
          Uri.parse('${appData.apiHost}/api/chat/list'));

      if (response.statusCode == 200) {
        final conversationJson = jsonDecode(response.body)["data"];
        print(conversationJson);
        conversationList =
            conversationJson.map((csv) => ConversationModel.fromJson(csv)).toList();
      } else {
        Fluttertoast.showToast(msg: jsonDecode(response.body)["message"]);
      }
    } catch (e) {
      Fluttertoast.showToast(msg: '$e');
    }
  }

  onConversationClick(
      BuildContext context, String userId, String username, String isOnline) {
    navigatorHelper.changeView(context, RouteNames.chat,
        params: {"userId": userId, "username": username, "isOnline": isOnline});
  }
}
