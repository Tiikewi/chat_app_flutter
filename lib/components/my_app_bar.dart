import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_chat/constants.dart';

class MyAppBar extends StatelessWidget with PreferredSizeWidget {
  MyAppBar({Key? key, required this.afterLogOut, required this.title})
      : super(key: key);

  final FirebaseAuth _auth = FirebaseAuth.instance;
  final Function afterLogOut;
  final String title;

  @override
  Widget build(BuildContext context) {
    return AppBar(
      leading: PopupMenuButton(
          icon: CircleAvatar(
            child: Text("pic"),
          ),
          itemBuilder: (context) {
            return [
              PopupMenuItem(
                child: Text("Logout"),
                onTap: () async {
                  await _auth.signOut();
                  afterLogOut();
                },
              ),
            ];
          }),
      title: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          const Image(
            image: AssetImage("images/duck.png"),
            height: 30,
          ),
          const SizedBox(
            width: 2,
          ),
          Text(title),
        ],
      ),
    );
  }

  @override
  Size get preferredSize => const Size.fromHeight(kMyAppBarHeight);
}
