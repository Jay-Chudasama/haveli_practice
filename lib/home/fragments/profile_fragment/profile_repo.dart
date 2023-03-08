import '../../../constants.dart';

class MyProfileRepo {
  Future<dynamic> loadDetails(int? id) async {
    var response = await DIO.get("$BASE_URL/api/userdetails/",
        queryParameters: {"id": id}, options: TOKEN_HEDER);
    return response;
  }

  Future<dynamic> loadPost(int id) async {
    var response = await DIO.get("$BASE_URL/api/userfeeds/",
        queryParameters: {
          "id": id,
          "limit": 8,
        },
        options: TOKEN_HEDER);
    return response;
  }

  Future<dynamic> loadeMore(String nextUrl) async {
    var response = await DIO.get(nextUrl, options: TOKEN_HEDER);
    return response;
  }
}
