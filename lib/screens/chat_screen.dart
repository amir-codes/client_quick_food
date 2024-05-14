import 'package:client_quick_food/widget/chat_messages.dart';
import 'package:client_quick_food/widget/new_message.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class ChatScreen extends StatelessWidget {
  const ChatScreen(
      {super.key,
      required this.senderId,
      required this.receiverId,
      required this.receiverName});
  final String senderId;
  final String receiverId;
  final String receiverName;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          receiverName,
          style: GoogleFonts.signikaNegative(
            fontSize: 20,
            fontWeight: FontWeight.w700,
          ),
        ),
      ),
      body: Column(
        children: [
          Expanded(
            child: ChatMessages(
              senderId: senderId,
              receiverId: receiverId,
            ),
          ),
          NewMessage(
            senderId: senderId,
            receiverId: receiverId,
          ),
        ],
      ),
    );
  }
}
