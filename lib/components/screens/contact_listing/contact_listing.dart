import 'dart:io';

import 'package:flutter/material.dart';
import 'package:hive/hive.dart';
import 'package:scan_contacts/components/models/contact_favourites.dart';
import 'package:scan_contacts/components/models/contact_images.dart';
import 'package:scan_contacts/components/models/contact_model.dart';
import 'package:scan_contacts/components/models/user_model.dart';
import 'package:scan_contacts/components/screens/contact_details/contact_details.dart';
import 'package:scan_contacts/components/utilities/colors.dart';
import 'package:scan_contacts/components/utilities/constants.dart';
import '../ocr_scanner/ocr_scanner.dart';
import 'package:alphabet_list_scroll_view/alphabet_list_scroll_view.dart';

class ContactListing extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return _ContactListing();
  }
}

class _ContactListing extends State<ContactListing> {
  final contactBox = Hive.box('cardContact');
  final favouriteContactsBox = Hive.box('cardFavourites');
  List get fetchFromFavBox => favouriteContactsBox.values.toList();
  List get fetchFromContactsBox => contactBox.values.toList();
  var searchedList = List();
  int id;
  TextEditingController searchController;

  @override
  void initState() {
    super.initState();
    searchController = TextEditingController();
    searchedList.addAll(fetchFromContactsBox);
    searchedList.sort((a, b) => a.userName
        .toString()
        .toLowerCase()
        .compareTo(b.userName.toString().toLowerCase()));
    print(searchedList);
  }

  _addToFavourites(contact) {
    final favouriteContact = ContactFavouritesModel(
      frontImage: contact.frontImage,
      userName: contact.userName,
      companyName: contact.companyName,
      email: contact.email,
      address: contact.address,
      mobileNumber: contact.mobileNumber,
    );
    favouriteContactsBox.add(favouriteContact);
    print(favouriteContactsBox.values);
    print('saved');
  }

  _deleteFromFavourites(contact) {
    favouriteContactsBox.delete(contact._key);
  }

