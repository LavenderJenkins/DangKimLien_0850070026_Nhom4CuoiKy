import 'package:flutter/material.dart';
import 'package:mc_application/core/helpers/screen_helper.dart';
import 'package:mc_application/core/models/message_model.dart';
import 'package:mc_application/services/avatar_service.dart';

class Message extends StatelessWidget {
  final MessageModel messageModel;
  final String currentUserId;

  const Message(this.messageModel, this.currentUserId, {super.key});

  @override
  Widget build(BuildContext context) {
    final bool isCurrentUser = messageModel.userId == currentUserId;

    return Container(
      alignment: isCurrentUser ? Alignment.centerLeft : Alignment.centerRight,
      child: Column(
        crossAxisAlignment:
            isCurrentUser ? CrossAxisAlignment.start : CrossAxisAlignment.end,
        children: [
          Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              if (!isCurrentUser) const SizedBox(width: 10),
              if (isCurrentUser)
                AvatarFromUsername(username: messageModel.username),
              Stack(
                children:[ Container(
                  constraints: BoxConstraints(
                      maxWidth: screenHelper.getWidthByPercent(0.5)),
                  decoration: BoxDecoration(
                    boxShadow: [
                      BoxShadow(
                        color: Colors.grey.withOpacity(0.5), // Màu của đổ bóng
                        spreadRadius: 2,
                        blurRadius: 5,
                        offset: const Offset(0, 3),
                      ),
                    ],
                    color: isCurrentUser ? Colors.blue : Colors.white,
                    borderRadius: BorderRadius.circular(8),
                  ),
                  padding:
                      EdgeInsets.only(top: 12, bottom: 12, left: (isCurrentUser) ? 8 : 30, right: isCurrentUser ? 30 : 8),
                  child: Text(
                    messageModel.message,
                    overflow: TextOverflow.clip,
                    softWrap: true,
                    maxLines: null,
                    style: TextStyle(
                      color: isCurrentUser ? Colors.white : Colors.black,
                    ),
                  ),
                ),
                Positioned(
                  left: isCurrentUser ? null : 5,
                  right: isCurrentUser ? 5 : null,
                  bottom: 2,
                  child: Text(
                           (messageModel.time).toString().substring(11, 16),
                            style: TextStyle(
                                fontSize: 8, fontWeight: FontWeight.w400,
                                color: isCurrentUser ? Colors.white : Colors.black),
                          ),)
                ]
              ),
              if (!isCurrentUser)
                AvatarFromUsername(username: messageModel.username),
            ],
          ),
        ],
      ),
    );
  }
}
