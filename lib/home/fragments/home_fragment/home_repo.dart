import 'package:haveliapp/constants.dart';

class HomeRepo {
  Future<dynamic> loadStories() async {
    var response = await DIO.get("$BASE_URL/api/stories/",
        queryParameters: {"limit": 8}, options: TOKEN_HEDER);
    return response;
  }
}
