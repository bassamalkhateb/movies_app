import '../models/actors_model.dart';

class ActorsResponse{

 late List<ActorsModel> actors =[];
  ActorsResponse.formJson(Map<String,dynamic> json){
    json['data'].forEach((actor)=> actors.add(ActorsModel.fromJson(actor)));
  }
}