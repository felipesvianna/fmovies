import 'package:flutter/material.dart';
import 'package:fmovies/src/views/detalhes_filme.dart';
import 'package:fmovies/src/views/home_page.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'F-Movies',
        initialRoute: '/',
        routes: {
          '/': (BuildContext context) => HomePage(),
          'detalhes-filme': (BuildContext context) => DetalhesFilme(),
        });
  }
}
