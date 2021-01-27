import 'package:flutter/material.dart';
import 'package:fmovies/src/services/data_search.dart';
import 'package:fmovies/src/services/filmes_api.dart';

import 'package:fmovies/src/views/widgets/card_swiper_widget.dart';
import 'package:fmovies/src/views/widgets/carrossel_filmes_widget.dart';

class HomePage extends StatelessWidget {
  final filmesApi = new FilmesAPI();

  @override
  Widget build(BuildContext context) {
    filmesApi.getFilmesPopulares();

    return Scaffold(
      appBar: AppBar(
        title: Text('F-Movies'),
        backgroundColor: Colors.indigoAccent,
        actions: <Widget>[
          IconButton(
              icon: Icon(Icons.search),
              onPressed: () {
                showSearch(context: context, delegate: DataSearch());
              })
        ],
      ),
      body: Container(
          child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: <Widget>[
          _swiperFilmes(),
          _footer(context)
        ],
      )),
    );
  }

  Widget _swiperFilmes() {
    return FutureBuilder(
      future: filmesApi.getFilmesCinema(),
      builder: (BuildContext context, AsyncSnapshot<List> snapshot) {
        if (snapshot.hasData) {
          return CardSwiper(listaDeFilmes: snapshot.data);
        } else {
          return Container(
              height: 400.0, child: Center(child: CircularProgressIndicator()));
        }
      },
    );
  }

  Widget _footer(BuildContext context) {
    return Container(
      width: double.infinity,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
              padding: EdgeInsets.only(left: 20.0),
              child: Text(
                'Populares',
                style: Theme.of(context).textTheme.subtitle1,
              )),
          StreamBuilder(
            stream: filmesApi.streamFilmesPopulares,
            builder: (BuildContext context, AsyncSnapshot<List> snapshot) {
              if (snapshot.hasData) {
                return CarroselFilmes(
                  listaDeFilmes: snapshot.data,
                  fnPaginaSeguinte: filmesApi.getFilmesPopulares,
                );
              } else {
                return Container(
                    child: Center(child: CircularProgressIndicator()));
              }
            },
          ),
        ],
      ),
    );
  }
}
