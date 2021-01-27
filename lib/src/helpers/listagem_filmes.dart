import 'package:fmovies/src/models/filme_model.dart';

class ListagemFilmes {
  List<Filme> listaRegistrosFilmes = new List();

  ListagemFilmes();

  ListagemFilmes.fromJsonList(List<dynamic> listaRegistrosJson) {
    if (listaRegistrosFilmes == null) return;

    for (var r in listaRegistrosJson) {
      final registro = new Filme.fromJsonMap(r);
      listaRegistrosFilmes.add(registro);
    }
  }
}
