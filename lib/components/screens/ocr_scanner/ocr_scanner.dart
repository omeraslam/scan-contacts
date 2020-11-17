import 'dart:io';
import 'package:flutter/material.dart';
import 'package:csv/csv.dart';
import 'package:image_picker/image_picker.dart';
import 'package:firebase_ml_vision/firebase_ml_vision.dart';
import '../../utilities/constants.dart';
import '../contact_details/contact_details.dart';

class OcrScanner extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return _OcrScanner();
  }
}

class _OcrScanner extends State<OcrScanner> {
  File pickedImage;
  List<List<String>> textList = [];
  List<String> lineList = [];

  bool isImageLoaded = false;
  String text = "";

  @override
  void initState() {
    super.initState();
    // this.pickImage();
  }

  Future pickImage() async {
    // ignore: deprecated_member_use
    var tempStore = await ImagePicker.pickImage(source: ImageSource.camera);
    setState(() {
      pickedImage = tempStore;
      isImageLoaded = true;
    });
    if (isImageLoaded) {
      this.readText();
    }
  }

  Future readText() async {
    textList = [];
    FirebaseVisionImage ourImage = FirebaseVisionImage.fromFile(pickedImage);
    print('2');
    TextRecognizer recognizeText = FirebaseVision.instance.textRecognizer();
    VisionText readText = await recognizeText.processImage(ourImage);
    for (TextBlock block in readText.blocks) {
      for (TextLine line in block.lines) {
        for (TextElement word in line.elements) {
          lineList.add(word.text);
        }
        textList.add(lineList);
        lineList = [];
      }
    }

    String csv = const ListToCsvConverter().convert(textList);
    print(csv);
    setState(() {
      text = text + csv;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          iconTheme: IconThemeData(
            color: Colors.blue,
          ),
          title: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(contacts,
                  style: const TextStyle(
                      color: const Color(0xff057af7),
                      fontWeight: FontWeight.w500,
                      fontFamily: "Lato",
                      fontStyle: FontStyle.normal,
                      fontSize: 15.0),
                  textAlign: TextAlign.left),
              Text(edit,
                  style: const TextStyle(
                      color: const Color(0xff057af7),
                      fontWeight: FontWeight.w500,
                      fontFamily: "Lato",
                      fontStyle: FontStyle.normal,
                      fontSize: 15.0),
                  textAlign: TextAlign.left)
            ],
          ),
          centerTitle: false,
        ),
        body: ContactDetails());
  }
}
