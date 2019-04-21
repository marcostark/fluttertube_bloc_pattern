import 'dart:convert';

import 'package:http/http.dart' as http;
import 'dart:async';

import 'package:youtube_bloc_pattern/models/video.dart';


const API_KEY = "AIzaSyDJjvfseoNR5ot7fSDBXA7ub2iiCWFuz60";

/*
* URLs Usadas
*
* 1 - "https://www.googleapis.com/youtube/v3/search?part=snippet&q=$search&type=video&key=$API_KEY&maxResults=10"
* 2 - "https://www.googleapis.com/youtube/v3/search?part=snippet&q=$_search&type=video&key=$API_KEY&maxResults=10&pageToken=$_nextToken"
* 3 "http://suggestqueries.google.com/complete/search?hl=en&ds=yt&client=youtube&hjson=t&cp=1&q=$search&format=5&alt=json"
* */

class ApiClient {

  search(String term) async {
    http.Response response = await http.get(
        "https://www.googleapis.com/youtube/v3/search?part=snippet&q=$term&type=video&key=$API_KEY&maxResults=10"
    );

    _decodeToJson(response);

  }

  List<Video> _decodeToJson(http.Response response) {
    if(response.statusCode == 200){
      
      var decoded = json.decode(response.body);

      List<Video> videos = decoded["items"].map<Video>(
        (map) {
          return Video.fromJson(map);
        }
      ).toList();

    return videos;    
    } else {
      throw Exception("Erro ao carregar lista de videos");
    }
  }
}