class UserModel{
  late int id;
  late String name ;
  late String email ;
  late String image ;
  UserModel();
  UserModel.fromJson(Map<String, dynamic> json){
    id = json['id'];
    name = json['name'];
    email = json['email'];
    image = json['image'];

  }
}