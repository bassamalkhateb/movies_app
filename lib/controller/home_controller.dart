import 'package:get/get.dart';
import 'package:movies_app/models/movies_model.dart';

import '../responses/movies_response.dart';
import '../services/api.dart';

class HomeController extends GetxController{
  var isLoadingNowPlaying=false.obs ;
  var isLoadingUpComing=true.obs ;
  var isLoadingTrending=true.obs ;

  var nowPlayingMovies=<MoviesModel>[];
  var UpComingMovies=<MoviesModel>[];
  var TrendingMovies=<MoviesModel>[];



  @override
  void onInit(){
    getNowPlayingMovies();
    getTrendingMovies();
    getUpComingMovies();
    super.onInit();
  }
  Future<void>  getNowPlayingMovies() async{
    isLoadingNowPlaying.value = true;
    nowPlayingMovies.clear();
    
    var response = await Api.getMovies(type :'now_playing');
    var moviesResponse = MoviesResponse.fromJson(response.data);

    nowPlayingMovies.addAll(moviesResponse.movies);
    isLoadingNowPlaying.value= false;
  }

  Future<void>  getTrendingMovies() async{
    isLoadingNowPlaying.value = true;
    TrendingMovies.clear();

    var response = await Api.getMovies(type: 'popular');
    var moviesResponse = MoviesResponse.fromJson(response.data);

    TrendingMovies.addAll(moviesResponse.movies);
    isLoadingTrending.value= false;
  }
  Future<void>  getUpComingMovies() async{
    isLoadingUpComing.value = true;
    UpComingMovies.clear();

    var response = await Api.getMovies(type: 'upcoming');
    var moviesResponse = MoviesResponse.fromJson(response.data);

    UpComingMovies.addAll(moviesResponse.movies);
    isLoadingUpComing.value= false;
  }
}