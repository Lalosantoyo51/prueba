import './product-place.model.dart';

class SaleDetailsModel {
  int id;
  int sale_id;
  int quantity;
  int cost;
  String deleted_at;
  String created_at;
  String update_at;
  ProductPlace productPlace;

  SaleDetailsModel({this.id,this.productPlace,this.created_at,this.quantity,
    this.cost,this.deleted_at,this.sale_id,this.update_at});

  factory SaleDetailsModel.fromJson(Map<String, dynamic> json) {
    return SaleDetailsModel(
        id: json['id'],
        sale_id: json['sale_id'],
        quantity: json['quantity'],
        cost: json['cost'],
        deleted_at: json['deleted_at'],
        created_at: json['created_at'],
        update_at: json['update_at'],
        productPlace: new ProductPlace.fromJson(json['product_place'])
    );
  }

}