import 'package:get/get.dart';
import 'package:movies_app/models/actors_model.dart';
import 'package:movies_app/responses/actors_response.dart';

import '../services/api.dart';

class ActorsController extends GetxController{
  var actors=<ActorsModel>[].obs;

  Future<void>  getGenres({required int movieId}) async{
    var response = await Api.getActors(movieId: movieId);
    var actorsResponse = ActorsResponse.formJson(response.data);
    actors.clear();
    actors.addAll(actorsResponse.actors);
  }
}