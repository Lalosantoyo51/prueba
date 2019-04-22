import '../models/product-place.model.dart';

class Provision {
   int id;
   int provision_id;
   int product_place_id;
   int quantity;
   int availables;
   ProductPlace product_place;

  Provision({this.id, this.provision_id, this.product_place_id, this.quantity,
    this.availables,this.product_place});

  factory Provision.fromJson(Map<String, dynamic> json){
    return new Provision(
        id : json['id'],
        product_place_id : json['product_place_id'],
        provision_id : json['provision_id'],
        quantity : json['quantity'],
        availables : json['availables'],
        product_place : new ProductPlace.fromJson(json['product_place'])
    );
  }

}