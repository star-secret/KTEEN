import 'package:flutter/material.dart';
import 'package:kteen_app/tab_page.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

void main() async {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
        primaryColor: Colors.white,
        accentColor: Colors.black,
      ),
      home: TabPage(),
    );
  }
}