import '../../../constants.dart';

class SearchRepo {
  Future<dynamic> search(String username) async {
    var response = await DIO.get("$BASE_URL/api/search/",
        queryParameters: {'query': username, 'limit': 8}, options: TOKEN_HEDER);
    return response;
  }

  Future<dynamic> loadeMore(String nextUrl) async {
    var response = await DIO.get(nextUrl, options: TOKEN_HEDER);
    return response;
  }
}
