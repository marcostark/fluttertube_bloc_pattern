import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class DataSearch extends SearchDelegate<String> {
  ///Funcionalidade para tela de pesquisa

  @override
  List<Widget> buildActions(BuildContext context) {
    return [
      IconButton(
        icon: Icon(Icons.clear),
        onPressed: () {
          query = "";
        },
      )
    ];
  }

  @override
  Widget buildLeading(BuildContext context) { // Botão de voltar
    return IconButton(
      icon: AnimatedIcon(
        icon: AnimatedIcons.menu_arrow,
        progress: transitionAnimation,
      ),
      onPressed: () {
        close(context, null);
      },
    );
  }

  @override
  Widget buildResults(BuildContext context) {
    // Mostra os resutados do que foi pesquisado na mesma tela de pesquisa
    
    // GAMBI - Adia o fechamento da tela atual
    Future.delayed(Duration.zero).then((_)=> close(context, query));

    return Container();
  }

  @override
  Widget buildSuggestions(BuildContext context) {
    //Carrega as sugestões de busca baseado no que está sendo digitado
    if (query.isEmpty) {
      return Container();
    } else {
      return FutureBuilder<List>(
        future: _seggestionSearch(query), //Buscando a sugestão na api da google
        builder: (context, snapshot) {
          if (!snapshot.hasData) {
            return Center(
              child: CircularProgressIndicator(),
            );
          } else {
            return ListView.builder(
              itemBuilder: (context, index) {
                return ListTile(
                    title: Text(snapshot.data[index]),
                    leading: Icon(Icons.play_arrow),
                    onTap: () {
                      close(context, snapshot.data[index]);
                    });
              },
              itemCount: snapshot.data.length,
            );
          }
        },
      );
    }
  }

  // Metodo para retornar sugestões baseadas no termo que está sendo digitado
  Future<List> _seggestionSearch(String term) async {

    // Endereço de onde está sendo feita a busca
    http.Response response = await http.get(
        "http://suggestqueries.google.com/complete/search?hl=en&ds=yt&client=youtube&hjson=t&cp=1&q=$term&format=5&alt=json");

    if (response.statusCode == 200) {
      return json.decode(response.body)[1].map((valor) {
        return valor[0];
      }).toList();
    } else {
      throw Exception("Falha ao carregar sugestões");
    }
  }
}
