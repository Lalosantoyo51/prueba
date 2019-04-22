import 'package:dio/dio.dart';
import 'package:shared_preferences/shared_preferences.dart';

class AuthInterceptor {

  intercept()async{
    var prefs = await SharedPreferences.getInstance();
    var token = prefs.getString('access_token');
    print(token);
    var dio = Dio();
    dio.interceptors.add(InterceptorsWrapper(
      onRequest: (RequestOptions option){
        return option;
      },
      onResponse: (Response response){
        response.headers.set('Content-Type', 'application/x-www-form-urlencoded');
        response.headers.set('X-Requested-With', 'XMLHttpRequest');
        response.headers.set('Authorization', 'Bearer' + token);
        return response;
      }
    ));
  }
}