import 'package:prue/src/models/provision.dart';

import '../models/product-place.model.dart';

class ProvisionDetails {
   int id;
   int provision_id;
   int product_place_id;
   int quantity;
   int availables;
   Provision provision;

   ProductPlace product_place;

   ProvisionDetails({this.id, this.provision_id, this.product_place_id, this.quantity,
    this.availables,this.product_place,this.provision});

  factory ProvisionDetails.fromJson(Map<String, dynamic> json){
    return new ProvisionDetails(
        id : json['id'],
        product_place_id : json['product_place_id'],
        provision_id : json['provision_id'],
        quantity : json['quantity'],
        availables : json['availables'],
        product_place : new ProductPlace.fromJson(json['product_place']),
        provision: new Provision.fromJson(json['provision'])
    );
  }

}