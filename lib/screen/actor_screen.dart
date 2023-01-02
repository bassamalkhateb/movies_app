import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:movies_app/controller/actor_controller.dart';
import 'package:movies_app/controller/movies_controller.dart';
import 'package:movies_app/models/actors_model.dart';
import 'package:get/get.dart';
import 'package:movies_app/widgets/movie_item.dart';

class ActorScreen extends StatefulWidget {
  final ActorsModel actor;

  ActorScreen({Key? key, required this.actor}) : super(key: key);

  @override
  State<ActorScreen> createState() => _ActorScreenState();
}

class _ActorScreenState extends State<ActorScreen> {
  //final actorCntroller = Get.put(MoviesController());
  final actorCntroller = Get.find<MoviesController>();
  final scrollController = ScrollController();

  @override
  void initState() {
    // TODO: implement initState
    actorCntroller.getMovies(actorId: widget.actor.id);
    scrollController.addListener(() {
      var sControllerOffset = scrollController.offset;
      var sControllerMax = scrollController.position.maxScrollExtent - 100;
      var isLoadingPagination = actorCntroller.isLoadoingPageation.value;
      var hasMorePages =
          actorCntroller.currentPage.value < actorCntroller.lastPage.value;
      if (sControllerOffset > sControllerMax &&
          isLoadingPagination == false &&
          hasMorePages) {
        actorCntroller.isLoadoingPageation.value = true;
        actorCntroller.currentPage.value++;
        actorCntroller.getMovies(actorId: widget.actor.id);
      }
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Obx(() {
        return ListView(
          children: [
            buildTopBanner(actor: widget.actor),
            SizedBox(
              height: 10,
            ),
            buildMoviesList(),
          ],
        );
      }),
    );
  }

  Widget buildTopBanner({required ActorsModel actor}) {
    return Container(
      height: 300,
      child: Stack(
        children: [
          Image.network(
            '${actor.image}',
            width: double.infinity,
            height: double.infinity,
            fit: BoxFit.cover,
          ),
          BackdropFilter(
            filter: ImageFilter.blur(sigmaX: 15, sigmaY: 15),
            child: Container(
              color: Colors.black.withOpacity(0),
            ),
          ),
          Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Stack(
                  alignment: Alignment.center,
                  children: [
                    CircleAvatar(
                      backgroundColor: Colors.amber,
                      radius: 65,
                      child: null,
                    ),
                    CircleAvatar(
                        backgroundImage: NetworkImage('${actor.image}'),
                        radius: 60,
                        child: null),
                  ],
                ),
                SizedBox(
                  height: 10,
                ),
                Text(
                  '${actor.name}',
                  style: TextStyle(fontSize: 20),
                ),
              ],
            ),
          ),
          Positioned(
              top: 10,
              left: 1,
              child: IconButton(
                  onPressed: () {
                    Get.back();
                  },
                  icon: Icon(Icons.arrow_back_ios)))
        ],
      ),
    );
  }

  Widget buildMoviesList() {
    return Container(
      padding: EdgeInsets.symmetric(vertical: 10, horizontal: 10),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'Movies',
            style: TextStyle(fontSize: 20),
          ),
          SizedBox(height: 8,),
          actorCntroller.isLoading.value == false
              ? Container(
                  height: Get.height / 2,
                  child: Center(
                    child: CircularProgressIndicator(),
                  ),
                )
              : Column(
                  children: [
                    ListView.separated(
                        controller: scrollController,
                        shrinkWrap: true,
                        physics: NeverScrollableScrollPhysics(),
                        scrollDirection: Axis.vertical,
                        itemBuilder: (context, index) {
                          return MovieItemWidget(
                            movie: actorCntroller.movies[index],
                          );
                        },
                        separatorBuilder: (context, index) {
                          return SizedBox(
                            height: 15,
                          );
                        },
                        itemCount: actorCntroller.movies.length),
                    Visibility(
                      visible: actorCntroller.isLoadoingPageation.value,
                      child: Container(
                        padding: EdgeInsets.all(5),
                        width: 40,
                        height: 40,
                        child: Center(
                          child: CircularProgressIndicator(),
                        ),
                      ),
                    ),
                  ],
          ),
        ],
      ),
    );
  }
}
