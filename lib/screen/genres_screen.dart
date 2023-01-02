import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:movies_app/controller/genres_controller.dart';
import 'package:movies_app/screen/movie_screen.dart';

class GenresScreen extends StatelessWidget {
  GenresScreen({Key? key}) : super(key: key);

  // final controller = Get.lazyPut(() => GenresController());
  GenresController genresController = Get.find();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Container(
            padding: EdgeInsets.all(15),
            child: GridView.builder(
                itemCount: genresController.genres.length,
                physics: BouncingScrollPhysics(),
                gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 2,
                  childAspectRatio: 3 / 2,
                  crossAxisSpacing: 5,
                  mainAxisSpacing: 5,
                ),
                itemBuilder: (context, index) {
                  return InkWell(
                    onTap: (){
                      Get.to(()=>MoviesScreen(
                        genreId: genresController.genres[index].id,

                      ), preventDuplicates: false);
                    },
                      child: Card(
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10)),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(
                          '${genresController.genres[index].name}',
                          style: TextStyle(fontSize: 18),
                        ),
                        SizedBox(
                          height: 10,
                        ),
                        Text(
                          '${genresController.genres[index].moviesCount}',
                          style: TextStyle(fontSize: 19),
                        ),
                      ],
                    ),
                  ));
                })));
  }
}
