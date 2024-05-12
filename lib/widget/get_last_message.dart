import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class GetLastMessage extends StatelessWidget {
  const GetLastMessage({super.key, required this.senderId , required this.receiverId});
  final String senderId;
  final String receiverId;

  @override
  Widget build(BuildContext context) {
    return StreamBuilder(
      stream: FirebaseFirestore.instance.collection('chats').snapshots(),
      builder: (context, snapshot) {
        final loadedMessages = snapshot.data!.docs;
        final lastMessage = loadedMessages[loadedMessages.length].data();
        if((lastMessage['senderId']==senderId && lastMessage['receiverId'] == receiverId) ||(lastMessage['senderId']==receiverId && lastMessage['receiverId'] == senderId)){
              return const Text('hi');
        }
        else{
          return const SizedBox();
        }
      },);
  }
}