import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_chat/constants.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_chat/screens/chat_screen.dart';
import 'package:modal_progress_hud_nsn/modal_progress_hud_nsn.dart';

import '../components/alert_dialog.dart';
import 'chat_list_screen.dart';

class RegistrationScreen extends StatefulWidget {
  static String id = 'registration_screen';

  const RegistrationScreen({Key? key}) : super(key: key);

  @override
  RegistrationScreenState createState() => RegistrationScreenState();
}

class RegistrationScreenState extends State<RegistrationScreen> {
  final _auth = FirebaseAuth.instance;
  String _email = "";
  String _password = "";
  bool _showSpinner = false;
  FirebaseFirestore db = FirebaseFirestore.instance;

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: ModalProgressHUD(
        inAsyncCall: _showSpinner,
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: 24.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: <Widget>[
              Flexible(
                child: Hero(
                  tag: 'logo',
                  child: SizedBox(
                    height: 200.0,
                    child: Image.asset('images/duck.png'),
                  ),
                ),
              ),
              const SizedBox(
                height: 48.0,
              ),
              TextField(
                textAlign: TextAlign.center,
                keyboardType: TextInputType.emailAddress,
                onChanged: (value) {
                  _email = value;
                },
                decoration: kTextFieldDecoration.copyWith(hintText: "Username"),
              ),
              const SizedBox(
                height: 8.0,
              ),
              TextField(
                textAlign: TextAlign.center,
                obscureText: true,
                onChanged: (value) {
                  _password = value;
                },
                decoration: kTextFieldDecoration.copyWith(hintText: "Password"),
              ),
              const SizedBox(
                height: 24.0,
              ),
              ElevatedButton(
                style: ElevatedButton.styleFrom(
                  elevation: 10,
                  padding:
                      const EdgeInsets.symmetric(vertical: 15, horizontal: 10),
                ),
                onPressed: () async {
                  setState(() {
                    _showSpinner = true;
                  });
                  try {
                    final newUser = await _auth.createUserWithEmailAndPassword(
                        email: _email, password: _password);

                    // Add user to database
                    if (newUser.user != null) {
                      final user = <String, dynamic>{
                        "email": newUser.user!.email!,
                        "username": "set username",
                        "groups": [],
                      };

                      await db
                          .collection("users")
                          .doc(newUser.user!.uid)
                          .set(user)
                          .then((value) =>
                              print("$user added to users collection"));
                    } else {
                      popDialog(
                          context: context,
                          title: "Error!",
                          content:
                              "Error happened when trying to create user.");
                    }
                    setState(() {
                      _showSpinner = false;
                    });
                    if (!mounted) return;
                    Navigator.popUntil(context, (route) => route.isFirst);
                    Navigator.pushReplacementNamed(context, ChatListScreen.id);
                  } on FirebaseAuthException catch (e) {
                    if (e.code == 'weak-password') {
                      popDialog(
                          context: context,
                          title: "Invalid password!",
                          content:
                              "Password must be atleast six characters long.");
                    } else if (e.code == 'email-already-in-use') {
                      popDialog(
                          context: context,
                          title: "Invalid email!",
                          content: "Given email is already in use.");
                    } else if (e.code == 'permission-denied') {
                      popDialog(context: context, title: "Permission denied");
                    }
                  } catch (e) {
                    print(e);
                  }
                  _showSpinner = false;
                },
                child: const Text(
                  "Register",
                  style: kWelcomeScreenButtonTextStyle,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
