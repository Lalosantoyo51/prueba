import 'package:shared_preferences/shared_preferences.dart';
class TokenModel{
  static String acces_token;

  String get token{
    return acces_token;
  }
  void setToken(String value){
    acces_token = value;
  }

}