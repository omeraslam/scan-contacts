import 'dart:io';

import 'package:flutter/material.dart';
import '../contact_listing/contact_listing.dart';
import 'package:image_picker/image_picker.dart';
import '../../models/user_model.dart';
import 'package:hive/hive.dart';
import '../../utilities/constants.dart';

class OnBoarding extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return _OnBoarding();
  }
}

class _OnBoarding extends State<OnBoarding> {
  File _image;
  final nameController = TextEditingController();
  final contactController = TextEditingController();

  @override
  void initState() {
    super.initState();
  }

  _imgFromCamera() async {
    await Future.delayed(Duration(milliseconds: 500));
    // ignore: deprecated_member_use
    File image = await ImagePicker.pickImage(
        source: ImageSource.camera, imageQuality: 50);

    setState(() {
      _image = image;
    });
  }

  _imgFromGallery() async {
    await Future.delayed(Duration(milliseconds: 500));
    // ignore: deprecated_member_use
    File image = await ImagePicker.pickImage(
        source: ImageSource.gallery, imageQuality: 50);

    setState(() {
      _image = image;
    });
  }

  void _storeOnboardingInfo() {
    final userModel = UserModel(
        photoUrl: _image,
        userName: nameController.text.toString(),
        contactNumber: contactController.text.toString());
    final userBox = Hive.box('user');
    userBox.add(userModel);
    Navigator.of(context)
        .push(MaterialPageRoute(builder: (BuildContext context) {
      return new ContactListing();
    }));
  }

  void _showPicker(context) {
    showModalBottomSheet(
        context: context,
        builder: (BuildContext bc) {
          return SafeArea(
            child: Container(
              child: new Wrap(
                children: <Widget>[
                  new ListTile(
                      leading: new Icon(Icons.photo_library),
                      title: new Text(photoLibrary),
                      onTap: () {
                        _imgFromGallery();
                        Navigator.of(context).pop();
                      }),
                  new ListTile(
                    leading: new Icon(Icons.photo_camera),
                    title: new Text(camera),
                    onTap: () {
                      _imgFromCamera();
                      Navigator.of(context).pop();
                    },
                  ),
                ],
              ),
            ),
          );
        });
  }

  Widget _imageClicker() {
    return Center(
      child: GestureDetector(
        onTap: () {
          _showPicker(context);
        },
        child: CircleAvatar(
          radius: 55,
          backgroundColor: Color(0xffFDCF09),
          child: _image != null
              ? ClipRRect(
                  borderRadius: BorderRadius.circular(50),
                  child: Image.file(
                    _image,
                    width: 100,
                    height: 100,
                    fit: BoxFit.fitHeight,
                  ),
                )
              : Container(
                  decoration: BoxDecoration(
                      color: Colors.grey[200],
                      borderRadius: BorderRadius.circular(50)),
                  width: 100,
                  height: 100,
                  child: Icon(
                    Icons.camera_alt,
                    color: Colors.grey[800],
                  ),
                ),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(),
        body: SingleChildScrollView(
          child: Column(
            children: [
              SizedBox(
                height: 30,
              ),
              _imageClicker(),
              Padding(
                padding: EdgeInsets.all(10.0),
              ),
              Text(
                name,
                textAlign: TextAlign.left,
              ),
              Padding(
                padding: EdgeInsets.all(20.0),
                child: TextField(
                  controller: nameController,
                  decoration: InputDecoration(
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(5.0),
                        borderSide: BorderSide(
                          color: Colors.amber,
                          style: BorderStyle.solid,
                        ),
                      ),
                      hintText: namePlaceholder,
                      contentPadding: const EdgeInsets.all(10.0)),
                ),
              ),
              Text(phoneNumber),
              Padding(
                padding: EdgeInsets.all(20.0),
                child: TextField(
                  controller: contactController,
                  autofocus: true,
                  decoration: InputDecoration(
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(5.0),
                        borderSide: BorderSide(
                          color: Colors.amber,
                          style: BorderStyle.solid,
                        ),
                      ),
                      hintText: phoneNumberPlaceholder,
                      contentPadding: const EdgeInsets.all(10.0)),
                ),
              ),
              Padding(
                padding: EdgeInsets.all(10.0),
              ),
              RaisedButton(
                child: Text(next),
                onPressed: () {
                  this._storeOnboardingInfo();
                },
                color: Colors.blueGrey,
                textColor: Colors.blue,
                padding: EdgeInsets.fromLTRB(10, 10, 10, 10),
                splashColor: Colors.grey,
              ),
            ],
          ),
        ));
  }
}
