import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:peliculas/src/models/info_actores_model.dart';
import 'package:peliculas/src/providers/peliculas_provider.dart';

class ActorDetalle extends StatelessWidget {


  @override
  Widget build(BuildContext context) {

    final int actorId = ModalRoute.of(context).settings.arguments;
    final peliProvider = new PeliculasProvider();

    return Scaffold(
      body: FutureBuilder<InfoActores>(
        future: peliProvider.getActor(actorId.toString()),
        builder: (context, AsyncSnapshot snapshot) {
          if(snapshot.hasData){
            if(snapshot.data.birthday!=null){
              return _actor(context, snapshot.data);
            }else{
              return _mostrarAlert(context, snapshot.data);
            }
          }else{
            return Container(
              height: 400.0,
              child: Center(
                child: CircularProgressIndicator()
                )
              );
          }        
        },
      ),
    );
  }

  Widget _actor(BuildContext context, InfoActores data){
    
    return CustomScrollView(
      slivers: <Widget>[
        _crerAppbar(data),
        SliverList(
          delegate: SliverChildListDelegate(
            [
              SizedBox(height: 10.0,),
              _fotoActor(context, data),
              _descripcion(data),
            ]
          ),
        )
      ],
    );
      
  }

  Widget _crerAppbar(InfoActores actor) {
    return SliverAppBar(
      elevation: 2.0,
      backgroundColor: Colors.indigoAccent,
      centerTitle: true,
      title: Text(
          actor.name,
          style: TextStyle(color: Colors.white, fontSize: 16.0, ),
          ),
    );
  }

  Widget _fotoActor(BuildContext context, InfoActores actor){
    String placeOfBirth ='';
    if(actor.placeOfBirth!=null){
     placeOfBirth=actor.placeOfBirth;
    }
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 20.0),
      child: 
          Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              ClipRRect(
                borderRadius: BorderRadius.circular(20.0),
                child: Image(
                  image: NetworkImage(actor.getActorImg()),
                  height: 250.0,
                ),
              ),
              SizedBox(height: 10.0,),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  Text(actor.birthday, style: Theme.of(context).textTheme.title),              
                ],  
              ),
              Text(placeOfBirth,)
            ],
          ),
      );
  }


  Widget _descripcion(InfoActores actor){

    if(actor.biography!=null){
      return Container(
        padding: EdgeInsets.symmetric(horizontal: 10.0, vertical: 20.0),
        child: Column(
          children: <Widget>[
            Text(
              actor.biography,
              textAlign: TextAlign.justify,
              style: TextStyle(fontSize: 20.0, ),
            ),
          ],
        ),
      );
    }else{
      return Text('Ninguna informacion de la bibliografia.',style: TextStyle(fontSize: 20.0, ));
    }
    

  }
  Widget _mostrarAlert(BuildContext context, InfoActores actor){
        return AlertDialog(
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20.0)),
          title: Center(child: Text(actor.name)),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: <Widget>[
              ClipRRect(
                borderRadius: BorderRadius.circular(20.0),
                child: Image(
                  image: NetworkImage(actor.getActorImg()),
                  height: 240.0,
                ),
              ),
              Text('No posee datos.', style: TextStyle(fontSize: 18.0, ),),
            ],
          ),
          actions: <Widget>[
            /*FlatButton(
              child: Text('Cancelar'),
              onPressed: ()=> Navigator.of(context).pop(),
            ),*/
            FlatButton(
              child: Text('OK'),
              onPressed: ()=> Navigator.of(context).pop(),
            )
          ],
        );
      }

}