import '../models/movies_model.dart';

class RelatedResponse{
  List<MoviesModel> relatedMovies =[];
  RelatedResponse.fromJson(Map<String,dynamic> json){
    json['data'].forEach((related)=>relatedMovies.add(MoviesModel.fromJson(related)));
  }
}