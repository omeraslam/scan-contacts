import 'dart:io';
import 'package:flutter/material.dart';
import 'package:hive/hive.dart';
import 'package:image_picker/image_picker.dart';
import 'package:firebase_ml_vision/firebase_ml_vision.dart';
import 'package:scan_contacts/components/models/contact_images.dart';
import 'package:scan_contacts/components/models/contact_model.dart';
import 'package:scan_contacts/components/screens/contact_listing/contact_listing.dart';
import '../../utilities/helper_methods.dart';
import '../../utilities/string_extensions.dart';
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
  List<String> blockList = [];

  bool isImageLoaded = false;
  String text = "";
  String frontImage;
  String backImage;
  String userName;
  String companyName;
  String email;
  String address;
  String companyNumber;
  String mobileNumber;

  @override
  void initState() {
    super.initState();
    this.pickImage();
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
    blockList = [];
    FirebaseVisionImage ourImage = FirebaseVisionImage.fromFile(pickedImage);
    TextRecognizer recognizeText = FirebaseVision.instance.textRecognizer();
    VisionText readText = await recognizeText.processImage(ourImage);
    for (TextBlock block in readText.blocks) {
      blockList.add(block.text.toString());
      for (TextLine line in block.lines) {
        for (TextElement word in line.elements) {
          lineList.add(word.text);
        }
        textList.add(lineList);
        lineList = [];
      }
    }
    validateLineFields();
    validateWordFields();
  }

  validateLineFields() {
    blockList.forEach((element) {
      if (element.contains(addressRegex)) {
        var addressValidation =
            addressRegex.allMatches(element).map((e) => e.group(0)).toString();
        print('ADDRESS' + addressValidation);
        setState(() {
          address = element;
        });
      }
      if (element.contains(phoneNumberRegex) ||
          element.contains(internationalPhoneRegex)) {
        if (element.contains(phoneNumberRegex)) {
          var phone = phoneNumberRegex
              .allMatches(element)
              .map((e) => e.group(0))
              .join(' ');
          print('PHONE' + phone);
          setState(() {
            mobileNumber = phone;
          });
        } else if (element.contains(internationalPhoneRegex)) {
          var internationalPhone = internationalPhoneRegex
              .allMatches(element)
              .map((e) => e.group(0))
              .join(' ');
          print('PHONE' + internationalPhone);
          setState(() {
            mobileNumber = internationalPhone;
          });
        }
      }
    });
  }

  validateWordFields() {
    textList.forEach((element) {
      element.forEach((text) {
        if (text.contains(emailRegex)) {
          var emailValidation =
              emailRegex.allMatches(text).map((e) => e.group(0)).join(' ');
          List splitText = emailValidation.split('@');
          if(splitText.toString().toLowerCase().contains('info')) {
            print('not found');
          } else {
            setState(() {
              userName = splitText[0];
            });
          }
          setState(() {
            email = emailValidation;
          });
         var secondsplitText = splitText[1].toString();
         if(secondsplitText.toLowerCase().contains('gmail') || secondsplitText.toLowerCase().contains('yahoo') ) {
           print('No work detected');
         } else {
           List work = secondsplitText.split('.');
           var workPlace = work[0];
           setState(() {
             companyName = workPlace;
           });
         }
        }
      });
    });
    createContact();
  }

  createContact() {
    final imageContact = ContactImagesModel(
      frontImage: pickedImage.path,
    );
    final userContact = ContactModel(
      frontImage: pickedImage.path,
      userName: userName.toString(),
      companyName: companyName.toString(),
      email: email.toString(),
      address: address.toString(),
      mobileNumber: mobileNumber.toString(),

    );
    final cardContact = Hive.box('cardContact');
    final cardImageContact = Hive.box('cardImages');
    cardContact.add(userContact);
    cardImageContact.add(imageContact);
    print(cardContact.values);
    Navigator.of(context)
        .push(MaterialPageRoute(builder: (BuildContext context) {
      return new ContactListing();
    }));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold();
  }
}
