import 'package:flutter/material.dart';

import 'package:peliculas_app/scr/pages/home_page.dart';
import 'package:peliculas_app/scr/pages/pelicula_detalle.dart';
 
void main() => runApp(MyApp());
 
class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Material App',
      initialRoute: '/',
      routes:{
        '/':  (BuildContext context)=>HomePage(),
        'detalle':  (BuildContext context)=>PeliculaDetalle(),
      
      },
      debugShowCheckedModeBanner: false,
      
    );
  }
}