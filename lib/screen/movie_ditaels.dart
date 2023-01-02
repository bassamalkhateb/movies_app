import 'package:flutter/material.dart';
import 'package:movies_app/controller/auth_controller.dart';
import 'package:movies_app/models/actors_model.dart';
import 'package:get/get.dart';
import 'package:movies_app/screen/actor_screen.dart';
import 'package:movies_app/screen/login_screen.dart';
import '../controller/movies_controller.dart';
import '../models/movies_model.dart';

class MovieDetialScreen extends StatefulWidget {
  final MoviesModel movie;

  MovieDetialScreen({
    Key? key,
    required this.movie,
  }) : super(key: key);

  @override
  State<MovieDetialScreen> createState() => _MovieDetialScreenState();
}

class _MovieDetialScreenState extends State<MovieDetialScreen> {
  final moviesController = Get.find<MoviesController>();
  final authController = Get.find<AuthController>();

  @override
  void initState() {
    // TODO: implement initState
    moviesController.getRelatedMovies(movieId: widget.movie.id);
    moviesController.getActors(movieId: widget.movie.id);
    moviesController.isFavored(movieId: widget.movie.id);

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: CustomScrollView(slivers: [
      SliverAppBar(
        floating: true,
        pinned: true,
        expandedHeight: 280,
        backgroundColor: Colors.amber,
        actions: [
          authController.isLoggedIn.value == false
              ? IconButton(
                  onPressed: () {
                    Get.to(() => LoginScreen(), preventDuplicates: false);
                  },
                  icon: Icon(Icons.favorite_border))
              : moviesController.isLoadoingIsFavored.value == false
                  ? Center(
                      child: Container(
                      padding: EdgeInsets.all(10),
                      height: 20,
                      width: 20,
                      child: CircularProgressIndicator(),
                    ))
                  : IconButton(
                      onPressed: () {}, icon: Icon(Icons.favorite_border))
        ],
        flexibleSpace:
            FlexibleSpaceBar(background: buildTopBanner(movie: widget.movie)),
      ),
      SliverToBoxAdapter(
        child: Obx(() {
          return Container(
            padding: EdgeInsets.all(15),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                buildDiscripion(movie: widget.movie),
                SizedBox(
                  height: 18,
                ),
                buildActors(),
                buildRelatedMovies(),
              ],
            ),
          );
        }),
      ),
    ]));
  }

  Widget buildTopBanner({required MoviesModel movie}) {
    return Stack(
      children: [
        Image.network(
          '${movie.banner}',
          fit: BoxFit.cover,
          width: double.infinity,
          height: double.infinity,
        ),
        Container(
          decoration: BoxDecoration(
            gradient: LinearGradient(
              colors: [
                Colors.black.withOpacity(.2),
                Colors.black.withOpacity(.2),
                Colors.black.withOpacity(.8),
              ],
              begin: Alignment.topCenter,
              end: Alignment.bottomCenter,
            ),
          ),
        ),
        Positioned(
          bottom: 10,
          left: 10,
          right: 10,
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Chip(
                padding: EdgeInsets.all(0),
                backgroundColor: Colors.amber,
                label: Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Icon(Icons.star, color: Colors.black),
                    SizedBox(
                      width: 5,
                    ),
                    Text(
                      '${movie.vote}',
                      style: TextStyle(color: Colors.black),
                    ),
                  ],
                ),
              ),
              Text(
                '${movie.title}',
                style: TextStyle(fontSize: 20),
                maxLines: 2,
                overflow: TextOverflow.ellipsis,
              ),
              SizedBox(
                height: 3,
              ),
              Wrap(
                spacing: 5,
                runSpacing: -8,
                children: [
                  ...movie.genres.map((genre) {
                    return Chip(
                        label: Text(
                      '${genre.name}',
                      style: TextStyle(fontSize: 12),
                    ));
                  })
                ],
              ),
            ],
          ),
        ),
      ],
    );
  }

  Widget buildDiscripion({required MoviesModel movie}) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Details',
          style: TextStyle(fontSize: 20, color: Colors.white),
        ),
        SizedBox(
          height: 10,
        ),
        Text(
          '${movie.description}',
          style: TextStyle(fontSize: 14, color: Colors.grey[400], height: 1.3),
        ),
        SizedBox(
          height: 8,
        ),
        Row(
          children: [
            Container(
              width: 120,
              child: Text(
                'Release date :',
                style: TextStyle(fontSize: 18, color: Colors.white),
              ),
            ),
            SizedBox(
              width: 5,
            ),
            Text(
              '${movie.releaseDate}',
              style: TextStyle(fontSize: 14, color: Colors.grey[400]),
            )
          ],
        ),
        SizedBox(
          height: 10,
        ),
        Row(
          children: [
            Container(
              width: 120,
              child: Text(
                'Vote Count :',
                style: TextStyle(fontSize: 18, color: Colors.white),
              ),
            ),
            SizedBox(
              width: 5,
            ),
            Text(
              '${movie.voteCount}',
              style: TextStyle(fontSize: 14, color: Colors.grey[400]),
            )
          ],
        ),
      ],
    );
  }

  Widget buildActors() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Actors',
          style: TextStyle(fontSize: 20, color: Colors.white),
        ),
        SizedBox(
          height: 10,
        ),
        Container(
          height: 250,
          child: moviesController.isLoadoingActros.value
              ? Center(
                  child: CircularProgressIndicator(),
                )
              : ListView.separated(
                  shrinkWrap: true,
                  scrollDirection: Axis.horizontal,
                  itemBuilder: (context, index) {
                    return buildActorItem(
                        actor: moviesController.actors[index]);
                  },
                  separatorBuilder: (context, index) {
                    return SizedBox(
                      width: 10,
                    );
                  },
                  physics: BouncingScrollPhysics(),
                  itemCount: moviesController.actors.length),
        ),
      ],
    );
  }

  Widget buildActorItem({required ActorsModel actor}) {
    return InkWell(
      onTap: () {
        Get.to(
            () => ActorScreen(
                  actor: actor,
                ),
            preventDuplicates: false);
      },
      child: Container(
        width: 120,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              width: 120,
              height: 180,
              child: Stack(
                children: [
                  Center(
                    child: CircularProgressIndicator(),
                  ),
                  Image.network(
                    '${actor.image}',
                    fit: BoxFit.cover,
                    width: double.infinity,
                    height: double.infinity,
                  ),
                ],
              ),
            ),
            SizedBox(
              height: 10,
            ),
            Text(
              '${actor.name}',
              style: TextStyle(fontSize: 15, color: Colors.white),
              overflow: TextOverflow.ellipsis,
              maxLines: 1,
            ),
          ],
        ),
      ),
    );
  }

  Widget buildRelatedMovies() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Related Movies',
          style: TextStyle(fontSize: 20, color: Colors.white),
        ),
        SizedBox(
          height: 10,
        ),
        Container(
          height: 440,
          width: 350,
          child: moviesController.isLoadoingRelatedMovies.value
              ? Center(
                  child: CircularProgressIndicator(),
                )
              : ListView.separated(
                  shrinkWrap: true,
                  scrollDirection: Axis.horizontal,
                  itemBuilder: (context, index) {
                    int relatedLingth = moviesController.related.length ~/ 2;
                    return Column(
                      children: [
                        buildRelatedItem(
                            related: moviesController.related[index]),
                        SizedBox(
                          height: 10,
                        ),
                        buildRelatedItem(
                            related:
                                moviesController.related[relatedLingth + index])
                      ],
                    );
                  },
                  separatorBuilder: (context, index) {
                    return SizedBox(
                      width: 15,
                    );
                  },
                  physics: BouncingScrollPhysics(),
                  itemCount: moviesController.related.length ~/ 2),
        ),
      ],
    );
  }

  Widget buildRelatedItem({required MoviesModel related}) {
    return InkWell(
      onTap: () {
        Get.to(
            () => MovieDetialScreen(
                  movie: related,
                ),
            preventDuplicates: false);
      },
      child: Container(
        width: 320,
        height: 210,
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              width: 120,
              height: 210,
              child: Stack(
                children: [
                  Center(
                    child: CircularProgressIndicator(),
                  ),
                  Image.network(
                    '${related.poster}',
                    fit: BoxFit.cover,
                    width: double.infinity,
                    height: double.infinity,
                  ),
                ],
              ),
            ),
            SizedBox(
              width: 5,
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
                      '${related.title}',
                      style: TextStyle(fontSize: 15, color: Colors.white),
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                    )),
                    Icon(Icons.star, color: Colors.amber),
                    SizedBox(
                      width: 5,
                    ),
                    Text(
                      '${related.vote}',
                      style: TextStyle(color: Colors.amber),
                    ),
                  ],
                ),
                SizedBox(
                  height: 4,
                ),
                Text(
                  '${related.description}',
                  style: TextStyle(
                      fontSize: 15, color: Colors.grey[400], height: 1.3),
                  maxLines: 3,
                ),
                SizedBox(
                  height: 9,
                ),
                Wrap(
                  spacing: 5,
                  runSpacing: -10,
                  children: [
                    ...related.genres.take(4).map((genre) {
                      return Chip(
                          label: Text(
                        '${genre.name}',
                        style: TextStyle(fontSize: 11),
                      ));
                    })
                  ],
                ),
              ],
            ))
          ],
        ),
      ),
    );
  }
}
