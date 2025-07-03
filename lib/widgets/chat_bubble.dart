import 'package:flutter/material.dart';
import 'package:scholar_app/constants.dart';
import 'package:scholar_app/models/messages_model.dart';

class ChatBubble extends StatelessWidget {
  const ChatBubble({super.key, required this.messagesModel});
  final MessagesModel messagesModel;
  @override
  Widget build(BuildContext context) {
    return Align(
      alignment: Alignment.centerLeft,
      child: Container(
        padding: EdgeInsets.symmetric(horizontal: 32, vertical: 16),
        margin: EdgeInsets.all(8),
        decoration: BoxDecoration(
          color: kPraimaryColor,
          borderRadius: BorderRadius.only(
            topLeft: Radius.circular(32),
            topRight: Radius.circular(32),
            bottomRight: Radius.circular(32),
          ),
        ),
        child: Text(
          messagesModel.message,
          style: TextStyle(color: Colors.white, fontSize: 16),
        ),
      ),
    );
  }
}



class ChatBubbleForFriend extends StatelessWidget {
  const ChatBubbleForFriend({super.key, required this.messagesModel});
  final MessagesModel messagesModel;
  @override
  Widget build(BuildContext context) {
    return Align(
      alignment: Alignment.centerRight,
      child: Container(
        padding: EdgeInsets.symmetric(horizontal: 32, vertical: 16),
        margin: EdgeInsets.all(8),
        decoration: BoxDecoration(
          color: Color(0xff007d84),
          borderRadius: BorderRadius.only(
            topLeft: Radius.circular(32),
            topRight: Radius.circular(32),
            bottomLeft: Radius.circular(32),
          ),
        ),
        child: Text(
          messagesModel.message,
          style: TextStyle(color: Colors.white, fontSize: 16),
        ),
      ),
    );
  }
}