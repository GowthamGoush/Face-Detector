import 'package:flutter/material.dart';
import 'dart:ui';

const String _imageUrl =
    "https://cdn.dribbble.com/users/3281732/screenshots/6727912/samji_illustrator.jpeg?compress=1&resize=600x600";

const transBlackColor = Colors.black26;

const circularRadius = Radius.circular(32.0);

const faceDetectScreenDecoImage =
    DecorationImage(image: NetworkImage(_imageUrl), fit: BoxFit.cover);

const faceDetectScreenBoxShadowChild = BoxShadow(
  color: transBlackColor,
  spreadRadius: 5,
  blurRadius: 10,
  offset: Offset(0, 5),
);
