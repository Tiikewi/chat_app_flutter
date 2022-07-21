import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_chat/screens/welcome_screen.dart';

class ChatListScreen extends StatelessWidget {
  ChatListScreen({Key? key}) : super(key: key);
  static String id = 'chat_list_screen';
  final FirebaseAuth _auth = FirebaseAuth.instance;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          leading: null,
          actions: <Widget>[
            IconButton(
                icon: const Icon(Icons.close),
                onPressed: () async {
                  await _auth.signOut();

                  Navigator.popUntil(context, (route) => route.isFirst);
                  Navigator.pushReplacementNamed(context, WelcomeScreen.id);
                }),
          ],
          title: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: const [
              Image(
                image: AssetImage("images/duck.png"),
                height: 30,
              ),
              SizedBox(
                width: 2,
              ),
              Text('Contacts'),
            ],
          ),
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
