import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:peliculas/src/models/pelicula_model.dart';
import 'package:peliculas/src/providers/peliculas_provider.dart';

class DataSearch extends SearchDelegate{

  String seleccion ='';

  final peliculasProvider = new PeliculasProvider();

  /*
  final peliculas = [
    'Spiderman 1',
    'Pelota letras',
    'Quien soy yo',
    'Spiderman 2',
    'Spiderman',
    'Iron man',
    'Iron man 2'
  ];

  final peliculasRecientes=[
    'Spiderman 1',
    'Capitan America'
  ];
  */

  @override
  List<Widget> buildActions(BuildContext context) {
    // las acciones de nuestro AppBar, (limpiar o canelar la busqueda).
    return [
      IconButton(
      icon: Icon(Icons.clear),
        onPressed: (){
          query = '';
        },
      )
    ];
  }

  @override
  Widget buildLeading(BuildContext context) {
    // Icono a la izquierda del appbar.
    return IconButton(
      icon: AnimatedIcon(
        icon: AnimatedIcons.menu_arrow,
        progress: transitionAnimation,
      ),
      onPressed: (){
        // salir del search
        close(context, null);
      },
    );
  }

  @override
  Widget buildResults(BuildContext context) {
    // Crea los resultados que bamos a mostrar.
    return Center(
      /*
      child: Container(
        height: 100.0,
        width: 100.0,
        color: Colors.blueAccent,
        child: Text(seleccion),
      ),*/
    );
  }

  @override
  Widget buildSuggestions(BuildContext context) {
    // Son las sugerencias que aparecen cuando la persona escribe.
    if (query.length == 0) {
      return Container();
    } else {
      return FutureBuilder(
        future: peliculasProvider.buscarPelicula(query),
        builder: (BuildContext context, AsyncSnapshot<List<Pelicula>> snapshot) {
          if(snapshot.hasData){
            final peliculas = snapshot.data;

            return ListView(
              children: peliculas.map((pelicula){
               return ListTile(
                 leading: FadeInImage(
                   image: NetworkImage(pelicula.getPosterImg()),
                   placeholder: AssetImage('assets/img/no-image.jpg'),
                   width: 50.0,
                   fit: BoxFit.contain,
                 ),
                 title: Text(pelicula.title),
                 subtitle: Text(pelicula.originalTitle),
                 onTap: (){
                   close(context, null);
                   pelicula.uniqueId = '';
                   Navigator.pushNamed(
                     context, 
                     'detalle',
                     arguments: pelicula
                   );
                 },
               );
              }).toList(),
            );
          }else{
            return Center(
              child: CircularProgressIndicator(),
            );
          }
        },
      );
    }
  }
  
}



/*
@override
  Widget buildSuggestions(BuildContext context) {
    // Son las sugerencias que aparecen cuando la persona escribe.

    final listaSugerida = (query.isEmpty)
                          ? peliculasRecientes
                          : peliculas.where(
                            (p)=> p.toLowerCase().startsWith(query)
                          ).toList();

    return ListView.builder(
      itemCount: peliculasRecientes.length,
      itemBuilder: (context, i){
        return ListTile(
          leading: Icon(Icons.movie),
          title: Text(listaSugerida[i]),
          onTap: (){
            seleccion = listaSugerida[i];
            showResults(context);
          },
        );
      },
    );
  }
*/








