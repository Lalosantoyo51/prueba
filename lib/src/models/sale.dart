import './produc.model.dart';
import 'cart.model.dart';
class Sale{
  int employee_id;
  int office_id ;
  int place_id;
  int place_user_id;
  List<ProductModel> products = new List();
  String payment_type;
  double lat;
  double lng;


  Sale({this.place_id,this.products,this.payment_type,this.employee_id,
    this.office_id,this.place_user_id,this.lng,this.lat});

  factory Sale.fromJson(Map<String, dynamic> json){
    var product = json['products'];
    List<ProductModel> _product = new List();
    if (product != null) _product = product.map((i) => ProductModel.fromJson(i)).toList();
    return new Sale(
        employee_id : json['employee_id'],
        office_id : json['office_id'],
        place_id : json['place_id'],
        place_user_id : json['place_user_id'],
        products : _product,
        payment_type : json['payment_type']
    );

  }
  Sale.init();
  Map toJson() => {
    'employee_id': this.employee_id,
    'place_id': this.place_id,
    'payment_type': this.payment_type,
    'products': this.products,
    'office_id': this.office_id,
    'latitude' : this.lat,
    'longitude' : this.lng,
    'place_user_id' : this.place_user_id
  };


}