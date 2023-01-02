import '../models/genres.dart';

class GenreResponses{

  List<Genre> genres =[];
  GenreResponses.formJson(Map<String,dynamic> json){
    json['data'].forEach((genre)=> genres.add(Genre.fromJson(genre)));
  }
}