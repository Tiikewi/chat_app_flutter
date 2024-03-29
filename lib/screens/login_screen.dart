import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_chat/constants.dart';
import 'package:flutter_chat/screens/chat_list_screen.dart';
import 'package:flutter_chat/screens/chat_screen.dart';
import 'package:modal_progress_hud_nsn/modal_progress_hud_nsn.dart';

import '../components/alert_dialog.dart';

class LoginScreen extends StatefulWidget {
  static String id = 'login_screen';

  const LoginScreen({Key? key}) : super(key: key);

  @override
  LoginScreenState createState() => LoginScreenState();
}

class LoginScreenState extends State<LoginScreen> {
  String _email = "";
  String _password = "";
  bool _showSpinner = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Center(
        child: ModalProgressHUD(
          inAsyncCall: _showSpinner,
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 24.0),
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
                  keyboardType: TextInputType.emailAddress,
                  textAlign: TextAlign.center,
                  onChanged: (value) {
                    _email = value;
                  },
                  decoration:
                      kTextFieldDecoration.copyWith(hintText: "Username"),
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
                  decoration:
                      kTextFieldDecoration.copyWith(hintText: "Password"),
                ),
                const SizedBox(
                  height: 24.0,
                ),
                ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    elevation: 10,
                    padding: const EdgeInsets.symmetric(
                        vertical: 15, horizontal: 10),
                  ),
                  onPressed: () async {
                    await logUserIn();
                  },
                  child: const Text(
                    "Login",
                    style: kWelcomeScreenButtonTextStyle,
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Future<void> logUserIn() async {
    setState(() {
      _showSpinner = true;
    });
    try {
      await FirebaseAuth.instance
          .signInWithEmailAndPassword(email: _email, password: _password);

      setState(() {
        _showSpinner = false;
      });
      if (!mounted) return;
      Navigator.popUntil(context, (route) => route.isFirst);
      Navigator.pushReplacementNamed(context, ChatListScreen.id);
    } on FirebaseAuthException catch (e) {
      if (e.code == 'user-not-found') {
        setState(() {
          popDialog(
              context: context,
              title: "Invalid email!",
              content: "No user found with given email.");
          _showSpinner = false;
        });
      } else if (e.code == 'wrong-password') {
        popDialog(
            context: context,
            title: "Invalid password!",
            content: "Password was incorrect.");
        _showSpinner = false;
      }
    } catch (e) {
      print(e);
    }
  }
}
