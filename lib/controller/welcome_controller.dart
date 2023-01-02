import 'package:get/get.dart';
import 'package:movies_app/screen/genres_screen.dart';
import 'package:movies_app/screen/home_screen.dart';
import 'package:movies_app/screen/settings_screen.dart';

import '../screen/search_screen.dart';

class WelcomeController extends GetxController{
  var currentIndex = 0.obs;
  var screen=[
    HomeScreen(),
    GenresScreen(),
    SearchScreen(),
    SettingScreen(),

  ];
}