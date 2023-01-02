class ActorsModel{
  late int id;
  late String name ;
  late String image;
  ActorsModel.fromJson(Map<String, dynamic> json){
    id = json['id'];
    name = json['name'];
    image = json['image'];
  }
}