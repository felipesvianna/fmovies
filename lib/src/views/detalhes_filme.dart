import 'package:flutter/material.dart';
import 'package:fmovies/src/models/filme_model.dart';
import 'package:fmovies/src/services/filmes_api.dart';
import 'package:fmovies/src/models/ator_atriz_model.dart';

class DetalhesFilme extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final Filme filmeSelecionado = ModalRoute.of(context).settings.arguments;

    return Scaffold(
        body: CustomScrollView(
      slivers: [
        _criarAppBar(filmeSelecionado),
        SliverList(
          delegate: SliverChildListDelegate([
            SizedBox(
              height: 10.0,
            ),
            _containerPosterTitulo(context, filmeSelecionado),
            _sinopseDoFilme(filmeSelecionado),
            _listaDoCasting(filmeSelecionado.id)
          ]),
        )
      ],
    ));
  }

  Widget _criarAppBar(Filme dadosFilme) {
    return SliverAppBar(
      elevation: 2.0,
      backgroundColor: Colors.indigoAccent,
      expandedHeight: 200.0,
      floating: false,
      pinned: true,
      flexibleSpace: FlexibleSpaceBar(
        centerTitle: true,
        title: Text(
          dadosFilme.title,
          style: TextStyle(color: Colors.white),
        ),
        background: FadeInImage(
            image: NetworkImage(dadosFilme.getBackgroundPoster()),
            placeholder: AssetImage('assets/img/loading.gif'),
            // fadeInDuration: Duration(microseconds: 150),
            fit: BoxFit.cover),
      ),
    );
  }

  Widget _containerPosterTitulo(BuildContext context, Filme dadosFilme) {
    return Container(
        padding: EdgeInsets.symmetric(horizontal: 20.0),
        child: Row(
          children: [
            Image(
              image: NetworkImage(dadosFilme.getImagemPoster()),
              height: 150.0,
            ),
            SizedBox(
              width: 20.0,
            ),
            Flexible(
                child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  dadosFilme.title,
                  style: Theme.of(context).textTheme.bodyText1,
                ),
                (dadosFilme.title == dadosFilme.originalTitle)
                    ? Text('')
                    : Text(
                        '(' + dadosFilme.originalTitle + ')',
                        style: Theme.of(context).textTheme.subtitle2,
                      ),
                Row(
                  children: [
                    Icon(Icons.star_border),
                    Text(dadosFilme.voteAverage.toString(),
                        style: Theme.of(context).textTheme.subtitle2)
                  ],
                )
              ],
            ))
          ],
        ));
  }

  Widget _sinopseDoFilme(Filme dadosFilme) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 10.0, vertical: 20.0),
      child: Text(
        dadosFilme.overview,
        textAlign: TextAlign.justify,
      ),
    );
  }

  Widget _listaDoCasting(int idFilme) {
    final filmesApi = new FilmesAPI();

    return FutureBuilder(
      future: filmesApi.getCast(idFilme),
      builder: (BuildContext context, AsyncSnapshot<List> snapshot) {
        if (snapshot.hasData) {
          return _pageViewListagemCast(snapshot.data);
        } else {
          return Center(child: CircularProgressIndicator());
        }
      },
    );
  }

  Widget _pageViewListagemCast(List<AtorAtriz> listaDoElenco) {
    return SizedBox(
      height: 200.0,
      child: PageView.builder(
          pageSnapping: false,
          controller: PageController(viewportFraction: 0.3, initialPage: 1),
          itemCount: listaDoElenco.length,
          itemBuilder: (context, i) {
            return _cardAtorAtriz(listaDoElenco[i]);
          }),
    );
  }

  Widget _cardAtorAtriz(AtorAtriz atorAtriz) {
    return Container(
      child: Column(
        children: [
          ClipRRect(
            borderRadius: BorderRadius.circular(20.0),
            child: FadeInImage(
                image: NetworkImage(atorAtriz.getFoto()),
                placeholder: AssetImage('assets/img/no-image.jpg'),
                height: 150.0,
                fit: BoxFit.cover),
          ),
          Text(
            atorAtriz.name,
            overflow: TextOverflow.ellipsis,
          )
        ],
      ),
    );
  }
}
