class MsgModel {
  late String msg, created_at;
  late int id, user, toChat;
  late bool readed;

  MsgModel.fromJson(dynamic json) {
    id = json['id'];
    msg = json['message'];
    readed = json['readed'];
    toChat = json['toChat'];
    user = json['user'];
    created_at = json['created_at'];
  }
}
