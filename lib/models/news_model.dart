class NewsModel{
  late String title,details,image;
  late int id;

  NewsModel.fromJson(dynamic json){
    title = json['title'];
    image = json['image'];
    id = json['id'];
    details = json['details'];
  }

}