import 'dart:io';
import 'package:hive/hive.dart';
import 'package:path_provider/path_provider.dart' as pathProvider;
import 'package:flutter/material.dart';
import 'package:scan_contacts/components/models/contact_model.dart';
import 'package:scan_contacts/components/models/user_model.dart';
import 'package:scan_contacts/components/screens/contact_listing/contact_listing.dart';
import 'components/models/contact_favourites.dart';
import 'components/screens/on_boarding/on_boarding.dart';
import 'components/utilities/colors.dart';
import 'package:scan_contacts/components/models/contact_images.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  Directory directory = await pathProvider.getApplicationDocumentsDirectory();
  Hive.init(directory.path);
  Hive.registerAdapter(UserModelAdapter());
  Hive.registerAdapter(ContactModelAdapter());
  Hive.registerAdapter(ContactImagesModelAdapter());
  Hive.registerAdapter(ContactFavouritesModelAdapter());
  runApp(MyApp());
}

class MyApp extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return _MyApp();
  }
}

class _MyApp extends State<MyApp> {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData(
        primaryColor: CommonColors.PrimaryColor,
      ),
      home: FutureBuilder(
          future: Hive.openBox('user'),
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.done) {
              if (snapshot.hasError) {
                return Text(snapshot.error.toString());
              } else {
                final userBox = Hive.box('user');
                if (userBox.values.isNotEmpty) {
                  return ContactListing();
                } else
                  return OnBoarding();
              }
            } else
              return Scaffold();
          }),
    );
  }

  @override
  void initState() {
    super.initState();
    Hive.openBox('cardContact');
    Hive.openBox('cardImages');
    Hive.openBox('cardFavourites');
  }

  @override
  void dispose() {
    Hive.box('user').close();
    Hive.box('cardContact').close();
    Hive.box('cardImages').close();
    Hive.box('cardFavourites').close();
    super.dispose();
  }
}
