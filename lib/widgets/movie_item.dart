import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:movies_app/models/movies_model.dart';

import '../screen/movie_ditaels.dart';
class MovieItemWidget extends StatelessWidget {
  final MoviesModel movie ;
   MovieItemWidget({Key? key, required this.movie}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return    InkWell(
        onTap: (){
          Get.to(()=>MovieDetialScreen(movie: movie),preventDuplicates: false);
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

