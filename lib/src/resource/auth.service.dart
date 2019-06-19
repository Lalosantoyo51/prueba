import 'dart:convert';
import 'package:dio/dio.dart' ;
import 'package:prue/src/models/sign-in.dart';
import 'package:prue/src/models/sign-up.dart';
import 'package:prue/src/models/user.model.dart';
import 'package:prue/src/utils/enviroment.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:http/http.dart' as http;
import '../models/Userget.dart';

class AuthService {
  var dio = Dio();
  UserModel user = new UserModel();
  User userG = new User();

  showDownloadProgress(received, total) {
    if (total != -1) {
      print((received / total * 100).toStringAsFixed(0) + '%');
    }
  }


  Future<SignInModel> login(SignInModel signIn) async {
    var _data = json.encode(signIn);
    dio.options.baseUrl = SERVER_URL;
    dio.interceptors.add(LogInterceptor(requestBody: true));
    Response response;
    response = await dio.post(
        "oauth/token", data: _data, onSendProgress: showDownloadProgress
    );
    return SignInModel.fromJson(response.data);
  }

  Future<SignUpModel> signUp(SignUpModel signUpModel,) async {
    var url = '${API_URL}users';
    var _data = json.encode(signUpModel);
    Response response;
    response = await dio.post(url, data: _data);
    return SignUpModel.fromJson(response.data);
  }

  Future signUpFacebook(String name,
      String last_name,
      String email,
      String phone,
      int facebook_id,
      String birthday,
      String gender,) async {
    var url = '${API_URL}users/facebook';
    var signIn = {
      "name": "$name",
      "last_name": "$last_name",
      "email": "$email",
      "phone": "$phone",
      "facebook_id": "$facebook_id",
      "birthday": "$birthday",
      "gender": "$gender",
    };
    Response response;
    response = await dio.post(url, data: signIn);
    print(response.data.toString());
    var prefs = await SharedPreferences.getInstance();
    Map content = json.decode(response.toString());
    prefs.setString('access_token', content['accessToken']);
    print(prefs.getString('access_token'));
  }






  Future reset(String email) async {
    var url = '${API_URL}passwords/email';
    var resetPassword = {
      "email": "$email",
    };
    Response response;
    return await dio.post(url, data: resetPassword);
    print(response.data.toString());
  }

  signOut() async {
    var prefs = await SharedPreferences.getInstance();
    prefs.clear();
  }

  Future <UserModel> getUser() async {
    var prefs = await SharedPreferences.getInstance();
    var token = prefs.getString('access_token');
    var url = '${API_URL}users/current';
    Response response;
    response = await dio.get(url, options: RequestOptions(
        headers: {
          'Content-Type': 'application/x-www-form-urlencoded',
          'X-Requested-With': 'XMLHttpRequest',
          'authorization': 'Bearer $token'
        }
    ));
    print(response.data);
    return UserModel.fromJson(response.data);
  }

  Future <UserModel> changePassword(UserModel userModel) async {
    var _data = json.encode(userModel);
    var prefs = await SharedPreferences.getInstance();
    var token = prefs.getString('access_token');
    var url = '${API_URL}users/current/password';
    Response response;
    response= await dio.put(url, data: _data, options: RequestOptions(
        headers: {
          'Content-Type': 'application/x-www-form-urlencoded',
          'X-Requested-With': 'XMLHttpRequest',
          'authorization': 'Bearer $token'
        }));
    return UserModel.fromJson(response.data);
  }

  Future verifycode(int code) async {
    var url = '${API_URL}users/current/code';
    var Formcode = {
      "code": "$code",
    };
    var prefs = await SharedPreferences.getInstance();
    var token = prefs.getString('access_token');
    return await dio.post(url, data: Formcode, options: RequestOptions(
        headers: {
          'Content-Type': 'application/x-www-form-urlencoded',
          'X-Requested-With': 'XMLHttpRequest',
          'authorization': 'Bearer $token'
        })
    );
  }

  Future resendCode() async {
    var prefs = await SharedPreferences.getInstance();
    var token = prefs.getString('access_token');
    var url = '${API_URL}users/current/code';
    return await dio.get(url, options: RequestOptions(
        headers: {
          'Content-Type': 'application/x-www-form-urlencoded',
          'X-Requested-With': 'XMLHttpRequest',
          'authorization': 'Bearer $token'
        })
    );
  }

  Future signInWithFacebook(String fb_token, int facebook_id) async {
    dio.options.baseUrl = SERVER_URL;
    dio.interceptors.add(LogInterceptor(requestBody: true));
    var loginData = {
      "grant_type": "facebook_login",
      "scope": "*",
      "client_id": "${CLIENT_ID}",
      "client_secret": "${Client_SECRET}",
      "fb_token": "$fb_token",
      "facebook_id": "$facebook_id"
    };
    print(loginData);
    Response response;
    response = await dio.post(
        "${API_URL}token/facebook", data: loginData,
        onSendProgress: showDownloadProgress
    ).catchError((error){
      print(error);
    }).then((_){
      print(_);
    });
    var prefs = await SharedPreferences.getInstance();
    Map content = json.decode(response.toString());
    prefs.setString('access_token', content['access_token']);
  }

}
