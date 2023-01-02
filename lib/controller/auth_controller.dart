import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:movies_app/controller/base_controller.dart';
import 'package:movies_app/controller/genres_controller.dart';
import 'package:movies_app/responses/user_response.dart';

import '../models/yser_model.dart';
import '../screen/welcome_screen.dart';
import '../services/api.dart';

class AuthController extends GetxController with BaseController{

  final genresController = Get.put(GenresController());
  var isLoggedIn = false.obs;
  var user = UserModel().obs ;

  @override
  void onInit() async {
    //TODO: implement onInit
    await genresController.getGenres();
    redirect();

    super.onInit();
  }

  Future<void> redirect() async {
    var token = await GetStorage().read('login_token');
    if (token != null) {
     getUser();
    }

    Get.off( ()=>WelcomeScreen(), preventDuplicates: false);
  }
  Future<void> Login({required Map<String, dynamic> loginData})async{
    showLoading();
    var response = await Api.Login(loginData: loginData);
    var userResponse = UserResponses.formJson(response.data);
    await GetStorage().write('login_token', userResponse.token);
    user.value= userResponse.user;
    isLoggedIn.value= true ;
    closeLoading();
    Get.offAll(()=>WelcomeScreen());
  }
  Future<void> register({required Map<String, dynamic> registerData})async{
    showLoading();
    var response = await Api.register(registerData: registerData);
    var userResponse = UserResponses.formJson(response.data);
    await GetStorage().write('login_token', userResponse.token);
    user.value= userResponse.user;
    isLoggedIn.value= true ;
    closeLoading();
    Get.offAll(()=>WelcomeScreen());
  }
  Future<void> logout()async{
    await GetStorage().remove('login_token');
    isLoggedIn.value= false ;
    Get.offAll(()=>WelcomeScreen());
  }
  Future<void> getUser()async{
    var response = await Api.getUsers();
    var userResponse = UserResponses.formJson(response.data);
    user.value =userResponse.user;
    isLoggedIn.value = true;
    Get.offAll(()=>WelcomeScreen());
  }

}
