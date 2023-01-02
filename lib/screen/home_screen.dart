import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:movies_app/controller/home_controller.dart';
import 'package:movies_app/controller/movies_controller.dart';
import 'package:movies_app/screen/movie_ditaels.dart';
import 'package:movies_app/screen/movie_screen.dart';

import '../models/movies_model.dart';

class HomeScreen extends StatelessWidget {
  final homeController = Get.put(HomeController());
  final moviesController = Get.find<MoviesController>();

  @override
  Widget build(BuildContext context) {
    return Obx(() {
      return Scaffold(
          body: SafeArea(
              child: Container(
        padding: EdgeInsets.all(10),
        child: SingleChildScrollView(
          child: Column(
            children: [
              buildLandsCapeMovieList(
                  isLoading: homeController.isLoadingNowPlaying.value,
                  movies: homeController.nowPlayingMovies),
              SizedBox(
                height: 20,
              ),
              buildPortraitMovieList(
                  type: 'popular',
                  title: "Popular Movies",
                  isLoading: homeController.isLoadingTrending.value,
                  movies: homeController.TrendingMovies),
              SizedBox(
                height: 20,
              ),
              buildPortraitMovieList(
                  type: 'upcoming',
                  title: "Upcoming Movies",
                  isLoading: homeController.isLoadingUpComing.value,
                  movies: homeController.UpComingMovies),
              SizedBox(
                height: 15,
              ),
            ],
          ),
        ),
      )));
    });
  }

  Widget buildLandsCapeMovieList(
      {required bool isLoading, required List<MoviesModel> movies}) {
    return Column(
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              'Now Playing',
              style: TextStyle(fontSize: 20),
            ),
            InkWell(
              onTap: () {
                Get.to(
                    () => MoviesScreen(
                          type: 'now_playing',
                        ),
                    preventDuplicates: false);
              },
              child: Text(
                'show All ...',
                style: TextStyle(color: Colors.amber),
              ),
            ),
          ],
        ),
        SizedBox(
          height: 10,
        ),
        Container(
            height: 255,
            child: isLoading == true
                ? Center(
                    child: CircularProgressIndicator(),
                  )
                : ListView.separated(
                    physics: BouncingScrollPhysics(),
                    itemBuilder: (context, index) {
                      return buildLandsCapsCardMovies(movie: movies[index]);
                    },
                    separatorBuilder: (context, index) {
                      return SizedBox(
                        width: 10,
                      );
                    },
                    itemCount: movies.length,
                    scrollDirection: Axis.horizontal,
                  ))
      ],
    );
  }

  Widget buildLandsCapsCardMovies({required MoviesModel movie}) {
    return InkWell(
      onTap: () {
        Get.to(() => MovieDetialScreen(movie: movie), preventDuplicates: false);
      },
      child: Container(
        height: 255,
        width: 340,
        child: Card(
          shape:
              RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
          clipBehavior: Clip.antiAliasWithSaveLayer,
          child: Column(
            children: [
              Container(
                width: double.infinity,
                height: 200,
                child: Stack(
                  children: [
                    Center(
                      child: CircularProgressIndicator(),
                    ),
                    Image.network(
                      '${movie.banner}',
                      width: double.infinity,
                      fit: BoxFit.cover,
                    ),
                  ],
                ),
              ),
              Container(
                  padding: EdgeInsets.all(5),
                  child: Row(
                    children: [
                      Expanded(
                          child: Text(
                        '${movie.title}',
                        style: TextStyle(
                          fontSize: 20,
                          overflow: TextOverflow.ellipsis,
                        ),
                        // maxLines: 1,
                      )),
                      SizedBox(
                        width: 10,
                      ),
                      Row(
                        children: [
                          Icon(
                            Icons.star,
                            color: Colors.amber,
                            size: 22,
                          ),
                          Text(
                            '${movie.vote}',
                            style: TextStyle(fontSize: 18),
                          ),
                        ],
                      )
                    ],
                  )),
            ],
          ),
        ),
      ),
    );
  }

  Widget buildPortraitMovieList(
      {required bool isLoading,
      required String type,
      required List<MoviesModel> movies,
      required String title}) {
    return Column(
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              title,
              style: TextStyle(fontSize: 20),
            ),
            InkWell(
              onTap: () {
                Get.to(
                    () => MoviesScreen(
                          type: type,
                        ),
                    preventDuplicates: false);
              },
              child: Text(
                'show All ...',
                style: TextStyle(color: Colors.amber),
              ),
            )
          ],
        ),
        SizedBox(
          height: 15,
        ),
        Container(
            height: 248,
            child: isLoading == true
                ? Center(
                    child: CircularProgressIndicator(),
                  )
                : ListView.separated(
                    physics: BouncingScrollPhysics(),
                    itemBuilder: (context, index) {
                      return buildPortraitCardMovies(movie: movies[index]);
                    },
                    separatorBuilder: (context, index) {
                      return SizedBox(
                        width: 10,
                      );
                    },
                    itemCount: movies.length,
                    scrollDirection: Axis.horizontal,
                  ))
      ],
    );
  }

  Widget buildPortraitCardMovies({required MoviesModel movie}) {
    return InkWell(
      onTap: () {
        Get.to(() => MovieDetialScreen(movie: movie), preventDuplicates: false);
      },
      child: Container(
        height: double.infinity,
        width: 140,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              width: double.infinity,
              height: 220,
              child: Stack(
                children: [
                  Center(
                    child: CircularProgressIndicator(),
                  ),
                  Image.network(
                    '${movie.poster}',
                    width: double.infinity,
                    fit: BoxFit.cover,
                    height: double.infinity,
                  ),
                ],
              ),
            ),
            SizedBox(
              height: 7,
            ),
            Text(
              '${movie.title}',
              style: TextStyle(
                fontSize: 18,
                overflow: TextOverflow.ellipsis,
              ),
              // maxLines: 1,
            ),
          ],
        ),
      ),
    );
  }
}
