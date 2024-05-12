import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class NewMessage extends StatefulWidget {
  const NewMessage({super.key, required this.senderId , required this.receiverId});
  final String senderId;
  final String receiverId;
  
  @override
  State<NewMessage> createState() => _NewMessageState();
}

class _NewMessageState extends State<NewMessage> {
  final _messageController = TextEditingController();

  @override
  void dispose() {
    // TODO: implement dispose
    _messageController.dispose();
  }

  void _sendMessage()async{
     final entredMessage = _messageController.text;

     if(entredMessage.trim().isEmpty){
      return;
     }
     
     FocusScope.of(context).unfocus();
     _messageController.clear();

     final User user = FirebaseAuth.instance.currentUser!;


     final userData =await FirebaseFirestore.instance.collection('restaurants').doc(user.email)
     .get();

     await FirebaseFirestore.instance.collection('chats').add({
      'senderId' : widget.senderId,
      'receiverId':widget.receiverId,
      'text' : entredMessage ,
      'createdAt' : Timestamp.now() ,
      'username' : userData.data()!['username'],
      'ImageUrl' : userData.data()!['ImageUrl'],
     });

     
  }

  @override
  Widget build(BuildContext context) {
    return  Padding(
      padding: const EdgeInsets.only(right: 10 , left: 10,bottom: 5),
      child: Row(
        children: [
           Expanded(
            child: TextField(
              controller: _messageController,
              decoration:  const InputDecoration(labelText: 'Send message ..'),
              enableSuggestions: true,
              autocorrect: true,
              textCapitalization: TextCapitalization.sentences,
            )
            ),
          IconButton(
            onPressed: _sendMessage, 
            icon: Icon(
              Icons.send,
              color: Theme.of(context).colorScheme.primary,
              ))
        ],
      ),
      );
  }
}