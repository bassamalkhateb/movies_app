import 'package:flutter/material.dart';
import 'package:movies_app/controller/auth_controller.dart';
import 'package:movies_app/screen/login_screen.dart';
import 'package:movies_app/screen/registar_screen.dart';
import 'package:get/get.dart';
import 'package:movies_app/widgets/bottom_widgwt.dart';

import 'favorite_screen.dart';

class SettingScreen extends StatelessWidget {
  SettingScreen({Key? key}) : super(key: key);
  final authController = Get.find<AuthController>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: ListView(
      children: [buildTopBanner(), buildSettingItem()],
    ));
  }

  Widget buildTopBanner() {
    return Container(
      height: 250,
      color: Colors.amber,
      child: Center(
        child: Text(
          'Settings',
          style: TextStyle(fontSize: 20, color: Colors.black),
        ),
      ),
    );
  }

  Widget buildSettingItem() {
    return Container(
        padding: EdgeInsets.all(10),
        child: authController.isLoggedIn == true
            ? Column(
                children: [
                  ListTile(
                    leading: Icon(Icons.favorite),
                    title: Text(
                      'Favorite Movies',
                      style: TextStyle(
                        fontSize: 20,
                      ),
                    ),
                    onTap: () {
                      Get.to(() => FovoriteScreen(), preventDuplicates: false);
                    },
                  ),
                  ListTile(
                    leading: Icon(Icons.logout),
                    title: Text(
                      'Logout',
                      style: TextStyle(
                        fontSize: 20,
                      ),
                    ),
                    onTap: () {
                      Get.dialog(
                        Dialog(
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(15)
                          ),
                          child: Container(
                            padding: EdgeInsets.all(15),
                              height: 150,
                              width: 300,
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Text('Confirm Logout',style: TextStyle(fontSize: 20),),
                                  SizedBox(height: 15,),
                                  Row(
                                    children: [
                                      Expanded(child: BottomWidget(titelButton: 'Cancel' ,onPressed: (){Get.back();},),),
                                      SizedBox(width: 2,),
                                      Expanded(child: BottomWidget(titelButton: 'Logout', onPressed: (){authController.logout();},),)
                                    ],
                                  )
                                ],
                              )),
                        ),
                      );
                    },
                  )
                ],
              )
            : Column(
                children: [
                  ListTile(
                    leading: Icon(Icons.person),
                    title: Text(
                      'Login',
                      style: TextStyle(
                        fontSize: 20,
                      ),
                    ),
                    onTap: () {
                      Get.to(() => LoginScreen(), preventDuplicates: false);
                    },
                  ),
                  ListTile(
                    leading: Icon(Icons.person_add),
                    title: Text(
                      'Register',
                      style: TextStyle(
                        fontSize: 20,
                      ),
                    ),
                    onTap: () {
                      Get.to(() => RegistarScreen(), preventDuplicates: false);
                    },
                  )
                ],
              ));
  }
}
