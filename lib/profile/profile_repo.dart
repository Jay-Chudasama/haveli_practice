import '../constant.dart';

class ProfileRepo{
  Future<dynamic> postProfileApi(String username)async{
    print(username);
    var response = await DIO.post("$BASE_URL/updateprofile/");
    return response;
  }
}