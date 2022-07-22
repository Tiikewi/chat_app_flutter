import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_chat/screens/contacts_screen.dart';

import 'package:flutter_chat/screens/welcome_screen.dart';

import '../components/my_app_bar.dart';

final _firestore = FirebaseFirestore.instance;
FirebaseAuth auth = FirebaseAuth.instance;

class ChatListScreen extends StatelessWidget {
  ChatListScreen({Key? key}) : super(key: key);
  static String id = 'chat_list_screen';
  final FirebaseAuth _auth = FirebaseAuth.instance;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: MyAppBar(
          title: "Chats",
          afterLogOut: () =>
              Navigator.pushReplacementNamed(context, WelcomeScreen.id),
          pushContacsScreen: () =>
              Navigator.pushNamed(context, ContactsScreen.id),
        ),
        body: SafeArea(
          child: Column(
            children: [
              MessageListStream(),
            ],
          ),
        ));
  }
}

class MessageListStream extends StatefulWidget {
  const MessageListStream({Key? key}) : super(key: key);

  @override
  State<MessageListStream> createState() => _MessageListStreamState();
}

class _MessageListStreamState extends State<MessageListStream> {
  var fireStoreStream = _firestore.collection('users').snapshots();

  @override
  Widget build(BuildContext context) {
    return StreamBuilder(
        stream: fireStoreStream,
        builder: (context, AsyncSnapshot<QuerySnapshot> snapshot) {
          if (!snapshot.hasData) {
            return const Center(
              child: CircularProgressIndicator(
                backgroundColor: Colors.blue,
              ),
            );
          }
          var cts = <Widget>[];
          var users = snapshot.data!.docs;

          for (var user in users) {
            if (user.id == auth.currentUser?.uid) {
              for (var id in user["groups"]) {
                cts.add(MessageListCard(name: id));
              }
            }
          }

          return Expanded(
            child: ListView(
              children: cts,
            ),
          );
        });
  }
}

class MessageListCard extends StatelessWidget {
  MessageListCard({Key? key, required this.name}) : super(key: key);

  final String name;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => print("message list item clicked"),
      child: Card(
        color: Colors.lightGreen,
        elevation: 10,
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              const CircleAvatar(
                child: Text("pic"),
              ),
              Column(
                children: [
                  Text(name),
                  Text("message here"),
                ],
              ),
              Text("time"),
            ],
          ),
        ),
      ),
    );
  }
}
