import 'dart:core';
import '../utils/enviroment.dart';
class SignInModel{
  String grant_type = "password";
  int client_id = CLIENT_ID;
  String client_secret = Client_SECRET;
  String scope = "*";
  String username;
  String password;
  String push_token;
}