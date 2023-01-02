import 'package:movies_app/models/yser_model.dart';

import '../models/genres.dart';

class UserResponses{
 late UserModel user ;
 late String? token ;

  UserResponses.formJson(Map<String,dynamic> json){
    token = json['data']['token'];
     user = UserModel.fromJson(json['data']['user']);
  }
}