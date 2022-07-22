import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_chat/components/my_app_bar.dart';
import 'package:flutter_chat/screens/welcome_screen.dart';

import 'package:sliding_up_panel/sliding_up_panel.dart';

final _firestore = FirebaseFirestore.instance;

class ContactsScreen extends StatefulWidget {
  const ContactsScreen({Key? key}) : super(key: key);
  static String id = "contacts_screen";

  @override
  State<ContactsScreen> createState() => _ContactsScreenState();
}

class _ContactsScreenState extends State<ContactsScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: MyAppBar(
          afterLogOut: () =>
              Navigator.pushReplacementNamed(context, WelcomeScreen.id),
          title: "Contacts",
          pushContacsScreen: () => {}),
      body: Center(
        child: ContacsStream(),
      ),
    );
  }
}

class ContacsStream extends StatefulWidget {
  const ContacsStream({Key? key}) : super(key: key);

  @override
  State<ContacsStream> createState() => ContacsStreamState();
}

class ContacsStreamState extends State<ContacsStream> {
  var userStream = _firestore.collection('users').snapshots();

  @override
  Widget build(BuildContext context) {
    return StreamBuilder<QuerySnapshot>(
      stream: userStream,
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

        var contacts = snapshot.data!.docs;

        return ListView.builder(
          itemCount: contacts.length,
          itemBuilder: (BuildContext context, int index) {
            // Add divider between contacts.
            if (index != 0) {
              return Container(
                child: Column(
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    children: [
                      Divider(
                        thickness: 1,
                      ),
                      ContactCard(
                        contact: contacts[index],
                      ),
                    ]),
              );
            } else {
              return ContactCard(contact: contacts[index]);
            }
          },
        );
      },
    );
  }
}

class ContactCard extends StatelessWidget {
  const ContactCard({
    Key? key,
    required this.contact,
  }) : super(key: key);

  final QueryDocumentSnapshot<Object?> contact;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: GestureDetector(
        onTap: () {
          print("Contact card of user ${contact["email"]} clicked");
        },
        child: Card(
          color: Colors.lightGreen,
          elevation: 10,
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 10),
            child: Text(
              contact['email'],
            ),
          ),
        ),
      ),
    );
  }
}
