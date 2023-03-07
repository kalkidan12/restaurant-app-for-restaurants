import 'package:http/http.dart' as http;
import 'package:restaurantapp/api/config.dart';
import 'package:restaurantapp/api/models/user_model.dart';

class ApiService {
  Future<UserLogin> loginUser() async {
    var url = Uri.parse(ApiConstants.BASE_URL + ApiConstants.USER_LOGIN);
    var response = await http.post(url);
    if (response.statusCode == 200) {
      UserLogin _model = userLoginFromJson(response.body);
      return _model;
    } else {
      return userLoginFromJson(
          {"referesh_token": "", "access_token": ""} as String);
    }
  }
}
