import './produc.model.dart';

class ProductPlace {
  final int id;
  final int place_id;
  final String status;
  final int cost;
  final ProductModel product;

  ProductPlace({this.id, this.place_id, this.status, this.cost, this.product});

  ProductPlace.fromJson(Map<String, dynamic> json):
      id = json['id'],
      place_id = json['place_id'],
      status = json['status'],
      cost = json['cost'],
      product = new ProductModel.fromJson(json['product']);

}