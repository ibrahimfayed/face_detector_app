import 'dart:io';
import 'package:face_detector_app/add_an_image.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:google_mlkit_face_detection/google_mlkit_face_detection.dart';
import 'package:image_picker/image_picker.dart';

class FaceDetection extends StatefulWidget {
  const FaceDetection({super.key});

  @override
  State<FaceDetection> createState() => _FaceDetectionState();
}

class _FaceDetectionState extends State<FaceDetection> {
  File? _image;//it holds an image picked
  List<Face> faces = [];//in start it is null then when we find faces it is given the value below

  Future _pickImage(ImageSource source)async{
    try {
      final image = await ImagePicker().pickImage(source: source);
      if (image == null) {
        //return null;
        return;}
      setState(() {
        _image = File(image.path);
      });
    } catch (e) {
      if (kDebugMode) {
        print(e);
      }
    }
  }
  Future _detectFaces(File img)async{
    final options = FaceDetectorOptions();
    final faceDetector = FaceDetector(options:options,);
    final inputImage = InputImage.fromFilePath(img.path);
    faces = await faceDetector.processImage(inputImage);
    setState(() {
      print(faces.length);
    });

  }
  @override
  Widget build(BuildContext context) {
    return  Scaffold(
      appBar: AppBar(
        title:const Text("Face Detection"),
      ),
      body:Center(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20),
          child: Column(
            children: [
              Container(
                width: double.infinity,
                height: 250,
                color: Colors.grey,
                child: Center(
                  child: _image == null ? 
                 const Icon(Icons.add_a_photo,
                  size: 60,):
                  Image.file(_image!)
                ),
              ),
              const SizedBox(height: 10,),
               AddAnImage(
                text: 'add an image from camera',
                onPressed: () {
                  _pickImage(ImageSource.camera).then((onValue){//i use then here to avoid problem happens when user go to pick an image and retreats(يتراجع)
                    if (_image!=null) {
                      _detectFaces(_image!);
                    }
                  });
                },),
              const SizedBox(height: 10,),
               AddAnImage(
                text: 'add an image from gallery',
                onPressed: () {
                  _pickImage(ImageSource.gallery).then((onValue){//i use then here to avoid problem happens when user go to pick an image and retreats(يتراجع)
                    if (_image!=null) {
                      _detectFaces(_image!);
                    }
                  });
                },),
                const SizedBox(height: 20,),
                Text('number of persons:${faces.length}',
                style:const TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.bold
                ),)

            ],
          ),
        ),
      ),
    );
  }
}

