import 'package:flutter/material.dart';
import 'package:scan_contacts/components/utilities/colors.dart';
import 'package:scan_contacts/components/utilities/constants.dart';
import '../header/contacts_header.dart';
import '../header/user_profile_header.dart';
import '../ocr_scanner/ocr_scanner.dart';

class ContactListing extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return _ContactListing();
  }
}

class _ContactListing extends State<ContactListing> {
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: ContactsHeader(
          height: 120,
        ),
        body: Container(
          child: Column(
            children: [
              UserProfile(),
              Container(
                child: Column(
                  children: [
                    Padding(
                      padding: EdgeInsets.only(top: 40.0, bottom: 10.0),
                      child: Image.asset('assets/icons/no_card.png'),
                    ),
                    Text(noCardAdded,
                        style: const TextStyle(
                            color: CommonColors.no_card_added,
                            fontWeight: FontWeight.w700,
                            fontFamily: "Helvetica",
                            fontStyle: FontStyle.normal,
                            fontSize: 20.0),
                        textAlign: TextAlign.center),
                    Padding(padding: EdgeInsets.only(top: 10.0)),
                    Opacity(
                      opacity: 0.4699999988079071,
                      child: Text(tapScanButton,
                          style: const TextStyle(
                              color: CommonColors.tap_scan_text,
                              fontWeight: FontWeight.w300,
                              fontFamily: "Helvetica",
                              fontStyle: FontStyle.normal,
                              fontSize: 12.0),
                          textAlign: TextAlign.center),
                    )
                  ],
                ),
              )
            ],
          ),
        ),
        floatingActionButton: new FloatingActionButton(
            elevation: 0.0,
            child: Image.asset('assets/icons/floating.png'),
            backgroundColor: CommonColors.listing_color,
            onPressed: () {
              Navigator.of(context)
                  .push(MaterialPageRoute(builder: (BuildContext context) {
                return new OcrScanner();
              }));
            }));
  }
}
