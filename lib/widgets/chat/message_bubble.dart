//import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class MessageBubble extends StatelessWidget {
  final message;
  final bool isMe;
  //final Key key;
  final String userName;
  final String imageUrl;

  MessageBubble(
    this.message,
    this.isMe,
    this.userName,
    this.imageUrl,
  );

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Row(
          mainAxisAlignment:
              isMe ? MainAxisAlignment.end : MainAxisAlignment.start,
          children: [
            Container(
              decoration: BoxDecoration(
                color: isMe ? Colors.grey[300] : Theme.of(context).accentColor,
                borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(12),
                  topRight: Radius.circular(12),
                  bottomLeft: !isMe ? Radius.circular(0) : Radius.circular(12),
                  bottomRight: !isMe ? Radius.circular(12) : Radius.circular(0),
                ),
              ),
              width: 140,
              padding: EdgeInsets.symmetric(
                vertical: 10,
                horizontal: 10,
              ),
              margin: EdgeInsets.symmetric(
                horizontal: 10,
                vertical: 16,
              ),
              child: Column(
                crossAxisAlignment:
                    isMe ? CrossAxisAlignment.end : CrossAxisAlignment.start,
                children: [
                  // FutureBuilder(
                  //     future: FirebaseFirestore.instance
                  //         .collection('users')
                  //         .doc(userId)
                  //         .get(),
                  //     builder: (context, snapshot) {
                  //       if (snapshot.connectionState == ConnectionState.waiting) {
                  //         return Text('Loading..');
                  //       }
                  //       return
                  Text(
                    userName,
                    style: TextStyle(
                        color: isMe
                            ? Colors.black
                            : Theme.of(context)
                                .primaryTextTheme
                                .headline1
                                .color),
                  ),

                  Text(
                    message,
                    style: TextStyle(
                        color: isMe
                            ? Colors.black
                            : Theme.of(context)
                                .primaryTextTheme
                                .headline1
                                .color),
                  ),
                ],
              ),
            ),
          ],
        ),
        Positioned(
            top: 0,
            left: isMe ? null : 120,
            right: isMe ? 120 : null,
            child: CircleAvatar(
              backgroundImage: NetworkImage(imageUrl),
            )),
      ],
      overflow: Overflow.visible,
    );
  }
}
