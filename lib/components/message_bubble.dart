import 'package:flutter/material.dart';
import 'package:flutter_chat/constants.dart';

class MessageBubble extends StatelessWidget {
  const MessageBubble(
      {Key? key,
      required this.sender,
      required this.message,
      required this.isMe})
      : super(key: key);

  final String sender;
  final String message;
  final bool isMe;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(10),
      child: Column(
        crossAxisAlignment:
            isMe ? CrossAxisAlignment.end : CrossAxisAlignment.start,
        children: [
          Text(
            sender,
            style: TextStyle(color: Colors.black54, fontSize: 10),
          ),
          Material(
            elevation: 10,
            borderRadius:
                isMe ? kMessageBubbleRadiusUser : kMessageBubbleRadiusOther,
            color:
                isMe ? kBubbleColorUser.shade400 : kBubbleColorOther.shade300,
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
              child: Text(
                message,
                style: TextStyle(fontSize: 13),
                textAlign: TextAlign.center,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
