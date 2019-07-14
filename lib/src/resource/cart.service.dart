import 'package:prue/src/models/offices.dart';
import 'package:prue/src/models/provisionDetails.dart';
import 'package:prue/src/models/sale.dart';


class CartService {
  static int seller_id;
  static int place_id;
  static int latitude;
  static int longitude;
  static int places_user_id;
  static int user_id;
  static String payment;
  static String areaType;
  static Offices offices;
  static List<ProvisionDetails> provisions;

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
  void set setOffices(Offices office){
    offices = office;
  }
  
  Offices get getOffices{
    return offices;
  }  
  void set setProduct(List<ProvisionDetails> provision){
    provisions = provision;
  }

  List<ProvisionDetails> get getProduct{
    return provisions;
  }
  
  Sale get cart{
    var sale = new Sale();
    sale.employee_id = this.getSeller_id;
    sale.place_id = this.getPlace_id;
    sale.office_id = 1;
    sale.payment_type = "Cash";
    sale.products = this.getPurchasedProducts();
    return sale;
  }

  getPurchasedProducts(){
    List<ProvisionDetails> provision = [];
    
    for(int i = 0; i < getProduct.length; i++){
      if(getProduct[i].quantity >0){
        provision.add(getProduct[i]);
      }
      return provision;
    }
    
  }

}