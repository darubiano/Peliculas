import 'package:flutter/material.dart';
import 'package:flutter_swiper/flutter_swiper.dart';
import 'package:peliculas/src/models/pelicula_model.dart';
import 'package:peliculas/src/pages/pelicula_detalle.dart';

class CardSwiper extends StatelessWidget {

  final List<Pelicula> peliculas;

  CardSwiper({ this.peliculas});

  @override
  Widget build(BuildContext context) {

    // determinar el ancho y alto de las tarjetas
    final _screnSize = MediaQuery.of(context).size;
    //print('tamaño : $_screnSize');
    return Container(
      //padding: EdgeInsets.only(top: 10.0),
      child: Swiper(
        itemWidth: _screnSize.width*0.3,
        itemHeight: _screnSize.height*0.6,
        layout: SwiperLayout.STACK,
        itemBuilder: (BuildContext context,int index){
          //print(peliculas.length);
          peliculas[index].uniqueId = '${peliculas[index].id}-tarjeta';
          return Hero(
                tag: peliculas[index].uniqueId,
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(20.0),
                  child: GestureDetector(
                          onTap: (){
                            print('ID de la pelicula ${peliculas[index].id}');
                            Navigator.pushNamed(context, PeliculaDetalle.id,
                            arguments: peliculas[index]
                            );
                          },
                          child: FadeInImage(
                          image: NetworkImage( peliculas[index].getPosterImg()),
                          placeholder: AssetImage('assets/img/no-image.jpg'),
                          fit: BoxFit.cover,
                    ),
                  ),
            ),
          );    
        },
        itemCount: peliculas.length,
        //pagination: new SwiperPagination(),
        //control: new SwiperControl(),
        ),
    );

  }
}