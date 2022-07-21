import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

import '../components/message_bubble.dart';

final _firestore = FirebaseFirestore.instance;

class ChatStream extends StatefulWidget {
  const ChatStream({Key? key}) : super(key: key);

  @override
  State<ChatStream> createState() => _ChatStreamState();
}

class _ChatStreamState extends State<ChatStream> {
  var fireStoreStream = _firestore
      .collection('messages')
      .orderBy("time", descending: true)
      .snapshots();

  @override
  Widget build(BuildContext context) {
    return StreamBuilder<QuerySnapshot>(
      stream: fireStoreStream,
      builder: (context, AsyncSnapshot<QuerySnapshot> snapshot) {
        List<Widget> children = [];

        if (snapshot.hasError) {
          children = <Widget>[
            const Icon(
              Icons.error_outline,
              color: Colors.red,
              size: 60,
            ),
            Padding(
              padding: const EdgeInsets.only(top: 16),
              child: Text('Error: ${snapshot.error}'),
            ),
            Padding(
              padding: const EdgeInsets.only(top: 8),
              child: Text('Stack trace: ${snapshot.stackTrace}'),
            ),
          ];
        }
        if (!snapshot.hasData) {
          return const Center(
            child: CircularProgressIndicator(
              backgroundColor: Colors.blue,
            ),
          );
        }

        var messages = snapshot.data!.docs;

        final currentUser =
            FirebaseAuth.instance.currentUser?.email ?? "sender not found";

        for (var msg in messages) {
          final msgWidget = MessageBubble(
            sender: msg["sender"],
            message: msg["text"],
            isMe: currentUser == msg["sender"],
          );
          children.add(msgWidget);
        }

        return Expanded(
          child: ListView(
            reverse: true,
            children: children,
          ),
        );
      },
    );
  }
}
