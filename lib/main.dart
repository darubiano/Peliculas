import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:peliculas/src/pages/actor_detalle.dart';
import 'package:peliculas/src/pages/home_page.dart';
import 'package:peliculas/src/pages/pelicula_detalle.dart';

void main() => runApp(MyApp());
 
class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    SystemChrome.setPreferredOrientations([
      DeviceOrientation.portraitUp,
      DeviceOrientation.portraitDown,
    ]);
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Peliculas',
      initialRoute: HomePage.id,
      routes: {
        HomePage.id: (BuildContext context)=> HomePage(),
        PeliculaDetalle.id: (BuildContext context) => PeliculaDetalle(),
        ActorDetalle.id: (BuildContext context) => ActorDetalle()
      },
    );
  }
}