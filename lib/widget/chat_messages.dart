import 'package:chat_bubbles/bubbles/bubble_special_three.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class ChatMessages extends StatelessWidget {
  const ChatMessages(
      {super.key, required this.senderId, required this.receiverId});
  final String senderId;
  final String receiverId;

  @override
  Widget build(BuildContext context) {
    final userAuth = FirebaseAuth.instance.currentUser!.uid;
    return StreamBuilder(
      stream: FirebaseFirestore.instance
          .collection('chats')
          .orderBy('createdAt', descending: true)
          .snapshots(),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const Center(child: CircularProgressIndicator());
        }
        if (!snapshot.hasData || snapshot.data!.docs.isEmpty) {
          return const Text('No messgaes Found');
        }
        if (snapshot.hasError) {
          return const Text('Something went wrong ..  ');
        }

        final loadedMessages = snapshot.data!.docs;

        return ListView.builder(
            padding: const EdgeInsets.only(bottom: 40, left: 13, right: 13),
            reverse: true,
            itemCount: loadedMessages.length,
            itemBuilder: (context, index) {
              final chatMessage = loadedMessages[index].data();
              final nextMessage = index + 1 < loadedMessages.length
                  ? loadedMessages[index + 1].data()
                  : null;
              final currentMessageUserId = chatMessage['userId'];
              final nextMessageUserId =
                  nextMessage != null ? nextMessage['userId'] : null;

              final bool nextUserIsSame =
                  currentMessageUserId == nextMessageUserId;
              if ((chatMessage['senderId'] == senderId &&
                      chatMessage['receiverId'] == receiverId) ||
                  (chatMessage['senderId'] == receiverId &&
                      chatMessage['receiverId'] == senderId)) {
                return BubbleSpecialThree(
                  text: chatMessage['text'],
                  isSender: chatMessage['senderId'] == userAuth ? true : false,
                  color: chatMessage['senderId'] == userAuth
                      ? const Color.fromARGB(255, 218, 218, 218)
                      : Colors.blue,
                );
              } else {
                return const SizedBox();
              }
              /*if(nextUserIsSame){
              return MessageBubble.next(
                message: chatMessage['text'],
                isMe: userAuth!.uid == currentMessageUserId);
            }
            else{
              return MessageBubble.first(
                userImage: chatMessage['ImageUrl'], 
                username: chatMessage['username'], 
                message: chatMessage['text'], 
                isMe: userAuth!.uid == currentMessageUserId);
            }*/
            });
      },
    );
  }
}
