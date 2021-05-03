import 'package:flutter/material.dart';
import 'package:movie_recommend/model/movie_response.dart';
import 'package:movie_recommend/repository/repository.dart';
import 'package:rxdart/rxdart.dart';

class MovieBloc{
  final UserRepository _repository = UserRepository();
  final BehaviorSubject<MovieResponse> _subject = BehaviorSubject<MovieResponse>();

  getMovie(int genre,int imdb) async{
    MovieResponse response = await _repository.getMovies(genre, imdb);
    _subject.sink.add(response);
  }
  void drainStream(){
    _subject.value;
  }
  @mustCallSuper
  void dispose() async{
    await _subject.drain();
    _subject.close();
  }

  BehaviorSubject<MovieResponse> get subject => _subject;
}

final movieBloc = MovieBloc();