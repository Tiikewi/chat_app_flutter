import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_chat/screens/chat_list_screen.dart';
import 'package:flutter_chat/screens/contacts_screen.dart';
import 'package:flutter_chat/screens/welcome_screen.dart';
import 'package:flutter_chat/screens/login_screen.dart';
import 'package:flutter_chat/screens/registration_screen.dart';
import 'package:flutter_chat/screens/chat_screen.dart';
import 'package:firebase_core/firebase_core.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      initialRoute: FirebaseAuth.instance.currentUser != null
          ? ChatListScreen.id
          : WelcomeScreen.id,
      theme: ThemeData(primarySwatch: Colors.green),
      routes: {
        WelcomeScreen.id: (context) => const WelcomeScreen(),
        LoginScreen.id: (context) => const LoginScreen(),
        ChatScreen.id: (context) => ChatScreen(),
        RegistrationScreen.id: (context) => const RegistrationScreen(),
        ChatListScreen.id: (context) => ChatListScreen(),
        ContactsScreen.id: (context) => ContactsScreen(),
      },
    );
  }
}
