import 'package:prue/src/models/sale.dart';

import './offices.dart';
import './produc.model.dart';

class CartModel {
  static int seller_id;
  static int total;
  static int totalproduct;
  static int place_id;
  static int latitude;
  static int longitude;
  static int places_user_id;
  static int user_id;
  static String payment;
  static String areaType;
  static Offices offices = new Offices();
  static List<ProductModel> products = new List<ProductModel>();



  //ejemplo
  static String hola;
  void set sethola(String value){
    hola = value;
  }
  String get gethola{
    return hola;
  }
  //fin

  void set setSeller_id(int value){
    seller_id = value;
  }
  int get getSeller_id{
    return seller_id;
  }

  void set setPlace_id(int value){
    place_id = value;
  }
  int get getPlace_id{
    return place_id;
  }

  void set setLatitude(int value){
    latitude = value;
  }
  int get getLatitude{
    return latitude;
  }
  void set setLongitude(int value){
    longitude = value;
  }
  int get getLongitude{
    return longitude;
  }
  void set setPlaces_user_id(int value){
    places_user_id = value;
  }
  int get getPlaces_user_id{
    return places_user_id;
  }
  void set setUser_id(int value){
    user_id = value;
  }
  int get getUser_id{
    return user_id;
  }
  void set setTotal(int value){
    user_id = value;
  }
  int get getTotal{
    return user_id;
  }
  void set setTotalproduct(int value){
    totalproduct = value;
  }
  int get getTotalproduct{
    return total;
  }
  void set setPayment(String value){
    payment = value;
  }
  String get getPayment{
    return payment;
  }
  void set setAreaType(String value){
    areaType = value;
  }
  String get getAreaType{
    return areaType;
  }
  void set setOffice_id(int value){
    offices.id = value ;
  }

  int get getOffice_id{
    return offices.id;
  }
  void set setProducts(List<ProductModel> products2){
    products = products2;
  }
  List<ProductModel> get getProduct{
    return products;
  }


  Sale get cart{
    var sale = new Sale();
    sale.place_id = CartModel.place_id;
    sale.employee_id = CartModel.seller_id;
    sale.office_id = CartModel.offices.id;
    sale.payment_type = "Cash";
    sale.products = this.getPurchasedProducts();
    return sale;
  }
   getPurchasedProducts(){
    CartModel.products.forEach((product){
      //print('model cart ${product.name}');
    });
    return CartModel.products;
   }



  Map CreatePurchase() => {
    'employee_id': CartModel.seller_id,
    'place_id': CartModel.place_id,
    'payment_type': "Cash",
    'office': CartModel.offices.id,
    'user_id': CartModel.user_id,
  };


}