class IsFavoretMovies{
  late bool isFavored ;
  IsFavoretMovies.fromJson(Map<String,dynamic> json){
    isFavored = json['data']['is_favored'];
  }
}