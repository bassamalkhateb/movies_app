
import 'package:get/get.dart';
import 'package:movies_app/controller/auth_controller.dart';
import 'package:movies_app/models/actors_model.dart';
import 'package:movies_app/models/movies_model.dart';
import 'package:movies_app/responses/actors_response.dart';
import 'package:movies_app/responses/favoret_response.dart';
import 'package:movies_app/responses/movies_response.dart';
import 'package:movies_app/services/api.dart';

import '../responses/related_response.dart';

class MoviesController extends GetxController {
  final authController = Get.find<AuthController>();
  var isLoading = true.obs;
  var isLoadoingPageation = true.obs;
  var isLoadoingIsFavored = false.obs;
  var isLoadoingActros = true.obs;
  var isLoadoingRelatedMovies = true.obs;

  var is_Favored = false.obs;
  var currentPage = 1.obs;
  var lastPage = 1.obs;
  var movies = <MoviesModel>[];
  var related = <MoviesModel>[];
  var actors = <ActorsModel>[];

  Future<void> getMovies(
      {int page = 1, String? type, int? genreId, int? actorId}) async {
    isLoading.value = true;
    var response = await Api.getMovies(
        type: type, page: page, genreId: genreId, actorId: actorId);
    var movieResponse = MoviesResponse.fromJson(response.data);
    if (page == 1) {
      movies.clear();
    }
    movies.addAll(movieResponse.movies);
    lastPage.value = movieResponse.lastPage;
    isLoadoingPageation.value = false;
  }

  Future<void> getActors({required int movieId}) async {
    isLoadoingActros.value = true;
    var response = await Api.getActors(movieId: movieId);
    var actorsResponse = ActorsResponse.formJson(response.data);
    actors.clear();
    actors.addAll(actorsResponse.actors);
    isLoadoingActros.value = false;
  }

  Future<void> getRelatedMovies({required int movieId}) async {
    isLoadoingRelatedMovies.value = true;
    var response = await Api.getRelatedMovies(movieId: movieId);
    var relatedResponse = RelatedResponse.fromJson(response.data);
    related.clear();
    related.addAll(relatedResponse.relatedMovies);
    isLoadoingRelatedMovies.value = false;
  }

  Future<void> isFavored({required int movieId}) async {
    if (authController.isLoggedIn.value == true) {
      isLoadoingIsFavored.value= true;
      var response =  await Api.IsFavorit(movieId: movieId);
      var isFavoredResponse = IsFavoretMovies.fromJson(response.data);
      is_Favored.value = isFavoredResponse.isFavored;
      isLoadoingIsFavored.value= false;
    }
  }
}
