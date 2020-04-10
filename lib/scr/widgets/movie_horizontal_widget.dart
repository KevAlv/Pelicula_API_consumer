import 'package:flutter/material.dart';
import 'package:peliculas_app/scr/models/pelicula_model.dart';

class MovieHorizontal extends StatelessWidget {
  final List<Pelicula> peliculas;
  Function siguientePagina;
  MovieHorizontal({@required this.peliculas,@required this.siguientePagina });
  final _pageController = new PageController(
    initialPage: 1,
    viewportFraction: 0.3,
  );
  @override
  Widget build(BuildContext context) {
    final _screenSize = MediaQuery.of(context).size;
    _pageController.addListener((){
        if(_pageController.position.pixels>=_pageController.position.maxScrollExtent-200){
           siguientePagina();
        }
    });
    return Container(
      height: _screenSize.height * 0.3,
      child: PageView.builder(
          pageSnapping: false,
          controller: _pageController,
          // children: _tarjetas(context)),
          itemCount: peliculas.length,
          itemBuilder:(context,i){
            return _crearTarjeta(context,peliculas[i]);
          }
      )
    );
  }

  Widget _crearTarjeta(BuildContext context,Pelicula pelicula){
    final tarjeta =  Container(
        margin: EdgeInsets.only(right: 15.0),
        child: Column(
          children: <Widget>[
            ClipRRect(
              borderRadius: BorderRadius.circular(10.0),
              child: FadeInImage(
                placeholder: AssetImage('assets/img/no-image.jpg'),
                image: NetworkImage(pelicula.getPosterImg()),
                fit: BoxFit.cover,
                height: 160.0,
              ),
            ),
            SizedBox(),
            Text(
              pelicula.title,
              overflow: TextOverflow.ellipsis,
              style: Theme.of(context).textTheme.caption,
            )
          ],
        ),
      );

      return GestureDetector(
        onTap: (){
            Navigator.pushNamed(context,'detalle',arguments: pelicula);
        },
        child: tarjeta,
      );
  }

  List<Widget> _tarjetas(BuildContext context) {
    return peliculas.map((pelicula) {
      return _crearTarjeta(context,pelicula);
    }).toList();
  }
}
