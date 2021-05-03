import 'package:dio/dio.dart';
import 'package:movie_recommend/model/movie_response.dart';

class UserRepository{
  static String movieUrl = "https://api.reelgood.com/v3.0/content/random";
  final Dio _dio = Dio();

  Future<MovieResponse> getMovies(int genre,int minImdb) async{
    var params =  {
      "availability": "onAnySource",
      "content_kind": "movie",
      "genre": genre,
      "minimum_imdb": minImdb,
      "sources": "netflix",
      "region": "us",
      "nocache": "true"
    };
    try{
      Response response = await _dio.get(movieUrl,queryParameters: params);
      return MovieResponse.fromJson(response.data);
    }
    catch(error,stacktrace){
      print("Stacktrace: $stacktrace");
      return MovieResponse.withError("$error");
    }
  }
}