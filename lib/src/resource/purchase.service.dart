import 'package:dio/dio.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../models/provision.dart';
import '../utils/enviroment.dart';

class PurchaseService{
  var dio = Dio();
  var url = '${API_URL}offices/1/provisions';

  Future <List<Provision>> getProdcuts() async{
    var prefs = await SharedPreferences.getInstance();
    var token = prefs.getString('access_token');
    List<Provision> list_product;
    Response response;
    response = await dio.get(url, options: RequestOptions(
        headers:{
          'Content-Type': 'application/x-www-form-urlencoded',
          'X-Requested-With': 'XMLHttpRequest',
          'authorization' : 'Bearer $token'
        }
    ));

    var rest = response.data as List;
    list_product = rest.map<Provision>((i) => Provision.fromJson(i)).toList();
    return list_product;
  }

}