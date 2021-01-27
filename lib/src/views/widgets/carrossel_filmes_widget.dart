import 'package:flutter/material.dart';
import 'package:fmovies/src/models/filme_model.dart';

class CarroselFilmes extends StatelessWidget {
  final List<Filme> listaDeFilmes;

  /* Funcao que carregara a pagina seguinte
  da listagem de filmes */
  final Function fnPaginaSeguinte;

  CarroselFilmes(
      {@required this.listaDeFilmes, @required this.fnPaginaSeguinte});

  final _pageController =
      new PageController(initialPage: 1, viewportFraction: 0.3);

  @override
  Widget build(BuildContext context) {
    final _screenSize = MediaQuery.of(context).size;

    _pageController.addListener(() {
      if (_pageController.position.pixels >=
          _pageController.position.maxScrollExtent - 200) {
        fnPaginaSeguinte();
      }
    });

    return Container(
      height: _screenSize.height * 0.2,
      child: _gerarListaDePosteres(context),
    );
  }

  Widget _gerarListaDePosteres(BuildContext context) {
    return PageView.builder(
      pageSnapping: false,
      controller: _pageController,
      itemCount: listaDeFilmes.length,
      itemBuilder: (context, i) => _posterDoFilme(context, listaDeFilmes[i]),
    );
  }

  Widget _posterDoFilme(BuildContext context, Filme dadosFilme) {
    Widget poster = Container(
      margin: EdgeInsets.only(right: 15.0),
      child: Column(
        children: [
          FadeInImage(
            placeholder: AssetImage('assets/img/no-image.jpg'),
            image: NetworkImage(dadosFilme.getImagemPoster()),
            fit: BoxFit.cover,
            height: 127.0,
          ),
          SizedBox(
            height: 5.0,
          ),
          Text(
            dadosFilme.title,
            overflow: TextOverflow.ellipsis,
            style: Theme.of(context).textTheme.caption,
          )
        ],
      ),
    );

    return GestureDetector(
      child: poster,
      onTap: () {
        Navigator.pushNamed(context, 'detalhes-filme', arguments: dadosFilme);
      },
    );
  }
}
