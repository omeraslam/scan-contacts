import 'dart:io';
import 'package:flutter/material.dart';
import 'package:hive/hive.dart';
import 'package:scan_contacts/components/models/contact_model.dart';
import 'package:scan_contacts/components/utilities/colors.dart';
import '../../utilities/constants.dart';
import 'package:url_launcher/url_launcher.dart';
import '../edit_contact/edit_contact.dart';
import 'package:maps_launcher/maps_launcher.dart';

class ContactDetails extends StatefulWidget {
  final contact_image;
  final name;
  final address;
  final phone_number;
  final email;
  final company_name;
  ContactDetails(this.contact_image,this.name, this.address, this.phone_number, this.email, this.company_name);
  @override
  State<StatefulWidget> createState() {
    // TODO: implement createState
    return _ContactDetailsState();
  }
}

class _ContactDetailsState extends State<ContactDetails> {
  _launchCaller(phone) async {
    String url = "tel:${phone}";
    if (await canLaunch(url)) {
      await launch(url);
    } else {
      throw 'Could not launch $url';
    }
  }

  _launcherMessage(number) async {
    if (Platform.isAndroid) {
      String uri = 'sms:+${number}?body=hello%20there';
      if (await canLaunch(uri)) {
        await launch(uri);
      }
    } else if (Platform.isIOS) {
      String uri = 'sms:${number}?body=hello%20there';
      if (await canLaunch(uri)) {
        await launch(uri);
      } else {
        throw 'Could not launch $uri';
      }
    }
  }

  void _launchEmailSubmission(mail) async {
    final Uri params = Uri(
        scheme: 'mailto',
        path: '${mail}',
        queryParameters: {
          'subject': 'Send Mail',
          'body': 'Hi there'
        });
    String url = params.toString();
    if (await canLaunch(url)) {
      await launch(url);
    } else {
      print('Could not launch $url');
    }
  }

  void _launchMapsSubmission(user_address) async {
    MapsLauncher.launchQuery(user_address);

  }

  navigateToNext() {
    Navigator.of(context)
        .push(MaterialPageRoute(builder: (BuildContext context) {
      return new CarouselIndicator(widget.contact_image,widget.name, widget.address, widget.phone_number, widget.email, widget.company_name);
    }));
  }
  @override
  Widget build(BuildContext context) {
    var fileImage = File(widget.contact_image);
    return Scaffold(
        appBar: AppBar(
          iconTheme: IconThemeData(
            color: Colors.blue,
          ),
          title: Text(contacts,
              style: const TextStyle(
                  color: const Color(0xff057af7),
                  fontWeight: FontWeight.w500,
                  fontFamily: "Lato",
                  fontStyle: FontStyle.normal,
                  fontSize: 15.0),
              textAlign: TextAlign.left),
          actions: [
            Padding(
                padding: EdgeInsets.only(right: 20.0),
                child: GestureDetector(
                  onTap: () {
                     this.navigateToNext();
                  },
                  child: Center(
                    child: Text(
                      edit,
                      style: TextStyle(
                          color: CommonColors.blue_color,
                          fontWeight: FontWeight.w500,
                          fontFamily: "Lato",
                          fontStyle: FontStyle.normal,
                          fontSize: 15.0),
                    ),
                  ),
                )),
          ],
        ),
        body: SingleChildScrollView(
          child: Column(
            children: <Widget>[
              Container(
                  decoration: BoxDecoration(color: const Color(0xfff9f9f9)),
                  child: Column(
                    children: [
                      SizedBox(height: 10.0),
                      fileImage != null ?
                      Container(
                        margin: EdgeInsets.symmetric(horizontal: 10.0),
                        height: 200.0,
                        width: MediaQuery.of(context).size.width,
                        decoration: BoxDecoration(
                            image: DecorationImage(
                                image: FileImage(fileImage),
                                fit: BoxFit.cover))
                      ) :
                      Container(
                        child: Image.asset('assets/icons/no_card.png'),
                      ),
                      SizedBox(height: 10.0),
                      Text(widget.name,
                          style: const TextStyle(
                              color: const Color(0xff010707),
                              fontWeight: FontWeight.w500,
                              fontFamily: "Lato",
                              fontStyle: FontStyle.normal,
                              fontSize: 23.0),
                          textAlign: TextAlign.left),
                      // Text("Design Studio",
                      //     style: const TextStyle(
                      //         color: const Color(0xff7a7a7c),
                      //         fontWeight: FontWeight.w500,
                      //         fontFamily: "Lato",
                      //         fontStyle: FontStyle.normal,
                      //         fontSize: 13.0),
                      //     textAlign: TextAlign.left),
                      SizedBox(height: 10.0),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: [
                          GestureDetector(
                            child: ImageIcon(AssetImage('assets/icons/phone.png'),
                                size: 60, color: CommonColors.icon_color),
                            onTap: () {
                               ;
                              this._launchCaller(widget.phone_number);
                            },
                          ),
                          GestureDetector(
                            child: ImageIcon(AssetImage('assets/icons/message.png'),
                                size: 60, color: CommonColors.icon_color),
                            onTap: () {
                              this._launcherMessage(widget.phone_number);
                            },
                          ),
                          GestureDetector(
                            child: ImageIcon(AssetImage('assets/icons/video.png'),
                                size: 60, color: CommonColors.icon_color),
                            onTap: () {},
                          ),
                          GestureDetector(
                            child: ImageIcon(AssetImage('assets/icons/mail.png'),
                                size: 60, color: CommonColors.icon_color),
                            onTap: () {
                              this._launchEmailSubmission(widget.email);
                            },
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
                          Text(email,
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
                      padding:
                      EdgeInsets.symmetric(horizontal: 20.0, vertical: 5.0),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(widget.email,
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
                      padding:
                      EdgeInsets.symmetric(horizontal: 20.0, vertical: 5.0),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(widget.phone_number,
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
                      padding:
                      EdgeInsets.symmetric(horizontal: 20.0, vertical: 5.0),
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
                      padding:
                      EdgeInsets.symmetric(horizontal: 20.0, vertical: 5.0),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(widget.company_name,
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
                      padding:
                      EdgeInsets.symmetric(horizontal: 20.0, vertical: 5.0),
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
                      padding:
                      EdgeInsets.symmetric(horizontal: 20.0, vertical: 5.0),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(widget.address,
                              style: const TextStyle(
                                  color: const Color(0xff343434),
                                  fontWeight: FontWeight.w400,
                                  fontFamily: "Helvetica",
                                  fontStyle: FontStyle.normal,
                                  fontSize: 14.0),
                              textAlign: TextAlign.left),
                        ],
                      ),
                    ),
                    GestureDetector(
                      onTap: () {
                        this._launchMapsSubmission(widget.address);
                      },
                      child: Center(
                        child:Image.asset('assets/icons/static_map.png')
                      ),
                    )
                    
                  ],
                ),
              ),
            ],
          ),
        )
    );
  }
}

