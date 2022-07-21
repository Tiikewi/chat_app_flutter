import 'package:flutter/material.dart';
import 'package:flutter_chat/chat_screen_utils.dart/chat_msg_handler.dart';
import 'package:flutter_chat/constants.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter_chat/components/message_bubble.dart';
import 'package:flutter_chat/screens/welcome_screen.dart';

import '../chat_screen_utils.dart/chat_stream.dart';

final _firestore = FirebaseFirestore.instance;

late User _user;

class ChatScreen extends StatefulWidget {
  static String id = 'chat_screen';

  ChatScreen({Key? key}) : super(key: key);

  @override
  ChatScreenState createState() => ChatScreenState();
}

class ChatScreenState extends State<ChatScreen> {
  final TextEditingController _chatInputController = TextEditingController();
  final _auth = FirebaseAuth.instance;
  String _msg = "";

  @override
  void initState() {
    super.initState();
    _user = FirebaseAuth.instance.currentUser!;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: null,
        actions: <Widget>[
          IconButton(
              icon: Icon(Icons.close),
              onPressed: () async {
                await _auth.signOut();
                if (!mounted) return;
                Navigator.popUntil(context, (route) => route.isFirst);
                Navigator.pushReplacementNamed(context, WelcomeScreen.id);
              }),
        ],
        title: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Image(
              image: AssetImage("images/duck.png"),
              height: 30,
            ),
            SizedBox(
              width: 2,
            ),
            Text('Chat'),
          ],
        ),
      ),
      body: SafeArea(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: <Widget>[
            ChatStream(),
            Container(
              decoration: kMessageContainerDecoration,
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: <Widget>[
                  Expanded(
                    child: TextField(
                      controller: _chatInputController,
                      onChanged: (value) {
                        setState(() {
                          _msg = value;
                        });
                      },
                      decoration: kMessageTextFieldDecoration,
                    ),
                  ),
                  TextButton(
                    onPressed: () {
                      MessageHandler(_user).addNewMessage(_msg);

                      _chatInputController.clear();
                      _msg = "";
                    },
                    child: Text(
                      'Send',
                      style: kSendButtonTextStyle,
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
