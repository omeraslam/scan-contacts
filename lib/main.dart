import 'dart:io';
import 'package:hive/hive.dart';
import 'package:path_provider/path_provider.dart' as pathProvider;
import 'package:flutter/material.dart';
// import 'package:scan_contacts/components/models/contact_model.dart';
import 'package:scan_contacts/components/models/user_model.dart';
import 'components/screens/on_boarding/on_boarding.dart';
import 'components/utilities/colors.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  Directory directory = await pathProvider.getApplicationDocumentsDirectory();
  Hive.init(directory.path);
  Hive.registerAdapter(UserModelAdapter());
  // Hive.registerAdapter(ContactModelAdapter());
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
              } else
                return OnBoarding();
            } else
              return Scaffold();
          }),
    );
  }

  @override
  void dispose() {
    Hive.box('user').close();
    super.dispose();
  }
}
