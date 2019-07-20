import 'package:dio/dio.dart';
import 'package:prue/src/models/product-place.model.dart';
import 'package:prue/src/models/sale.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../models/provisionDetails.dart';
import '../utils/enviroment.dart';
import '../models/purchase.model.dart';
import 'dart:convert';


class PurchaseService{
  var dio = Dio();

  Future <List<ProvisionDetails>> getProdcuts(int office_id) async{
    var url = '${API_URL}offices/$office_id/provisions';
    var prefs = await SharedPreferences.getInstance();
    var token = prefs.getString('access_token');
    List<ProvisionDetails> list_product;
    print(url);
    Response response;
    try{
      response = await dio.get(url, options: RequestOptions(
          headers:{
            'Content-Type': 'application/x-www-form-urlencoded',
            'X-Requested-With': 'XMLHttpRequest',
            'authorization' : 'Bearer $token'
          }
      ));

      var rest = response.data as List;
      list_product = rest.map<ProvisionDetails>((i) => ProvisionDetails.fromJson(i)).toList();
      return list_product;
    }on DioError catch(e){
      print('sdsadsa');
    }
  }
  Future <List<ProvisionDetails>> getProdcutsStreet(int place_id) async{
    var url = '${API_URL}street/$place_id/provisions';
    var prefs = await SharedPreferences.getInstance();
    var token = prefs.getString('access_token');
    List<ProvisionDetails> list_product;
    print(url);
    Response response;
    try{
      response = await dio.get(url, options: RequestOptions(
          headers:{
            'Content-Type': 'application/x-www-form-urlencoded',
            'X-Requested-With': 'XMLHttpRequest',
            'authorization' : 'Bearer $token'
          }
      ));
      print(response.data);
      var rest = response.data as List;
      list_product = rest.map<ProvisionDetails>((i) => ProvisionDetails.fromJson(i)).toList();
      return list_product;
    }on DioError catch(e){
      print('sdsadsa');
    }
  }

  Future <Sale> createSale(Sale sale) async{
    var url = '${API_URL}sales';
    var _data = json.encode(sale);
    var prefs = await SharedPreferences.getInstance();
    var token = prefs.getString('access_token');
    print('servicio ${_data}');
    Response response;
    try {
      response = await dio.post(url,data: _data, options: RequestOptions(
          headers:{
            'Content-Type': 'application/x-www-form-urlencoded',
            'X-Requested-With': 'XMLHttpRequest',
            'authorization' : 'Bearer $token'
          }
      ));
      print(response.data);
      return Sale.fromJson(response.data);
    } on DioError catch(e){
      print(e.response.data);
    }
  }

  Future <List<PurchaseModel>> history(int numberpage)async{
    var prefs = await SharedPreferences.getInstance();
    var token = prefs.getString('access_token');
    var url = '${API_URL}users/current/purchases?page=$numberpage';
    Response response;
    try {
      response = await dio.get(url, options: RequestOptions(
          headers: {
            'Content-Type': 'application/x-www-form-urlencoded',
            'X-Requested-With': 'XMLHttpRequest',
            'authorization': 'Bearer $token'
          }
      ));
      var data =
      (response.data['data'] as List).map((data) =>
          PurchaseModel.fromJson(data)).toList();
      return data;
    }on DioError catch(e){
      print(e.response.data);
    }
  }

  Future <List<PurchaseModel>> getOrders()async{
    var prefs = await SharedPreferences.getInstance();
    var token = prefs.getString('access_token');
      var url = '${API_URL}users/current/orders';
    print(url);
    Response response;
    response = await dio.get(url, options: RequestOptions(
        headers:{
          'Content-Type': 'application/x-www-form-urlencoded',
          'X-Requested-With': 'XMLHttpRequest',
          'authorization' : 'Bearer $token'
        }
    ));
    var data =
    (response.data as List).map((data) => PurchaseModel.fromJson(data)).toList();
    return data;
  }

  Future  CancelOrder (int id,String comment)async{
    var Datacomment={
      'comment' : '$comment'
    };
    print(comment);
    print("$id");
    var prefs = await SharedPreferences.getInstance();
    var token = prefs.getString('access_token');
    var url = '${API_URL}sales/$id';
    Response response;
    response = await dio.put(url,data: Datacomment, options: RequestOptions(
        headers:{
          'Content-Type': 'application/x-www-form-urlencoded',
          'X-Requested-With': 'XMLHttpRequest',
          'authorization' : 'Bearer $token'
        }
    ));
    print(response.data[0]);
    return response.data;
  }


}