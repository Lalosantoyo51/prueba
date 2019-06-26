import 'package:dio/dio.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../models/provision.dart';
import '../utils/enviroment.dart';
import '../models/purchase.model.dart';


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

  Future <List<PurchaseModel>> history(int numberpage)async{
    var prefs = await SharedPreferences.getInstance();
    var token = prefs.getString('access_token');
    var url = '${API_URL}users/current/purchases?page=$numberpage';
    Response response;
    response = await dio.get(url, options: RequestOptions(
        headers:{
          'Content-Type': 'application/x-www-form-urlencoded',
          'X-Requested-With': 'XMLHttpRequest',
          'authorization' : 'Bearer $token'
        }
    ));
    print(response.data['data'][0]);
    var data =
    (response.data['data'] as List).map((data) => PurchaseModel.fromJson(data)).toList();
    return data;




  }


}