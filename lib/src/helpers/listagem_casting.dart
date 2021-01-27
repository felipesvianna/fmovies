import 'package:fmovies/src/models/ator_atriz_model.dart';

class ListagemCast {
  List<AtorAtriz> listaAtoresAtrizes = new List();

  ListagemCast();

  ListagemCast.fromJsonList(List<dynamic> listaRegistrosJson) {
    if (listaRegistrosJson == null) return;

    listaRegistrosJson.forEach((elem) {
      final atorAtriz = AtorAtriz.fromJsonMap(elem);
      listaAtoresAtrizes.add(atorAtriz);
    });
  }
}
