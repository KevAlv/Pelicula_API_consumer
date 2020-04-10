import 'package:flutter_swiper/flutter_swiper.dart';
import 'package:flutter/material.dart';
import 'package:peliculas_app/scr/models/pelicula_model.dart';

class CardSwiper extends StatelessWidget {
  final List<Pelicula> peliculas;
  CardSwiper({@required this.peliculas});

  @override
  Widget build(BuildContext context) {
    final _screenSize = MediaQuery.of(context).size;

    return Container(
      padding: EdgeInsets.only(top: 20),
      child: Swiper(
        itemBuilder: (BuildContext context, int index) {
          return ClipRRect(
              borderRadius: BorderRadius.circular(10.0),
              child: FadeInImage(
                placeholder: AssetImage('assets/img/loading.gif'),
                image: NetworkImage(peliculas[index].getPosterImg()),
                fit: BoxFit.cover,
              ));
        },
        layout: SwiperLayout.STACK,
        itemWidth: _screenSize.width * 0.6,
        itemHeight: _screenSize.height * 0.5,
        itemCount:peliculas.length,
      ),
    );
  }
}
