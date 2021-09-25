import 'dart:io';
import 'dart:ui';

import 'package:face_detection_app/constants.dart';
import 'package:face_detection_app/utils/image_path_picker.dart';
import 'package:flutter/material.dart';

class FaceDetectionScreen extends StatefulWidget {
  @override
  _FaceDetectionScreenState createState() => _FaceDetectionScreenState();
}

class _FaceDetectionScreenState extends State<FaceDetectionScreen> {
  String? _imagePath;

  void getImage() async {
    String imagePath = await ImagePathPicker().getImage();

    setState(() {
      _imagePath = imagePath;
    });

    print(imagePath);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Stack(
          alignment: Alignment.center,
          children: [
            Container(
              decoration: BoxDecoration(
                image: _imagePath == null
                    ? faceDetectScreenDecoImage
                    : DecorationImage(
                        image: FileImage(File(_imagePath!)), fit: BoxFit.cover),
              ),
              child: BackdropFilter(
                filter: ImageFilter.blur(
                  sigmaX: 15,
                  sigmaY: 15,
                ),
                child: Container(
                  color: transBlackColor,
                ),
              ),
            ),
            Column(
              children: [
                Expanded(
                  child: FractionallySizedBox(
                    widthFactor: 0.9,
                    heightFactor: 0.7,
                    child: Container(
                      decoration: BoxDecoration(
                        boxShadow: [
                          faceDetectScreenBoxShadowChild,
                        ],
                        borderRadius: BorderRadius.circular(32.0),
                        image: _imagePath == null
                            ? faceDetectScreenDecoImage
                            : DecorationImage(
                                image: FileImage(File(_imagePath!)),
                                fit: BoxFit.cover),
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