  _filterSearchResults(String query) {
    if (query.isNotEmpty) {
      setState(() {
        searchedList = fetchFromContactsBox
            .where((string) =>
                string.userName.toLowerCase().contains(query.toLowerCase()))
            .toList();
      });
      return;
    } else {
      setState(() {
        searchedList.clear();
        searchedList.addAll(fetchFromContactsBox);
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: CustomScrollView(
          slivers: [
            SliverAppBar(
              leading: Container(),
              flexibleSpace: Column(
                children: [_header(), _secondHeader()],
              ),
              floating: true,
              expandedHeight: MediaQuery.of(context).size.height * 0.5,
            ),
            _buildListView()
          ],
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

  _header() {
    return Container(
      height: MediaQuery.of(context).size.height * 0.23,
      child: Stack(
        children: <Widget>[
          Container(
            color: CommonColors.header_color,
            width: MediaQuery.of(context).size.width,
            height: 100.0,
            child: Center(
              child: SizedBox(
                width: double.infinity,
                child: Container(
                  padding: EdgeInsets.symmetric(horizontal: 20.0),
                  color: CommonColors.header_color,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        contacts,
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          fontSize: 26.0,
                          fontWeight: FontWeight.w700,
                          fontFamily: "Lato",
                        ),
                      ),
                      IconButton(
                        icon: Icon(
                          Icons.settings,
                          color: CommonColors.settings_color,
                        ),
                        onPressed: () {},
                        alignment: Alignment.centerRight,
                        padding: EdgeInsets.all(0),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ),
          Positioned(
            top: 90.0,
            left: 0.0,
            right: 0.0,
            child: Container(
              padding: EdgeInsets.symmetric(horizontal: 20.0),
              child: DecoratedBox(
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(4.0),
                    border: Border.all(
                        color: Colors.grey.withOpacity(1.0), width: 0),
                    color: Colors.white),
                child: Row(
                  children: [
                    IconButton(
                      icon: Icon(
                        Icons.search,
                        color: CommonColors.search_text,
                      ),
                      onPressed: () {},
                    ),
                    Expanded(
                      child: TextField(
                        autofocus: false,
                        onChanged: (text) {
                          _filterSearchResults(text);
                        },
                        maxLines: 1,
                        cursorColor: CommonColors.search_text,
                        decoration: InputDecoration(
                          hintText: search,
                          hintStyle: TextStyle(color: CommonColors.search_text),
                          enabledBorder: UnderlineInputBorder(
                            borderSide:
                                BorderSide(color: CommonColors.search_text),
                          ),
                          focusedBorder: UnderlineInputBorder(
                            borderSide:
                                BorderSide(color: CommonColors.search_text),
                          ),
                          border: UnderlineInputBorder(
                            borderSide:
                                BorderSide(color: CommonColors.search_text),
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          )
        ],
      ),
    );
  }

  _buildListView() {
    if (contactBox.values.isNotEmpty) {
      return SliverList(
          delegate:
              SliverChildBuilderDelegate((BuildContext context, int index) {
        final contact = searchedList[index];
        final bool alreadySaved = fetchFromFavBox.contains(contact);
        return ListTile(
          leading: CircleAvatar(
            backgroundImage: AssetImage('assets/icons/message.png'),
          ),
          title: Text(
            contact.userName,
            style: const TextStyle(
                color: const Color(0xff010707),
                fontWeight: FontWeight.w600,
                fontFamily: "Lato",
                fontStyle: FontStyle.normal,
                fontSize: 15.0),
          ),
          subtitle: Text(
            contact.mobileNumber.toString(),
            style: const TextStyle(
                color: const Color(0xff787878),
                fontWeight: FontWeight.w400,
                fontFamily: "Helvetica",
                fontStyle: FontStyle.normal,
                fontSize: 10.0),
          ),
          trailing: IconButton(
              icon: alreadySaved ? Icon(Icons.star) : Icon(Icons.star_border),
              color: alreadySaved ? Colors.red : null,
              onPressed: () => {
                    setState(() {
                      if (alreadySaved) {
                        _deleteFromFavourites(contact);
                        print('removed');
                      } else {
                        _addToFavourites(contact);
                      }
                    })
                  }),
          onTap: () {
            Navigator.of(context)
                .push(MaterialPageRoute(builder: (BuildContext context) {
              return new ContactDetails(
                  contact.frontImage,
                  contact.userName,
                  contact.address,
                  contact.mobileNumber,
                  contact.email,
                  contact.companyName);
            }));
          },
        );
      }, childCount: searchedList.length));
    } else {
      return SliverList(
          delegate:
              SliverChildBuilderDelegate((BuildContext context, int index) {
        return Center(
          child: Column(
            children: [
              Padding(
                padding: EdgeInsets.only(top: 40.0, bottom: 10.0),
                child: Expanded(
                  child: Image.asset('assets/icons/no_card.png'),
                ),
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
        );
      }, childCount: 1));
    }
  }

  ListView _buildImageListView() {
    final contactBox = Hive.box('cardContact');
    if (contactBox != null) {
      return ListView.builder(
          itemCount: contactBox.length,
          itemBuilder: (BuildContext context, int index) {
            final image = contactBox.get(index) as ContactModel;
            var file = File(image.frontImage);
            return Container(
                margin: EdgeInsets.symmetric(horizontal: 10.0),
                height: 200.0,
                width: MediaQuery.of(context).size.width,
                decoration: BoxDecoration(
                    image: DecorationImage(
                        image: FileImage(file), fit: BoxFit.cover)));
          });
    }
  }

  _secondHeader() {
    final userBox = Hive.box('user');
    final user = userBox.getAt(0) as UserModel;
    var file = File(user.photoUrl);
    return Container(
      color: Colors.white,
      height: MediaQuery.of(context).size.height * 0.25,
      child: Column(
        children: [
          Row(
            children: [
              Container(
                padding: EdgeInsets.only(left: 20.0, right: 10.0, top: 10.0),
                child: CircleAvatar(
                  radius: 35,
                  backgroundColor: CommonColors.listing_color,
                  child: file != null
                      ? ClipRRect(
                          borderRadius: BorderRadius.circular(35),
                          child: Image.file(
                            file,
                            width: 200,
                            height: 200,
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
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    user.userName,
                    style: TextStyle(
                        color: CommonColors.name_text,
                        fontWeight: FontWeight.w700,
                        fontFamily: "Helvetica",
                        fontStyle: FontStyle.normal,
                        fontSize: 14.0),
                  ),
                  Padding(padding: EdgeInsets.symmetric(vertical: 5)),
                  Text(user.contactNumber,
                      style: const TextStyle(
                          color: const Color(0xff787878),
                          fontWeight: FontWeight.w500,
                          fontFamily: "Lato",
                          fontStyle: FontStyle.normal,
                          fontSize: 12.0),
                      textAlign: TextAlign.left)
                ],
              )
            ],
          ),
          Column(
            children: [
              Container(
                margin: const EdgeInsets.only(top: 10.0),
                padding: const EdgeInsets.only(left: 10.0, right: 20.0),
                decoration: BoxDecoration(
                    border: Border.all(color: CommonColors.border_color)),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Column(
                      children: [
                        Row(
                          children: [
                            IconButton(
                              icon: Image.asset(
                                'assets/icons/menu.png',
                                height: 30,
                              ),
                              onPressed: () {},
                              alignment: Alignment.centerRight,
                              padding: EdgeInsets.all(0),
                            ),
                            IconButton(
                              icon: Image.asset(
                                'assets/icons/star.png',
                                height: 30,
                              ),
                              onPressed: () {},
                              alignment: Alignment.centerRight,
                              padding: EdgeInsets.all(0),
                            ),
                          ],
                        )
                      ],
                    ),
                    Column(
                      children: [
                        Row(
                          children: [
                            IconButton(
                              icon: Image.asset(
                                'assets/icons/list_icons.png',
                                height: 20,
                              ),
                              onPressed: () {},
                              alignment: Alignment.centerRight,
                              padding: EdgeInsets.all(0),
                            ),
                            IconButton(
                              icon: Image.asset(
                                'assets/icons/card.png',
                                height: 30,
                              ),
                              onPressed: () {
                                _buildImageListView();
                              },
                              alignment: Alignment.centerRight,
                              padding: EdgeInsets.all(0),
                            ),
                          ],
                        )
                      ],
                    ),
                  ],
                ),
              )
            ],
          )
        ],
      ),
    );
  }
}
