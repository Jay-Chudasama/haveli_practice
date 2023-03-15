import 'Items.dart';
import 'Extras.dart';

class MenuModel {
  MenuModel({
     required this.id,
     required this.banner,
     required this.type,
     required this.closing,
     required this.items,
     required this.extras,});

  MenuModel.fromJson(dynamic json) {
    id = json['id'];
    banner = json['banner'];
    type = json['type'];
    closing = json['closing'];
    if (json['items'] != null) {
      items = [];
      json['items'].forEach((v) {
        items.add(Items.fromJson(v));
      });
    }
    if (json['extras'] != null) {
      extras = [];
      json['extras'].forEach((v) {
        extras.add(Extras.fromJson(v));
      });
    }
  }
  late int id;
  late String? banner;
  late String? type;
  late String? closing;
  late List<Items> items;
  late List<Extras> extras;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['id'] = id;
    map['banner'] = banner;
    map['type'] = type;
    map['closing'] = closing;
    if (items != null) {
      map['items'] = items.map((v) => v.toJson()).toList();
    }
    if (extras != null) {
      map['extras'] = extras.map((v) => v.toJson()).toList();
    }
    return map;
  }

}