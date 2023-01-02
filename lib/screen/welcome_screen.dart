import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:movies_app/controller/welcome_controller.dart';

class WelcomeScreen extends StatelessWidget {
  WelcomeScreen({Key? key}) : super(key: key);
  final welcomeController = Get.put(WelcomeController());

  @override
  Widget build(BuildContext context) {
    return Obx(() {
      return Scaffold(
        body: welcomeController.screen[welcomeController.currentIndex.value],
        bottomNavigationBar: BottomNavigationBar(
          type: BottomNavigationBarType.fixed,
          currentIndex: welcomeController.currentIndex.value,
          items: [
            BottomNavigationBarItem(icon: Icon(Icons.home), label: 'Home'),
            BottomNavigationBarItem(icon: Icon(Icons.category), label: 'Genres'),
            BottomNavigationBarItem(icon: Icon(Icons.search), label: 'Search'),
            BottomNavigationBarItem(icon: Icon(Icons.person), label: 'Setting'),
          ],
          onTap: (index) {
            welcomeController.currentIndex.value = index;
          },
        ),
      );
    });
  }
}
