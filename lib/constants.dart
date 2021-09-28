import 'package:flutter/material.dart';
import 'dart:ui';

const String _imageUrl =
    "https://cdn.dribbble.com/users/3281732/screenshots/6727912/samji_illustrator.jpeg?compress=1&resize=600x600";

const transBlackColor = Colors.black26;

const circularRadius = Radius.circular(32.0);

const faceDetectScreenDecoImage =
    DecorationImage(image: NetworkImage(_imageUrl), fit: BoxFit.cover);

const uploadText = Text(
  "Upload",
  style: TextStyle(fontFamily: 'Spartan', fontSize: 18),
);

const submitText = Text(
  "Submit",
  style: TextStyle(fontFamily: 'Spartan', fontSize: 18),
);

const faceDetectScreenBoxShadowChild = BoxShadow(
  color: transBlackColor,
  spreadRadius: 5,
  blurRadius: 10,
  offset: Offset(0, 5),
);

const containerGradient = LinearGradient(
    begin: Alignment.topRight,
    end: Alignment.bottomLeft,
    colors: [
      Color(0xff654ea3),
      Color(0xffeaafc8),
    ],
    tileMode: TileMode.clamp);
