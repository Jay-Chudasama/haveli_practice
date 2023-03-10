import '../../../constants.dart';

class NotificationRepo {
  Future<dynamic> load() async {
    var response = await DIO.get("$BASE_URL/api/notifications/",
        queryParameters: { 'limit': 8}, options: TOKEN_HEDER);
    return response;
  }

  Future<dynamic> loadeMore(String nextUrl) async {
    var response = await DIO.get(nextUrl, options: TOKEN_HEDER);
    return response;
  }
}
