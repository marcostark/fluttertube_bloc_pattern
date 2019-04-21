
import 'package:flutter/material.dart';
import 'package:youtube_bloc_pattern/blocs/data_search.dart';

class HomeScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Container(
          height: 25.0,
          child: Image.asset("images/yt_logo_rgb_dark.png"),
        ),
        elevation: 0,
        backgroundColor: Colors.black54,
        actions: <Widget>[
          Align(
            alignment: Alignment.center,
            child: Text("1"),
          ),
          IconButton(
            icon: Icon(Icons.star),
            onPressed: (){},
            ),
          IconButton(
            icon: Icon(Icons.search),
            onPressed: () async {
              // Pegando o termo passado pela tela de pesquisa
              String result = await showSearch(context: context, delegate: DataSearch()); // Tela de pesquisa
              print(result);
            },
          )
        ],
      ),
      body: Container(

      ),
    );
  }
}
