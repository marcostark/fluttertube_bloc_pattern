import 'package:flutter/material.dart';
import 'package:youtube_bloc_pattern/screens/home_screen.dart';

void main() {
  runApp(MaterialApp(
    title: 'FlutterTube',
    theme: ThemeData(
      primarySwatch: Colors.blue,
    ),
    debugShowCheckedModeBanner: false,
    home: HomeScreen(),
  ));
}
