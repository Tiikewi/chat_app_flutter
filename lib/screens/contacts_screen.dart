import 'package:flutter/material.dart';

import 'package:sliding_up_panel/sliding_up_panel.dart';

class ContactsScreen extends StatelessWidget {
  const ContactsScreen({Key? key}) : super(key: key);
  static String id = "contacts_screen";

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Text("contacs screen"),
      ),
    );
  }
}
