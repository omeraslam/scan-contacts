import 'package:flutter/material.dart';
import 'package:scan_contacts/components/utilities/colors.dart';
import 'package:scan_contacts/components/utilities/constants.dart';
import '../../header/contacts_header.dart';
import '../../header/user_profile_header.dart';

class ContactListing extends StatefulWidget {
  final _image;
  final name;
  ContactListing(this._image, this.name);
  @override
  State<StatefulWidget> createState() {
    return _ContactListing();
  }
}

class _ContactListing extends State<ContactListing> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: CustomBarWidget(
          height: 120,
        ),
        body: Container(
          child: Column(
            children: [
              UserProfile(widget._image, widget.name),
              Container(
                child: Column(
                  children: [
                    Padding(
                      padding: EdgeInsets.only(top: 40.0, bottom: 10.0),
                      child: Image.asset('assets/icons/no_card.png'),
                    ),
                    Text(no_card_added,
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
                      child: Text(tap_scan_button,
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
            onPressed: () {}));
  }
}
