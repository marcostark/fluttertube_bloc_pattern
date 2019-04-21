
import 'package:bloc_pattern/bloc_pattern.dart';
import 'package:flutter/material.dart';
import 'package:youtube_bloc_pattern/blocs/video_bloc.dart';
import 'package:youtube_bloc_pattern/delegate/data_search.dart';
import 'package:youtube_bloc_pattern/widgets/video_tile.dart';

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
              if (result != null) BlocProvider.of<VideoBloc>(context).inSearch.add(result);
              print("Resultado da busca"+result);
            },
          )
        ],
      ),
      backgroundColor: Colors.black,
      body: StreamBuilder(
        // A qualquer alteração a tela é atualizada
        stream: BlocProvider.of<VideoBloc>(context).outVideos,
        initialData: [],
        builder: (context, snapshot){
          if(snapshot.hasData){
            // Mostrar os resultados
            return ListView.builder(
              itemBuilder: (context, index){
                print(snapshot);
                if(index < snapshot.data.length){
                  return VideoTile(snapshot.data[index]);
                } else if (index > 1){
                  BlocProvider.of<VideoBloc>(context).inSearch.add(null);
                  return Container(
                    width: 40,
                    height: 40,
                    alignment: Alignment.center,
                    child: CircularProgressIndicator(valueColor: AlwaysStoppedAnimation<Color>(Colors.red),),
                    );
                } else {
                  Container();
                }
              },
              itemCount: snapshot.data.length + 1,
            );
          } else {
            return Container();
          }
        },
      ),
    );
  }
}
