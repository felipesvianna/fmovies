import 'package:flutter/material.dart';
import 'package:fmovies/src/models/filme_model.dart';
import 'package:fmovies/src/services/filmes_api.dart';

class DataSearch extends SearchDelegate {
  final filmesApi = new FilmesAPI();

  @override
  List<Widget> buildActions(BuildContext context) {
    // Actions
    return [
      IconButton(
          icon: Icon(Icons.clear),
          onPressed: () {
            query = '';
          })
    ];
  }

  @override
  Widget buildLeading(BuildContext context) {
    // Icone a esquerda da search bar
    return IconButton(
        icon: AnimatedIcon(
            icon: AnimatedIcons.menu_arrow, progress: transitionAnimation),
        onPressed: () {
          close(context, null);
        });
  }

  @override
  Widget buildResults(BuildContext context) {
    // Resultados da busca
    return Container();
  }

  @override
  Widget buildSuggestions(BuildContext context) {
    // Autocomplete

    if (query.isEmpty) {
      // Retorna container vazio ao inves de null para evitar erros
      return Container();
    }

    return FutureBuilder(
      future: filmesApi.buscarFilme(query),
      builder: (BuildContext context, AsyncSnapshot<List<Filme>> snapshot) {
        if (snapshot.hasData) {
          final listaDeFilmesAutoComplete = snapshot.data;

          return ListView(
              children: listaDeFilmesAutoComplete.map((f) {
            return ListTile(
                leading: FadeInImage(
                  placeholder: AssetImage('assets/img/no-image.jpg'),
                  image: NetworkImage(f.getImagemPoster()),
                  fit: BoxFit.contain,
                  width: 50.0,
                ),
                title: Text(f.title),
                subtitle: Text(f.originalTitle),
                onTap: () {
                  close(context, null);
                  Navigator.pushNamed(context, 'detalhes-filme', arguments: f);
                });
          }).toList());
        } else {
          return Center(child: CircularProgressIndicator());
        }
      },
    );
  }
}
