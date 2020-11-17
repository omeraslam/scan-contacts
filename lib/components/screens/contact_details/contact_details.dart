import 'dart:io';
import 'package:flutter/material.dart';
import 'package:scan_contacts/components/screens/google_maps/google_maps.dart';
import 'package:scan_contacts/components/utilities/colors.dart';
import '../../utilities/constants.dart';
import 'package:url_launcher/url_launcher.dart';

class ContactDetails extends StatelessWidget {
  _launchCaller() async {
    const url = "tel:1234567";
    if (await canLaunch(url)) {
      await launch(url);
    } else {
      throw 'Could not launch $url';
    }
  }

  _launcherMessage() async {
    if (Platform.isAndroid) {
      const uri = 'sms:+39 348 060 888?body=hello%20there';
      if (await canLaunch(uri)) {
        await launch(uri);
      }
    } else if (Platform.isIOS) {
      const uri = 'sms:0039-222-060-888?body=hello%20there';
      if (await canLaunch(uri)) {
        await launch(uri);
      } else {
        throw 'Could not launch $uri';
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
        child: Column(
      children: <Widget>[
        // isImageLoaded
        //     ?
        Container(
            decoration: BoxDecoration(color: const Color(0xfff9f9f9)),
            child: Column(
              children: [
                SizedBox(height: 10.0),
                Container(
                  child: Image.asset('assets/icons/no_card.png'),
                  // margin: EdgeInsets.symmetric(horizontal: 10.0),
                  // height: 200.0,
                  // width: MediaQuery.of(context).size.width,
                  // decoration: BoxDecoration(
                  //     image: DecorationImage(
                  //         image: FileImage(pickedImage),
                  //         fit: BoxFit.cover))
                ),
                SizedBox(height: 10.0),
                Text("Bryan Wolfe",
                    style: const TextStyle(
                        color: const Color(0xff010707),
                        fontWeight: FontWeight.w500,
                        fontFamily: "Lato",
                        fontStyle: FontStyle.normal,
                        fontSize: 23.0),
                    textAlign: TextAlign.left),
                Text("Design Studio",
                    style: const TextStyle(
                        color: const Color(0xff7a7a7c),
                        fontWeight: FontWeight.w500,
                        fontFamily: "Lato",
                        fontStyle: FontStyle.normal,
                        fontSize: 13.0),
                    textAlign: TextAlign.left),
                SizedBox(height: 10.0),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    IconButton(
                      icon: ImageIcon(AssetImage('assets/icons/phone.png'),
                          size: 60, color: CommonColors.icon_color),
                      onPressed: () {
                        this._launchCaller();
                      },
                      alignment: Alignment.centerRight,
                    ),
                    IconButton(
                      icon: ImageIcon(AssetImage('assets/icons/message.png'),
                          size: 60, color: CommonColors.icon_color),
                      onPressed: () {
                        this._launcherMessage();
                      },
                      alignment: Alignment.centerRight,
                    ),
                    IconButton(
                      icon: ImageIcon(AssetImage('assets/icons/video.png'),
                          size: 60, color: CommonColors.icon_color),
                      onPressed: () {},
                      alignment: Alignment.centerRight,
                    ),
                    IconButton(
                      icon: ImageIcon(AssetImage('assets/icons/mail.png'),
                          size: 60, color: CommonColors.icon_color),
                      onPressed: () {},
                      alignment: Alignment.centerRight,
                    ),
                  ],
                ),
                SizedBox(height: 4.0),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    Text(call,
                        style: const TextStyle(
                            color: const Color(0xff06d59f),
                            fontWeight: FontWeight.w500,
                            fontFamily: "Lato",
                            fontStyle: FontStyle.normal,
                            fontSize: 11.0),
                        textAlign: TextAlign.center),
                    Text(message,
                        style: const TextStyle(
                            color: const Color(0xff06d59f),
                            fontWeight: FontWeight.w500,
                            fontFamily: "Lato",
                            fontStyle: FontStyle.normal,
                            fontSize: 11.0),
                        textAlign: TextAlign.center),
                    Text(video,
                        style: const TextStyle(
                            color: const Color(0xff06d59f),
                            fontWeight: FontWeight.w500,
                            fontFamily: "Lato",
                            fontStyle: FontStyle.normal,
                            fontSize: 11.0),
                        textAlign: TextAlign.left),
                    Text(mail,
                        style: const TextStyle(
                            color: const Color(0xff06d59f),
                            fontWeight: FontWeight.w500,
                            fontFamily: "Lato",
                            fontStyle: FontStyle.normal,
                            fontSize: 11.0),
                        textAlign: TextAlign.left),
                  ],
                )
              ],
            )),
        // : Container(),
        SizedBox(height: 10.0),
        Container(
          decoration: BoxDecoration(color: CommonColors.listing_color),
          child: Column(
            children: [
              SizedBox(height: 10.0),
              Container(
                padding: EdgeInsets.symmetric(horizontal: 20.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(mobile,
                        style: const TextStyle(
                            color: const Color(0xff7e8a88),
                            fontWeight: FontWeight.w400,
                            fontFamily: "Lato",
                            fontStyle: FontStyle.normal,
                            fontSize: 15.0),
                        textAlign: TextAlign.left),
                  ],
                ),
              ),
              Container(
                padding: EdgeInsets.symmetric(horizontal: 20.0, vertical: 5.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text("+92-304-5955-133",
                        style: const TextStyle(
                            color: const Color(0xff000000),
                            fontWeight: FontWeight.w400,
                            fontFamily: "Helvetica",
                            fontStyle: FontStyle.normal,
                            fontSize: 15.0),
                        textAlign: TextAlign.left)
                  ],
                ),
              ),
              Container(
                padding: EdgeInsets.symmetric(horizontal: 20.0, vertical: 5.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(work,
                        style: const TextStyle(
                            color: const Color(0xff7e8a88),
                            fontWeight: FontWeight.w400,
                            fontFamily: "Lato",
                            fontStyle: FontStyle.normal,
                            fontSize: 15.0),
                        textAlign: TextAlign.left),
                  ],
                ),
              ),
              Container(
                padding: EdgeInsets.symmetric(horizontal: 20.0, vertical: 5.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text("Clustox",
                        style: const TextStyle(
                            color: const Color(0xff000000),
                            fontWeight: FontWeight.w400,
                            fontFamily: "Helvetica",
                            fontStyle: FontStyle.normal,
                            fontSize: 15.0),
                        textAlign: TextAlign.left)
                  ],
                ),
              ),
              SizedBox(height: 10.0),
              Container(
                  width: 375,
                  height: 0.5,
                  decoration: BoxDecoration(color: const Color(0xffe4e4e4))),
              Container(
                padding: EdgeInsets.symmetric(horizontal: 20.0, vertical: 5.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(address,
                        style: const TextStyle(
                            color: const Color(0xff7e8a88),
                            fontWeight: FontWeight.w400,
                            fontFamily: "Lato",
                            fontStyle: FontStyle.normal,
                            fontSize: 15.0),
                        textAlign: TextAlign.left),
                  ],
                ),
              ),
              Container(
                padding: EdgeInsets.symmetric(horizontal: 20.0, vertical: 5.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text("345 M block Gulberg ||| Lahore, Pakistan",
                        style: const TextStyle(
                            color: const Color(0xff343434),
                            fontWeight: FontWeight.w400,
                            fontFamily: "Helvetica",
                            fontStyle: FontStyle.normal,
                            fontSize: 14.0),
                        textAlign: TextAlign.left),
                    RaisedButton(
                      child: Text("Next"),
                      onPressed: () {
                        Navigator.of(context).push(
                            MaterialPageRoute(builder: (BuildContext context) {
                          return new GoogleMaps();
                        }));
                      },
                      color: Colors.blueGrey,
                      textColor: Colors.blue,
                      padding: EdgeInsets.fromLTRB(10, 10, 10, 10),
                      splashColor: Colors.grey,
                    )
                  ],
                ),
              ),
            ],
          ),
        )
      ],
    ));
  }
}
