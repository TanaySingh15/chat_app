import 'package:chat_app/widgets/chat/message_bubble.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class Messages extends StatelessWidget {
  final User user = FirebaseAuth.instance.currentUser;

  @override
  Widget build(BuildContext context) {
    return StreamBuilder(
      stream: FirebaseFirestore.instance
          .collection('chats')
          .orderBy('createdAt', descending: true)
          .snapshots(),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return Center(
            child: CircularProgressIndicator(),
          );
        }
        final chatDocs = snapshot.data.docs;
        return ListView.builder(
          reverse: true,
          itemBuilder: (context, index) => MessageBubble(
            chatDocs[index]['text'],
            chatDocs[index]['userId'] == user.uid,
            //key: ValueKey(chatDocs[index].documentID),
            chatDocs[index]['username'],
            chatDocs[index]['userImage'],
          ),
          itemCount: chatDocs.length,
        );
      },
    );
  }
}
