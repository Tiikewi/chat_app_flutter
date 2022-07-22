import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_chat/screens/contacts_screen.dart';

import 'package:flutter_chat/screens/welcome_screen.dart';

import '../components/my_app_bar.dart';

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
              Expanded(
                child: ListView(
                  children: [
                    MessageListCard(),
                  ],
                ),
              ),
            ],
          ),
        ));
  }
}

class MessageListCard extends StatelessWidget {
  const MessageListCard({
    Key? key,
  }) : super(key: key);

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
                  Text("name here"),
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
