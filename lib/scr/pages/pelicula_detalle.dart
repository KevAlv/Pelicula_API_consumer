
import 'package:flutter/material.dart';
import 'package:peliculas_app/scr/models/pelicula_model.dart';
import 'package:peliculas_app/scr/models/actores_model.dart';
import 'package:peliculas_app/scr/providers/peliculas_provider.dart';

class PeliculaDetalle extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final Pelicula pelicula = ModalRoute.of(context).settings.arguments;
    return Scaffold(
      body: CustomScrollView(
        slivers: <Widget>[
          _crearAppBar(pelicula),
          SliverList(
              delegate: SliverChildListDelegate([
            SizedBox(height: 10),
            _posterTitulo(pelicula, context),
            _descripcion(pelicula),
            _descripcion(pelicula),
            _descripcion(pelicula),
            _getCasting(pelicula)
          ]))
        ],
      ),
    );
  }

  Widget _crearAppBar(Pelicula pelicula) {
    return SliverAppBar(
      elevation: 2.0,
      backgroundColor: Colors.black,
      expandedHeight: 200.0,
      floating: false,
      pinned: true,
      flexibleSpace: FlexibleSpaceBar(
        centerTitle: true,
        title: Text(
          pelicula.title,
          style: TextStyle(fontSize: 16.0),
        ),
        background: FadeInImage(
            // fadeInDuration: Duration(microseconds: 200),
            fit: BoxFit.cover,
            placeholder: AssetImage('assets/img/loading.gif'),
            image: NetworkImage(pelicula.getBackgroundImage())),
      ),
    );
  }

  _posterTitulo(Pelicula pelicula, BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 20),
      child: Row(
        children: <Widget>[
          ClipRRect(
              borderRadius: BorderRadius.circular(20.0),
              child: Image(
                image: NetworkImage(pelicula.getPosterImg()),
                height: 150,
              )),
          SizedBox(width: 20),
          Flexible(
              child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Text(pelicula.title,
                  style: Theme.of(context).textTheme.title,
                  overflow: TextOverflow.ellipsis),
              Text(
                pelicula.originalTitle,
                style: Theme.of(context).textTheme.subhead,
                overflow: TextOverflow.ellipsis,
              ),
              Row(
                children: <Widget>[
                  Icon(Icons.star_border),
                  Text(pelicula.voteAverage.toString())
                ],
              )
            ],
          ))
        ],
      ),
    );
  }

  _descripcion(Pelicula pelicula) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 20, vertical: 20),
      child: Text(
        pelicula.overview,
        textAlign: TextAlign.justify,
      ),
    );
  }

  _getCasting(Pelicula pelicula) {
    final peliProvider = new PeliculasProvider();
    return FutureBuilder(
      future: peliProvider.getActores(pelicula.id.toString()),
      builder: (context, AsyncSnapshot<List> snapshot) {
        if (snapshot.hasData) {
          return crearActoresPageView(snapshot.data);
        } else {
          return Center(child: CircularProgressIndicator());
        }
      },
    );
  }
}

crearActoresPageView(List actores) {
  return SizedBox(
    height: 200,
    child: PageView.builder(
      controller: PageController(
        viewportFraction: 0.3,
        initialPage: 1,
      ),
      itemCount: actores.length,
      itemBuilder: (context, i) {
        return _actorTarjeta(actores[i]);
      },
    ),
  );
}

Widget _actorTarjeta(Actor actor) {
  return Container(
    child: Column(
      children: <Widget>[
        ClipRRect(
          borderRadius: BorderRadius.circular(20.0),
          child: FadeInImage(
              fit: BoxFit.cover,
              height: 150.0,
              placeholder: AssetImage('assets/img/no-image.jpg'),
              image: NetworkImage(actor.getPhoto())),
        ),
        Text(
          actor.name,
          overflow: TextOverflow.ellipsis,
        )
      ],
    ),
  );
}
