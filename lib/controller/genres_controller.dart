import 'package:get/get.dart';
import 'package:movies_app/models/genres.dart';
import 'package:movies_app/responses/genres_response.dart';

import '../services/api.dart';

class GenresController extends GetxController{
  var genres=<Genre>[].obs;

  Future<void>  getGenres() async{
    var response = await Api.getGenres();
    var genreResponse = GenreResponses.formJson(response.data);
    genres.clear();
    genres.addAll(genreResponse.genres);
  }
}
