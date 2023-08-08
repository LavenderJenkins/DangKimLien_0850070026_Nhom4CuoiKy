import 'package:flutter/material.dart';
import 'package:mc_application/core/appearances/colors.dart';
import 'package:mc_application/core/helpers/screen_helper.dart';
import 'package:mc_application/services/avatar_service.dart';

class Conversation extends StatefulWidget {
  final String userId;
  final String username;
  final String latestMessage;
  final DateTime time;
  final bool isOnline;
  final dynamic onClick;

  const Conversation(this.userId,
      {required this.username,
      required this.isOnline,
      required this.latestMessage,
      required this.time,
      required this.onClick,
      super.key});

  @override
  State<Conversation> createState() => _ConversationState();
}

class _ConversationState extends State<Conversation> {
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => widget.onClick(
          context, widget.userId, widget.username, widget.isOnline.toString()),
      child: Container(
        decoration: const BoxDecoration(color: Colors.white),
        padding: EdgeInsets.symmetric(
            vertical: screenHelper.getHeightByPercent(0.03),
            horizontal: screenHelper.getWidthByPercent(0.02)),
        margin: EdgeInsets.only(bottom: screenHelper.getHeightByPercent(0.02)),
        child: Row(children: [
          Column(
            children: [
              Row(
                children: [
                  Stack(children: [
                    AvatarFromUsername(username: widget.username),
                    Positioned(
                      bottom: 0,
                      right: 0,
                      child: Container(
                        width: screenHelper.setWidth(15),
                        height: screenHelper.setHeight(15),
                        decoration: BoxDecoration(
                            color: widget.isOnline ? primaryGreen : Colors.grey,
                            borderRadius: BorderRadius.circular(50),
                            border: Border.all(width: 2, color: Colors.white)),
                      ),
                    )
                  ]),
                  SizedBox(width: screenHelper.setWidth(10)),
                  SizedBox(
                    width: screenHelper.getWidthByPercent(0.5),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          widget.username,
                          style: const TextStyle(fontWeight: FontWeight.w600),
                        ),
                        SizedBox(height: screenHelper.setWidth(5)),
                        Text(
                            widget.latestMessage,
                            overflow: TextOverflow.ellipsis,
                            maxLines: 2,
                            style: TextStyle(
                              fontSize: 12,
                              color: Colors.grey[700],
                            )),
                      ],
                    ),
                  ),
                  Container(
                    width: screenHelper.getWidthByPercent(0.2),
                    child: Column(
                        // mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                           (widget.time).toString().substring(11, 16),
                            style: TextStyle(
                                fontSize: 12, fontWeight: FontWeight.bold),
                          ),
                          // SizedBox(height: screenHelper.setHeight(10)),
                          // Container(
                          //   width: screenHelper.setWidth(15),
                          //   height: screenHelper.setHeight(15),
                          //   decoration: BoxDecoration(
                          //       shape: BoxShape.circle, color: primaryGreen),
                          //   child: Text(
                          //     '3',
                          //     textAlign: TextAlign.center,
                          //     style: TextStyle(
                          //         color: Colors.white,
                          //         fontSize: 12,
                          //         fontWeight: FontWeight.bold),
                          //   ),
                          // )
                        ]),
                  )
                ],
              )
            ],
          )
        ]),
      ),
    );
  }
}
