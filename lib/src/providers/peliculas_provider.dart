
import 'dart:async';
import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:peliculas/src/models/actores_model.dart';
import 'package:peliculas/src/models/info_actores_model.dart';
import 'package:peliculas/src/models/pelicula_model.dart';

class PeliculasProvider {
  String _apikey = '1be559acde8c84453e9230d3127c59d2';
  String _url ='api.themoviedb.org';
  String _language= 'es-Es';

  int _popularesPage = 0;
  bool _cargando = false;
  List<Pelicula> _populares = [];
  // broadcast permite que se pueda escuchar desde varios widgets
  final _popularesStreamControler = StreamController<List<Pelicula>>.broadcast();

  // proceso para introducir peliculas
  Function(List<Pelicula>)get populresSink => _popularesStreamControler.sink.add;

  Stream<List<Pelicula>>get popularesStream => _popularesStreamControler.stream;

  void disposeStreams(){
    _popularesStreamControler?.close();
  }

  Future<List<Pelicula>> _procesarRepuesta(Uri url) async{
    final resp = await http.get(url);
    final decodedData = json.decode(resp.body);
    final peliculas = new Peliculas.fromJsonList(decodedData['results']);
    //print(decodedData['results']);
    //print(peliculas.items[0].title);

    return peliculas.items;
  }


  Future<List<Pelicula>> getEnCines() async{
    final url = Uri.https(_url, '3/movie/now_playing', {
      'api_key': _apikey,
      'language':_language
    } );

    return await _procesarRepuesta(url);
  }


  Future<List<Pelicula>> getPopular() async{

    if(_cargando){
      return [];
    }
    _cargando = false;
    _popularesPage++;

    //print('Cargando siguientes...');

     final url = Uri.https(_url, '3/movie/popular', {
       'api_key':_apikey,
       'language':_language,
       'page': _popularesPage.toString()
     });

     final resp = await _procesarRepuesta(url);
     _populares.addAll(resp);
     populresSink(_populares);

    _cargando = false;
    return resp;
  }

  Future<List<Actor>> getCast(String peliId) async{

    final url = Uri.https(_url, '3/movie/$peliId/credits',{
      'api_key':_apikey,
       'language':_language
    });

    final resp = await http.get(url);
    final decodedData = json.decode(resp.body);
    final cast = new Cast.fromJsonList(decodedData['cast']);
    //print(decodedData['cast']);
    //print(cast.actores[0].character);

    return cast.actores;

  }

  Future<List<Pelicula>> buscarPelicula(String query) async{

    final url = Uri.https(_url, '3/search/movie', {
      'api_key': _apikey,
      'language':_language,
      'query': query
    } );

    return await _procesarRepuesta(url);
  }

  Future<InfoActores> getActor(String actorId) async{
    print('ID actor: $actorId');
    final url = Uri.https(_url, '3/person/$actorId',{
      'api_key':_apikey,
      'language':'en-US'
    });
    final resp = await http.get(url);
    final decodedData = InfoActores.fromJson(json.decode(resp.body));

    print('Datos actor $decodedData');

    return decodedData;

  }


}




