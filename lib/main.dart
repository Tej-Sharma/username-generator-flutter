import 'package:flutter/material.dart';
import './usernames.dart';


/// Made by Tejas Sharma. Free to use code.
/// Using the English words package, generate an infinite list of usernames
void main() => runApp(MyApp());

// Set the theme and attach the pages
class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData(primaryColor: Colors.green),
      home: WordList()
    );
  }
}