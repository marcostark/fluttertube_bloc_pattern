import 'dart:async';

import 'package:bloc_pattern/bloc_pattern.dart';
import 'package:youtube_bloc_pattern/models/video.dart';
import 'package:youtube_bloc_pattern/services/api_client.dart';

class VideoBloc implements BlocBase {
  
  ApiClient apiClient;

  List<Video> _videos;

  final StreamController<List<Video>> _videosController = StreamController<List<Video>>();
  
  // Declarando um get para o streamcontroller, tendo acesso de fora da classe
  Stream get outVideos => _videosController.stream;
  

  // Acesso a entrada por fora do bloc
  final StreamController<String> _searchController = StreamController<String>();
  
  // Colocando dados no searchController
  Sink get inSearch => _searchController.sink;

  VideoBloc(){
    apiClient = ApiClient();

    // Pegando a saida 
    _searchController.stream.listen(_search);
  }

  void _search(String search) async{

    if(search != null){
      _videosController.sink.add([]); // Lista vazia ao efetuar uma nova pesquisa
      _videos = await apiClient.search(search);
    } else {
      _videos += await apiClient.nextPage(); //Juntando duas listas
    }    
    _videosController.sink.add(_videos);
  }
  
  @override
  void dispose() {
    _videosController.close();
  }
}