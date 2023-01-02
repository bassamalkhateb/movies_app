import '../models/movies_model.dart';

class MoviesResponse{
  List<MoviesModel> movies =[];
  late int lastPage ;
  MoviesResponse.fromJson(Map<String,dynamic> json){
    json['data']['movies']['data'].forEach((movie)=>movies.add(MoviesModel.fromJson(movie)));
    lastPage= json['data']['movies']['meta']['last_page'];
  }
}