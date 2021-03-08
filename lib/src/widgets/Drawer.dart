import 'package:flutter/material.dart';
import 'package:peliculas/src/pages/home_page.dart';

class DrawerPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: ListView(
        children: <Widget>[
          DrawerHeader(
              padding: EdgeInsets.all(0),
              child: Container(
                child: Center(child: Image.asset('assets/icon/icono.png')),
                color: Colors.black,
              )),
          ListTile(
            leading: Icon(Icons.movie_creation, color: Colors.blue),
            title: Text('Inicio',style: TextStyle(fontSize:15),),
            onTap: () {
              Navigator.popAndPushNamed(context,HomePage.id);
            },
          ),
          ListTile(
            leading: Icon(Icons.settings, color: Colors.blue),
            title: Text('Configuración',style: TextStyle(fontSize:15),),
            onTap: () {
              Navigator.popAndPushNamed(context,HomePage.id);
            },
          ),
        ],
      ),
    );
  }
}