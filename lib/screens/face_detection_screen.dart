import 'dart:io';
import 'dart:ui';

import 'package:face_detection_app/utils/image_path_picker.dart';
import 'package:flutter/material.dart';

class FaceDetectionScreen extends StatefulWidget {
  @override
  _FaceDetectionScreenState createState() => _FaceDetectionScreenState();
}

class _FaceDetectionScreenState extends State<FaceDetectionScreen> {
  String? _imagePath;
  String _imageUrl =
      "https://cdn.dribbble.com/users/3281732/screenshots/6727912/samji_illustrator.jpeg?compress=1&resize=600x600";

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
                    ? DecorationImage(
                        image: NetworkImage(_imageUrl), fit: BoxFit.cover)
                    : DecorationImage(
                        image: FileImage(File(_imagePath!)), fit: BoxFit.cover),
              ),
              child: BackdropFilter(
                filter: ImageFilter.blur(
                  sigmaX: 15,
                  sigmaY: 15,
                ),
                child: Container(
                  color: Colors.black.withOpacity(0.3),
                ),
              ),
            ),
            Column(
              children: [
                Expanded(
                  child: FractionallySizedBox(
                    widthFactor: 0.9,
                    heightFactor: 0.6,
                    child: Container(
                      decoration: BoxDecoration(
                        boxShadow: [
                          BoxShadow(
                            color: Colors.black.withOpacity(0.3),
                            spreadRadius: 5,
                            blurRadius: 10,
                            offset: Offset(0, 5),
                          ),
                        ],
                        borderRadius: BorderRadius.circular(32.0),
                        image: _imagePath == null
                            ? DecorationImage(
                                image: NetworkImage(_imageUrl),
                                fit: BoxFit.cover)
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
