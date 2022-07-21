import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_chat/auth_service.dart';
import 'package:flutter_chat/constants.dart';
import 'package:flutter_chat/screens/chat_screen.dart';
import 'package:flutter_chat/screens/login_screen.dart';
import 'package:flutter_chat/screens/registration_screen.dart';
import 'package:animated_text_kit/animated_text_kit.dart';

class WelcomeScreen extends StatefulWidget {
  static String id = 'welcome_screen';

  const WelcomeScreen({Key? key}) : super(key: key);
  @override
  WelcomeScreenState createState() => WelcomeScreenState();
}

class WelcomeScreenState extends State<WelcomeScreen>
    with TickerProviderStateMixin {
  late AnimationController _controller;
  late AnimationController _colorController;
  late Animation _animation;
  late Animation _colorAnimation;

  @override
  void initState() {
    _controller =
        AnimationController(vsync: this, duration: const Duration(seconds: 1));
    _controller.forward();

    _colorController = AnimationController(
        vsync: this, duration: const Duration(seconds: 1, milliseconds: 500));
    _colorController.forward();

    _animation =
        CurvedAnimation(parent: _controller, curve: Curves.easeInCubic);

    _colorAnimation = ColorTween(begin: Colors.grey.shade600, end: Colors.white)
        .animate(_colorController);

    _controller.addListener(() {
      setState(() {});
    });
    _colorController.addListener(() {
      setState(() {});
    });
    super.initState();
  }

  @override
  void dispose() {
    _controller.dispose();
    _colorController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: _colorAnimation.value,
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 24.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.end,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: <Widget>[
            const SizedBox(
              height: 200,
            ),
            Expanded(
              child: Align(
                alignment: Alignment.topCenter,
                child: Row(
                  children: <Widget>[
                    Flexible(
                      child: Hero(
                        tag: 'logo',
                        child: SizedBox(
                          height: _animation.value * 100,
                          child: Image.asset('images/duck.png'),
                        ),
                      ),
                    ),
                    AnimatedTextKit(
                      totalRepeatCount: 1,
                      animatedTexts: [
                        TypewriterAnimatedText(
                          "Chat App",
                          speed: const Duration(milliseconds: 100),
                          textStyle: TextStyle(
                              fontSize: 35.0,
                              fontWeight: FontWeight.w900,
                              color: Colors.grey.shade800),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ),
            ElevatedButton(
              style: ElevatedButton.styleFrom(
                elevation: 10,
                padding:
                    const EdgeInsets.symmetric(vertical: 15, horizontal: 10),
              ),
              onPressed: () => Navigator.pushNamed(context, LoginScreen.id),
              child: const Text(
                "Login",
                style: kWelcomeScreenButtonTextStyle,
              ),
            ),
            const SizedBox(height: 15),
            ElevatedButton(
              style: ElevatedButton.styleFrom(
                elevation: 10,
                padding:
                    const EdgeInsets.symmetric(vertical: 15, horizontal: 10),
              ),
              onPressed: () =>
                  Navigator.pushNamed(context, RegistrationScreen.id),
              child: const Text(
                "Register",
                style: kWelcomeScreenButtonTextStyle,
              ),
            ),
            const SizedBox(height: 50.0),
          ],
        ),
      ),
    );
  }
}
