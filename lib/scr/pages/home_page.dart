import 'package:flutter/material.dart';
import 'package:peliculas_app/scr/providers/peliculas_provider.dart';
import 'package:peliculas_app/scr/widgets/card_swiper_widget.dart';
import 'package:peliculas_app/scr/widgets/movie_horizontal_widget.dart';

class HomePage extends StatelessWidget {
  final peliculasProvider = new PeliculasProvider();

  @override
  Widget build(BuildContext context) {
    peliculasProvider.getPopulares();
    return Scaffold(
        appBar: AppBar(
          title: Padding(
              padding: EdgeInsets.only(left: 10),
              child: Text(
                'Peliculas en Cartelera',
                style: TextStyle(color: Colors.white),
                textAlign: TextAlign.center,
              )),
          backgroundColor: Colors.black,
          actions: <Widget>[
            IconButton(icon: Icon(Icons.search), onPressed: () {})
          ],
        ),
        body: Container(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: <Widget>[_swiperTarjetas(), _footer(context)],
          ),
        ));
  }

  _swiperTarjetas() {
    return FutureBuilder(
      future: peliculasProvider.getEnCines(),
      builder: (BuildContext context, AsyncSnapshot<List> snapshot) {
        if (snapshot.hasData) {
          return CardSwiper(peliculas: snapshot.data);
        } else {
          return Container(
              height: 400.0,
              child: Center(
                child: Center(child: CircularProgressIndicator()),
              ));
        }
      },
    );
  }

  _footer(BuildContext context) {
    peliculasProvider.getPopulares();
    return Container(
      width: double.infinity,
      child: Column(
        children: <Widget>[
          Text('Populares', style: Theme.of(context).textTheme.subhead),
          StreamBuilder(
            // future: peliculasProvider.getPopulares(),
            stream: peliculasProvider.popularesStream ,
            builder: (BuildContext context, AsyncSnapshot<List> snapshot) {
              if (snapshot.hasData) {
                return MovieHorizontal(peliculas: snapshot.data,siguientePagina:peliculasProvider.getPopulares);
              } else {
                return Center(child: CircularProgressIndicator(),);
              }
            },
          ),
        ],
      ),
    );
  }
}
