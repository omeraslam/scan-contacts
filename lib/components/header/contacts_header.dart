import 'package:flutter/material.dart';
import '../utilities/colors.dart';
import '../utilities/constants.dart';

class CustomBarWidget extends StatelessWidget implements PreferredSizeWidget {
  final double height;

  CustomBarWidget({
    Key key,
    @required this.height,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        height: 138.0,
        child: Stack(
          children: <Widget>[
            Container(
              color: CommonColors.header_color,
              width: MediaQuery.of(context).size.width,
              height: 150.0,
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
                          maxLines: 1,
                          cursorColor: CommonColors.search_text,
                          decoration: InputDecoration(
                            hintText: search,
                            hintStyle:
                                TextStyle(color: CommonColors.search_text),
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
      ),
    );
  }

  @override
  Size get preferredSize => Size.fromHeight(height);
}
