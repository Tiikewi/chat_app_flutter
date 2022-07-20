import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class MessageHandler {
  MessageHandler(this._user);

  final User _user;
  final _firestore = FirebaseFirestore.instance;

  void addNewMessage(String msg) {
    if (msg != "") {
      final message = <String, dynamic>{
        "sender": _user.email!,
        "text": msg,
        "time": FieldValue.serverTimestamp(),
      };
      _firestore.collection("messages").add(message).then(
          (DocumentReference doc) =>
              print('DocumentSnapshot added with ID: ${doc.id}'));
    }
  }
}
