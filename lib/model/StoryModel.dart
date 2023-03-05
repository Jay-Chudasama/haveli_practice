import 'Story.dart';

class StoryModel {
  StoryModel(
      {required this.id,
      required this.username,
      required this.story,
      required this.image});

  StoryModel.fromJson(dynamic json) {
    id = json['id'];
    username = json['username'];
    image = json['image'];
    if (json['story'] != null) {
      story = [];
      json['story'].forEach((v) {
        story.add(Story.fromJson(v));
      });
    }
  }

  late int id;
  late String username;
  late String image;
  late List<Story> story;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['id'] = id;
    map['username'] = username;
    if (story != null) {
      map['story'] = story.map((v) => v.toJson()).toList();
    }
    return map;
  }
}
