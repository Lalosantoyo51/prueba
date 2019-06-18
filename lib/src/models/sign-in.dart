import 'dart:core';
import '../utils/enviroment.dart';

class SignInModel {
  String grant_type = "password";
  int client_id = CLIENT_ID;
  String client_secret = Client_SECRET;
  String scope = "*";
  String username;
  String password;
  String push_token;
  String token_type;
  String access_token;
  String refresh_token;
  int expires_in;

  SignInModel(
      {this.grant_type,
      this.client_id,
      this.client_secret,
      this.scope,
      this.username,
      this.password,
      this.push_token,
      this.token_type,
      this.access_token,
      this.expires_in,
      this.refresh_token});

  SignInModel.init();
  Map toJson() => {
        'grant_type': 'password',
        'client_id': CLIENT_ID,
        'client_secret': Client_SECRET,
        'origin_log': "*",
        'username': this.username,
        'password': this.password,
        'push_token': this.push_token,
      };

  factory SignInModel.fromJson(Map<String, dynamic> json) {
    return SignInModel(
        token_type: json['token_type'],
        expires_in: json['expires_in'],
        access_token: json['access_token'],
        refresh_token: json['refresh_token'],
    );
  }
}
