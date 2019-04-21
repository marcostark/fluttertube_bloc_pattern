import 'package:bloc_pattern/bloc_pattern.dart';
import 'package:flutter/material.dart';
import 'package:youtube_bloc_pattern/blocs/video_bloc.dart';
import 'package:youtube_bloc_pattern/screens/home_screen.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      bloc: VideoBloc(),
      child: MaterialApp(
        title: 'FlutterTube',
        theme: ThemeData(
          primarySwatch: Colors.blue,
        ),
        debugShowCheckedModeBanner: false,
        home: HomeScreen(),
      ),
    );
  }
}

// void main() {
//   runApp(MaterialApp(
//     title: 'FlutterTube',
//     theme: ThemeData(
//       primarySwatch: Colors.blue,
//     ),
//     debugShowCheckedModeBanner: false,
//     home: HomeScreen(),
//   ));
// }
