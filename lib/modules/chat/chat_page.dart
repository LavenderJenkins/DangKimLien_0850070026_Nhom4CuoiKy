import 'package:flutter/material.dart';
import 'package:mc_application/core/appearances/colors.dart';
import 'package:mc_application/core/bases/base_mixin_model.dart';
import 'package:mc_application/core/helpers/screen_helper.dart';
import 'package:mc_application/core/widgets/loading/loading_widget.dart';
import 'package:mc_application/modules/chat/chat_page_model.dart';
import 'package:mc_application/modules/chat/widgets/message_widget.dart';
import 'package:mc_application/resources/modal_progress_hud.dart';
import 'package:mc_application/services/avatar_service.dart';
import 'package:need_resume/need_resume.dart';
import 'package:remixicon/remixicon.dart';

class ChatPage extends StatefulWidget {
  Map<String, String>? params;

  double widthScreen = screenHelper.getWidth();
  double heightScreen = screenHelper.getHeight();
  double yPadding = screenHelper.getHeightByPercent(0.02);
  double xPadding = screenHelper.getWidthByPercent(0.03);

  ChatPage({Key? key, this.params}) : super(key: key);

  @override
  State<ChatPage> createState() => _ChatPageState();
}

class _ChatPageState extends ResumableState<ChatPage>
    with MixinModel<ChatPageModel> {
  ChatPageModel chatPageModel = ChatPageModel();

  @override
  void initState() {
    super.initState();
    chatPageModel.getConversationMessages(widget.params!["userId"]!);
    chatPageModel.joinRoom(widget.params!["userId"]!);
  }

  @override
  void dispose() {
    chatPageModel.leaveRoom();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return present(context);
  }

  @override
  Function(BuildContext ctx, ChatPageModel model, Widget? child) withBuilder() {
    return (BuildContext context, ChatPageModel model, Widget? child) {
      return ModalProgressHUD(
          inAsyncCall: chatPageModel.busy,
          progressIndicator: const Loading(),
          child: buildBody(context));
    };
  }

  @override
  ChatPageModel withModel() {
    return chatPageModel;
  }

  buildBody(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: buildAppBar(),
        body: Container(
            padding: EdgeInsets.symmetric(
                vertical: widget.yPadding, horizontal: widget.xPadding),
            color: backgroundColor,
            child: Column(
              children: [
                Expanded(
                  child: ListView.builder(
                      itemCount: chatPageModel.messageList.length,
                      itemBuilder: (context, index) {
                        return Message(chatPageModel.messageList[index],
                            widget.params!["userId"]!);
                      }),
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Expanded(
                      child: TextField(
                        controller: chatPageModel.messageController,
                        decoration:
                            InputDecoration(hintText: 'Nhập tin nhắn...'),
                      ),
                    ),
                    IconButton(
                      // Hàm xử lý khi nhấn nút gửi
                      onPressed: () {
                        chatPageModel.messageInputFocus.unfocus();
                        String message =
                            chatPageModel.messageController.text.trim();
                        if (message.isNotEmpty) {
                          chatPageModel.sendMessage();
                        }
                      },
                      icon: Icon(Remix.send_plane_2_fill),
                    ),
                  ],
                ),
              ],
            )),
      ),
    );
  }

  AppBar buildAppBar() {
    return AppBar(
        backgroundColor: backgroundColor,
        elevation: 0.5,
        toolbarHeight: screenHelper.getHeightByPercent(0.12),
        title: Container(
          child:
              Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [
            Column(
              children: [
                Row(
                  children: [
                    AvatarFromUsername(username: widget.params!["username"]!),
                    Column(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            widget.params!["username"]!,
                            style: const TextStyle(
                                fontSize: 14, fontWeight: FontWeight.w600),
                          ),
                          Text(
                            widget.params!["isOnline"] == 'true'
                                ? 'Online'
                                : 'Offline',
                            style: TextStyle(
                              fontSize: 12,
                              fontWeight: FontWeight.w400,
                              color: widget.params!["isOnline"] == 'true'
                                  ? primaryGreen
                                  : Colors.grey,
                            ),
                          ),
                        ])
                  ],
                )
              ],
            ),
            Column(
              children: [
                IconButton(onPressed: () {}, icon: Icon(Remix.menu_3_line))
              ],
            )
          ]),
        ));
  }
}
