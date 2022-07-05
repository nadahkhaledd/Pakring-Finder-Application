
import 'package:park_locator/Shared/Constants.dart';
import 'package:shared_preferences/shared_preferences.dart';

class userPrefrance{
  static SharedPreferences sharedPreferences;
  static init( ) async{
    sharedPreferences=await SharedPreferences.getInstance();
  }

 static void setToken(String token) {
    sharedPreferences.setString(Constants.ACCESS_TOKEN, token);
}
static String getToken()
 {
   return  sharedPreferences.getString(Constants.ACCESS_TOKEN);
 }
}