import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:flutter/services.dart';
import 'package:movies_app/controller/movies_controller.dart';
import 'package:movies_app/screen/spash_screen.dart';
import 'package:movies_app/services/api.dart';

void main() async {
  await GetStorage.init();
  Api.initializeInterceptors();
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    Get.create(() => MoviesController());
    return GetMaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
          appBarTheme: AppBarTheme(
              //backgroundColor: Colors.grey,
              systemOverlayStyle: SystemUiOverlayStyle(
                  statusBarColor: Colors.black,
                  statusBarIconBrightness: Brightness.light),
              titleTextStyle: TextStyle(color: Colors.white, fontSize: 20),
              iconTheme: IconThemeData(color: Colors.black),
              color: Colors.blue),
          colorScheme: ColorScheme.fromSwatch()
              .copyWith(primary: Colors.amber, secondary: Colors.amber)),
      darkTheme: ThemeData(
        appBarTheme: AppBarTheme(
            centerTitle: true,

            systemOverlayStyle: SystemUiOverlayStyle(
                statusBarColor: Colors.black,
                statusBarIconBrightness: Brightness.light),
            titleTextStyle: TextStyle(color: Colors.white, fontSize: 20),
            iconTheme: IconThemeData(color: Colors.white),
            color: Colors.blue),
        colorScheme: ColorScheme.fromSwatch().copyWith(
            primary: Colors.amber,
            secondary: Colors.amber,
            brightness: Brightness.dark),
      ),
      themeMode: ThemeMode.dark,
      locale: Locale('en'),
      fallbackLocale: Locale('en'),
      defaultTransition: Transition.fade,
      transitionDuration: Duration(milliseconds: 100),
      home: SplashScreen(),
    );
  }
}
