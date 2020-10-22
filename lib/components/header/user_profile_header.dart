import 'package:flutter/material.dart';
import 'package:scan_contacts/components/utilities/colors.dart';
import '../utilities/constants.dart';

class UserProfile extends StatelessWidget {
  final _image;
  final name;
  UserProfile(this._image, this.name);
  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.white,
      child: Column(
        children: [
          Row(
            children: [
              Container(
                padding: EdgeInsets.only(left: 20.0, right: 10.0, top: 10.0),
                child: CircleAvatar(
                  radius: 35,
                  backgroundColor: CommonColors.listing_color,
                  child: _image != null
                      ? ClipRRect(
                          borderRadius: BorderRadius.circular(35),
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
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    name,
                    style: TextStyle(
                        color: CommonColors.name_text,
                        fontWeight: FontWeight.w700,
                        fontFamily: "Helvetica",
                        fontStyle: FontStyle.normal,
                        fontSize: 14.0),
                  ),
                  Padding(padding: EdgeInsets.symmetric(vertical: 5)),
                  Text(my_card,
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
                              onPressed: () {},
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
