import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';

const kSendButtonTextStyle = TextStyle(
  color: Colors.green,
  fontWeight: FontWeight.bold,
  fontSize: 18.0,
);

const kMessageTextFieldDecoration = InputDecoration(
  contentPadding: EdgeInsets.symmetric(vertical: 10.0, horizontal: 20.0),
  hintText: 'Type here...',
  border: InputBorder.none,
);

const kMessageContainerDecoration = BoxDecoration(
  border: Border(
    top: BorderSide(width: 2.0, color: Colors.green),
  ),
);

const kTextFieldDecoration = InputDecoration(
  hintText: 'SET HINT TEXT',
  hintStyle: TextStyle(color: Colors.grey),
  contentPadding: EdgeInsets.symmetric(vertical: 10.0, horizontal: 20.0),
  border: OutlineInputBorder(
    borderRadius: BorderRadius.all(Radius.circular(4.0)),
  ),
  enabledBorder: OutlineInputBorder(
    borderSide: BorderSide(color: Colors.lightBlueAccent, width: 1.0),
    borderRadius: BorderRadius.all(Radius.circular(4.0)),
  ),
  focusedBorder: OutlineInputBorder(
    borderSide: BorderSide(color: Colors.lightBlueAccent, width: 2.0),
    borderRadius: BorderRadius.all(Radius.circular(4.0)),
  ),
);

const double radius = 8;
const kMessageBubbleRadiusUser = BorderRadius.only(
    topRight: Radius.circular(radius),
    topLeft: Radius.circular(radius),
    bottomLeft: Radius.circular(radius));

const kMessageBubbleRadiusOther = BorderRadius.only(
    topRight: Radius.circular(radius),
    topLeft: Radius.circular(radius),
    bottomRight: Radius.circular(radius));

const kWelcomeScreenButtonTextStyle = TextStyle(
  fontSize: 15,
);

const kBubbleColorUser = Colors.green;
const kBubbleColorOther = Colors.red;

const kSpinner = SpinKitWave(
  color: Colors.green,
  size: 50,
);

const kMyAppBarHeight = 50.0;
