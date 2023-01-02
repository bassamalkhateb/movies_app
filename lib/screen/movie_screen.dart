import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:movies_app/models/movies_model.dart';
import 'package:movies_app/screen/movie_ditaels.dart';

import '../controller/movies_controller.dart';

class MoviesScreen extends StatefulWidget {
  final String? type;
  final int? genreId;

  MoviesScreen({Key? key, this.type, this.genreId}) : super(key: key);

  @override
  State<MoviesScreen> createState() => _MoviesScreenState();
}

class _MoviesScreenState extends State<MoviesScreen> {
  final moviesController = Get.find<MoviesController>();
  final scrollController = ScrollController();

  @override
  void initState() {
    moviesController.getMovies(genreId: widget.genreId, type: widget.type);
    scrollController.addListener(() {
      var sControllerOffset = scrollController.offset;
      var sControllerMax = scrollController.position.maxScrollExtent - 100;
      var isLoadingPagination = moviesController.isLoadoingPageation.value;
      var hasMorePages =
          moviesController.currentPage.value < moviesController.lastPage.value;
      if (sControllerOffset > sControllerMax &&
          isLoadingPagination == false &&
          hasMorePages) {
        moviesController.isLoadoingPageation.value = true;
        moviesController.currentPage.value++;
        moviesController.getMovies(
            page: moviesController.currentPage.value,
            type: widget.type,
            genreId: widget.genreId);
      }
    });
    super.initState();
  }

  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.grey[700],
          title: Text(
            'Movies',
          ),
        ),
        body: Obx(() {
          return moviesController.isLoading.value == false
              ? Center(
                  child: CircularProgressIndicator(),
                )
              : Container(
                  padding: const EdgeInsets.all(10),
                  child: SingleChildScrollView(
                    controller: scrollController,
                    child: Column(
                      children: [
                        ListView.separated(
                          shrinkWrap: true,
                          itemBuilder: (context, index) {
                            return buildMovieItem(
                                moviesController.movies[index]);
                          },
                          separatorBuilder: (context, index) {
                            return SizedBox(
                              height: 15,
                            );
                          },
                          itemCount: moviesController.movies.length,
                          scrollDirection: Axis.vertical,
                          physics: NeverScrollableScrollPhysics(),
                        ),
                        Visibility(
                            visible: moviesController.isLoadoingPageation.value,
                            child: Container(
                              padding: EdgeInsets.all(5),
                              width: 40,
                              height: 40,
                              child: Center(
                                child: CircularProgressIndicator(),
                              ),
                            ))
                      ],
                    ),
                  ),
                );
        }));
  }

  Widget buildMovieItem(MoviesModel movie) {
    return InkWell(
      onTap: (){
        Get.to(()=>MovieDetialScreen(movie: movie,),preventDuplicates: false);
      },
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            width: 130,
            height: 200,
            child: Stack(alignment: Alignment.bottomCenter, children: [
              Center(
                child: CircularProgressIndicator(),
              ),
              Image.network(
                '${movie.poster}',
                width: double.infinity,
                height: double.infinity,
                fit: BoxFit.cover,
              ),
            ]),
          ),
          SizedBox(
            width: 10,
          ),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                Row(
                  children: [
                    Expanded(
                        child: Text(
                      '${movie.title}',
                      style: TextStyle(fontSize: 20),
                      overflow: TextOverflow.ellipsis,
                      maxLines: 2,
                    )),
                    Row(
                      children: [
                        Icon(
                          Icons.star,
                          color: Colors.amber,
                        ),
                        Text(
                          '${movie.vote}',
                          style: TextStyle(fontSize: 18),
                        ),
                      ],
                    )
                  ],
                ),
                SizedBox(
                  height: 5,
                ),
                Text(
                  '${movie.description}',
                  style: TextStyle(fontSize: 17, color: Colors.grey),
                  maxLines: 7,
                  overflow: TextOverflow.ellipsis,
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
