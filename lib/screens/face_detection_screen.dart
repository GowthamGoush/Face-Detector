import 'dart:io';
import 'dart:ui' as ui;

import 'package:shimmer/shimmer.dart';
import 'package:face_detection_app/constants.dart';
import 'package:face_detection_app/painters/face_painter.dart';
import 'package:face_detection_app/utils/image_path_picker.dart';
import 'package:flutter/material.dart';
import 'package:google_ml_kit/google_ml_kit.dart';

class FaceDetectionScreen extends StatefulWidget {
  @override
  _FaceDetectionScreenState createState() => _FaceDetectionScreenState();
}

class _FaceDetectionScreenState extends State<FaceDetectionScreen> {
  String? _imagePath;
  late final faceDetector;
  bool isLoading = false;
  bool isUpload = true;

  var canvasImage;
  List<Rect> facesList = [];
  bool canvasReady = false;

  void getFaces() async {
    setState(() {
      isLoading = !isLoading;
    });

    final List<Face> faces =
        await faceDetector.processImage(InputImage.fromFilePath(_imagePath!));

    facesList.clear();

    for (Face face in faces) {
      facesList.add(face.boundingBox);
    }

    print('Total Faces : ${faces.length}');

    canvasImage = await loadImage(File(_imagePath!));

    setState(() {
      canvasReady = !canvasReady;
      isLoading = !isLoading;
      isUpload = !isUpload;
    });
  }

  Future<ui.Image> loadImage(File file) async {
    final data = await file.readAsBytes();
    return await decodeImageFromList(data);
  }

  void getImage() async {
    setState(() {
      isLoading = !isLoading;
    });

    String imagePath = await ImagePathPicker().getImage();

    setState(() {
      canvasReady = !canvasReady;
      _imagePath = imagePath;
      isLoading = !isLoading;
      isUpload = !isUpload;
    });
  }

  @override
  void initState() {
    super.initState();
    faceDetector = GoogleMlKit.vision.faceDetector();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.transparent,
      body: SafeArea(
        child: Stack(
          alignment: Alignment.center,
          children: [
            Container(
              decoration: BoxDecoration(
                gradient: containerGradient,
                image: _imagePath == null
                    ? faceDetectScreenDecoImage
                    : DecorationImage(
                        image: FileImage(File(_imagePath!)), fit: BoxFit.cover),
              ),
              child: BackdropFilter(
                filter: ui.ImageFilter.blur(
                  sigmaX: 15,
                  sigmaY: 15,
                ),
                child: Container(
                  color: transBlackColor,
                ),
              ),
            ),
            Column(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                isLoading
                    ? Expanded(
                        child: Shimmer.fromColors(
                            enabled: true,
                            period: Duration(milliseconds: 800),
                            child: FractionallySizedBox(
                              widthFactor: 0.9,
                              heightFactor: 0.7,
                              child: Container(
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(16.0),
                                  image: _imagePath == null
                                      ? faceDetectScreenDecoImage
                                      : DecorationImage(
                                          image: FileImage(File(_imagePath!)),
                                          fit: BoxFit.fill),
                                ),
                              ),
                            ),
                            baseColor: Colors.grey.shade500,
                            highlightColor: Colors.grey.shade100),
                      )
                    : Expanded(
                        child: FractionallySizedBox(
                          widthFactor: 0.9,
                          heightFactor: 0.7,
                          child: canvasReady
                              ? FittedBox(
                                  child: SizedBox(
                                      width: canvasImage.width.toDouble(),
                                      height: canvasImage.height.toDouble(),
                                      child: CustomPaint(
                                        foregroundPainter:
                                            FacePainter(faces: facesList),
                                        child: Container(
                                          decoration: BoxDecoration(
                                            boxShadow: [
                                              faceDetectScreenBoxShadowChild,
                                            ],
                                            borderRadius:
                                                BorderRadius.circular(128.0),
                                            image: DecorationImage(
                                                image: FileImage(
                                                    File(_imagePath!)),
                                                fit: BoxFit.cover),
                                          ),
                                        ),
                                      )),
                                )
                              : Container(
                                  decoration: BoxDecoration(
                                    boxShadow: [
                                      faceDetectScreenBoxShadowChild,
                                    ],
                                    borderRadius: BorderRadius.circular(16.0),
                                    image: _imagePath == null
                                        ? faceDetectScreenDecoImage
                                        : DecorationImage(
                                            image: FileImage(File(_imagePath!)),
                                            fit: BoxFit.fill),
                                  ),
                                ),
                        ),
                      ),
                ElevatedButton(
                    onPressed: () {
                      isUpload ? getImage() : getFaces();
                    },
                    style: ElevatedButton.styleFrom(
                      fixedSize: Size(108, 36),
                      padding:
                          EdgeInsets.symmetric(horizontal: 12, vertical: 8),
                      shape: const RoundedRectangleBorder(
                        borderRadius: BorderRadius.all(Radius.circular(2)),
                      ),
                    ),
                    child: isLoading
                        ? SizedBox(
                            height: 20,
                            width: 20,
                            child: CircularProgressIndicator(
                              color: Colors.white,
                              strokeWidth: 2.0,
                            ),
                          )
                        : isUpload
                            ? uploadText
                            : submitText),
              ],
            ),
          ],
        ),
      ),
    );
  }

  @override
  void dispose() {
    super.dispose();
    faceDetector.close();
  }
}
