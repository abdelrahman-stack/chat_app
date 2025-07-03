import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:scholar_app/constants.dart';
import 'package:scholar_app/models/messages_model.dart';
import 'package:scholar_app/widgets/chat_bubble.dart';

class ChatView extends StatelessWidget {
  ChatView({super.key, required this.userEmail});

  final String userEmail;
  final _controller = ScrollController();
  final TextEditingController controller = TextEditingController();
  final CollectionReference messages =
      FirebaseFirestore.instance.collection('messages');

  @override
  Widget build(BuildContext context) {
    return StreamBuilder<QuerySnapshot>(
      stream: messages.orderBy('createdAt', descending: true).snapshots(),
      builder: (context, snapshot) {
        if (snapshot.hasData) {
          List<MessagesModel> messagesList = snapshot.data!.docs
              .map((doc) => MessagesModel.fromJson(doc))
              .toList();

          return Scaffold(
            appBar: AppBar(
              backgroundColor: kPraimaryColor,
              title: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Image.asset('assets/images/scholar.png', height: 60),
                  const SizedBox(width: 5),
                  const Text(
                    'Scholar Chat',
                    style: TextStyle(
                      fontWeight: FontWeight.w600,
                      color: Colors.white,),
                  ),
                ],
              ),
            ),
            body: Column(
              children: [
                Expanded(
                  child: ListView.builder(
                    reverse: true,
                    controller: _controller,
                    itemCount: messagesList.length,
                    itemBuilder: (context, index) {
                      final message = messagesList[index];
                      return message.email == userEmail
                          ? ChatBubble(messagesModel: message)
                          : ChatBubbleForFriend(messagesModel: message);
                    },
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(16),
                  child: TextField(
                    controller: controller,
                    decoration: InputDecoration(
                      suffixIcon: IconButton(
                        icon: const Icon(Icons.send, color: kPraimaryColor),
                        onPressed: sendMessage,
                      ),
                      hintText: 'Send Message',
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(12),
                      ),
                      enabledBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(12),
                        borderSide: const BorderSide(color: kPraimaryColor),
                      ),
                    ),
                  ),
                ),
              ],
            ),
          );
        } else {
          return const Center(child: CircularProgressIndicator());
        }
      },
    );
  }

  void sendMessage() {
    final text = controller.text.trim();
    if (text.isNotEmpty) {
      messages.add({
        'message': text,
        'createdAt': DateTime.now(),
        'email': userEmail,
      });
      controller.clear();
      _controller.animateTo(
        0,
        curve: Curves.fastOutSlowIn,
        duration: const Duration(milliseconds: 500),
      );
    }
  }
}
