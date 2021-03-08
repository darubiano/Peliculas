import 'package:animate_do/animate_do.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:peliculas/src/providers/peliculas_provider.dart';
import 'package:peliculas/src/search/search_delegate.dart';
import 'package:peliculas/src/widgets/Drawer.dart';
import 'package:peliculas/src/widgets/card_swiper_widget.dart';
import 'package:peliculas/src/widgets/movie_horizontal.dart';

class HomePage extends StatelessWidget {
  static const String id = 'Drawer';
  final peliculasProvider = PeliculasProvider();

  @override
  Widget build(BuildContext context) {
    peliculasProvider.getPopular();

    return SafeArea(
      child: Scaffold(
          drawer: DrawerPage(),
          appBar: AppBar(
            title: ElasticIn(child: Text('\u{1F3A5} Peliculas en cines ')),
            centerTitle: true,
            backgroundColor: Colors.indigoAccent,
            actions: <Widget>[
              IconButton(
                icon: Icon(Icons.search),
                onPressed: () {
                  showSearch(
                    context: context,
                    delegate: DataSearch(),
                    //query: 'textoInicial'
                  );
                },
              )
            ],
          ),
          body: Container(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: <Widget>[
                ZoomIn(
                  delay: Duration(seconds: 1),
                  child: _swiperTarjetas(),
                ),
                FadeInRight(
                  delay: Duration(seconds: 1),
                  child: _footer(context),
                ),
              ],
            ),
          )),
    );
  }

  Widget _swiperTarjetas() {
    return FutureBuilder(
      future: peliculasProvider.getEnCines(),
      builder: (BuildContext context, AsyncSnapshot<List> snapshot) {
        if (snapshot.hasData) {
          return CardSwiper(
            peliculas: snapshot.data,
          );
        } else {
          return Container(
              height: 400.0, child: Center(child: CircularProgressIndicator()));
        }
      },
    );
  }

  Widget _footer(BuildContext context) {
    return Container(
      width: double.infinity,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: <Widget>[
          Text(' \u{1F3AC} Populares',
                  style: Theme.of(context).textTheme.headline6),
          StreamBuilder(
            stream: peliculasProvider.popularesStream,
            builder: (BuildContext context, AsyncSnapshot<List> snapshot) {
              if (snapshot.hasData) {
                return MovieHorizontal(
                  peliculas: snapshot.data,
                  siguientePagina: peliculasProvider.getPopular,
                );
              } else {
                return Center(child: CircularProgressIndicator());
              }
            },
          ),
        ],
      ),
    );
  }
}
