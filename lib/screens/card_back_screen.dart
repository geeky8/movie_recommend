import 'package:eva_icons_flutter/eva_icons_flutter.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:movie_recommend/bloc/movie_bloc.dart';
import 'package:movie_recommend/elements/error.dart';
import 'package:movie_recommend/elements/loading.dart';
import 'package:movie_recommend/model/movie.dart';
import 'package:movie_recommend/model/movie_response.dart';
import 'package:movie_recommend/style/theme.dart' as Style;

class CardBack extends StatefulWidget {
  @override
  _CardBackState createState() => _CardBackState();
}

class _CardBackState extends State<CardBack> {
  @override
  Widget build(BuildContext context) {
    return StreamBuilder<MovieResponse>(
        stream: movieBloc.subject.stream,
        builder: (context, AsyncSnapshot<MovieResponse> snapshot){
          if(snapshot.hasData){
            if(snapshot.data.error != null && snapshot.data.error.length>0){
              return buildError(snapshot.data.error);
            }
            return buildMovie(snapshot.data);
          }else if(snapshot.hasError){
            return buildError(snapshot.error.toString());
          }
          else{
            return buildLoading();
          }
        }
    );
  }
  Widget buildMovie(MovieResponse data){
    MovieModel movie = data.movie;
    return Stack(
      children: [
        Container(
          decoration: BoxDecoration(
            borderRadius: BorderRadius.all(Radius.circular(15)),
            color: Colors.grey[400],
            image: DecorationImage(
              image: NetworkImage("https://img.reelgood.com/content/movie/"+movie.id+"/poster-780.webp"),fit: BoxFit.cover,
            ),
          ),
        ),
        Container(
          decoration: BoxDecoration(
            borderRadius: BorderRadius.all(Radius.circular(15)),
            gradient: LinearGradient(
              begin: Alignment.bottomCenter,
              end: Alignment.topCenter,
              colors: [
                Colors.black.withOpacity(0.9),
                Colors.black.withOpacity(0.0),
              ],
              stops: [
                0.0,
                0.5
              ],
            ),
          ),
        ),
        Positioned(
            top: 10,
            right: 10,
            child: Container(
              padding: EdgeInsets.all(5),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.all(Radius.circular(5)),
                color: Colors.black45,
              ),
              child: Row(
                children: [
                  Icon(
                    FontAwesomeIcons.imdb,
                    color: Style.Colors.imdbColor,
                    size: 30,
                  ),
                  SizedBox(width: 3,),
                  Text(
                    movie.imdbRate.toString(),
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 14,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ],
              ),
            ),
        ),
        Positioned(
          bottom: 50,
          left: 10,
          child: Container(
            width: MediaQuery.of(context).size.width-50,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  movie.title,
                  overflow: TextOverflow.ellipsis,
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                SizedBox(height: 10,),
                Text(
                  movie.overview,
                  overflow: TextOverflow.ellipsis,
                  maxLines: 4,
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 14,
                  ),
                ),
                SizedBox(height: 10,),
                Row(
                  children: [
                    Row(
                      children: [
                        Icon(EvaIcons.clockOutline,color: Colors.white,size: 15,),
                        SizedBox(width: 3,),
                        Text(
                          movie.duration.toString() + "min",
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 12,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ],
                    ),
                    SizedBox(width: 10,),
                    Row(
                      children: [
                        Icon(EvaIcons.clockOutline,color: Colors.white,size: 15,),
                        SizedBox(width: 3,),
                        Text(
                          movie.releaseDate.substring(0,10) + "min",
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 12,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }
}
