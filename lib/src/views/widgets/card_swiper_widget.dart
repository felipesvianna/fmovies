import 'package:flutter/material.dart';
import 'package:flutter_swiper/flutter_swiper.dart';
import 'package:fmovies/src/models/filme_model.dart';

class CardSwiper extends StatelessWidget {
  final List<Filme> listaDeFilmes;

  CardSwiper({@required this.listaDeFilmes});

  @override
  Widget build(BuildContext context) {
    final _screenSize = MediaQuery.of(context).size;

    return Container(
      padding: EdgeInsets.only(top: 10.0),
      child: Swiper(
        itemWidth: _screenSize.width * 0.7,
        itemHeight: _screenSize.height * 0.5,
        layout: SwiperLayout.STACK,
        itemBuilder: (BuildContext context, int index) {
          return _posterPrincipal(context, listaDeFilmes[index]);
        },
        itemCount: listaDeFilmes.length,
        // pagination: new SwiperPagination(),
        // control: new SwiperControl(),
      ),
    );
  }

  Widget _posterPrincipal(context, Filme dadosFilme) {
    Widget poster = ClipRRect(
        borderRadius: BorderRadius.circular(20.0),
        child: FadeInImage(
          placeholder: AssetImage('assets/img/no-image.jpg'),
          image: NetworkImage(dadosFilme.getImagemPoster()),
          fit: BoxFit.cover,
        ));

    return GestureDetector(
      child: poster,
      onTap: () {
        Navigator.pushNamed(context, 'detalhes-filme', arguments: dadosFilme);
      },
    );
  }
}
