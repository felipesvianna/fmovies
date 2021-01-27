import 'dart:async';
import 'dart:convert';

import 'package:fmovies/src/helpers/listagem_casting.dart';
import 'package:fmovies/src/helpers/listagem_filmes.dart';
import 'package:fmovies/src/models/ator_atriz_model.dart';
import 'package:fmovies/src/models/filme_model.dart';
import 'package:http/http.dart' as http;

class FilmesAPI {
  String _apiKey = ''; // Inserir aqui a API Key TMDB
  String _url = 'api.themoviedb.org';
  String _language = 'en-US';
  int _page = 0;
  List<Filme> _listaDeFilmes = new List();
  bool _isCarregandoDados = false;

  final _filmesPopularesStreamController =
      StreamController<List<Filme>>.broadcast();

  Function(List<Filme>) get addSinkFilmesPopulares =>
      _filmesPopularesStreamController.sink.add;

  Stream<List<Filme>> get streamFilmesPopulares =>
      _filmesPopularesStreamController.stream;

  void disposeStream() {
    _filmesPopularesStreamController?.close();
  }

  dynamic _acionarEndPoint(urlEndPoint) async {
    final response = await http.get(urlEndPoint);
    return json.decode(response.body);
  }

  Future<List<Filme>> getFilmesCinema() async {
    final url = Uri.https(_url, '3/movie/now_playing',
        {'api_key': _apiKey, 'language': _language});

    final dados = await _acionarEndPoint(url);

    final listagem = new ListagemFilmes.fromJsonList(dados['results']);
    return listagem.listaRegistrosFilmes;
  }

  Future<List<Filme>> getFilmesPopulares() async {
    if (_isCarregandoDados) return [];

    _page++;
    _isCarregandoDados = true;

    final url = Uri.https(_url, '3/movie/popular',
        {'api_key': _apiKey, 'language': _language, 'page': _page.toString()});

    final dados = await _acionarEndPoint(url);

    final listagem = new ListagemFilmes.fromJsonList(dados['results']);

    _listaDeFilmes.addAll(listagem.listaRegistrosFilmes);
    addSinkFilmesPopulares(_listaDeFilmes);

    _isCarregandoDados = false;

    return listagem.listaRegistrosFilmes;
  }

  Future<List<Filme>> buscarFilme(String query) async {
    final url = Uri.https(_url, '3/search/movie',
        {'api_key': _apiKey, 'language': _language, 'query': query});

    final dados = await _acionarEndPoint(url);
    
    final listagem = new ListagemFilmes.fromJsonList(dados['results']);
    return listagem.listaRegistrosFilmes;
  }

  Future<List<AtorAtriz>> getCast(int idFilme) async {
    final url = Uri.https(_url, '3/movie/$idFilme/credits',
        {'api_key': _apiKey, 'language': _language});

    final castingJson = await _acionarEndPoint(url);

    final cast = new ListagemCast.fromJsonList(castingJson['cast']);
    return cast.listaAtoresAtrizes;
  }
}
