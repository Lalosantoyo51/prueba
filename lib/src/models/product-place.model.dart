import './produc.model.dart';

class ProductPlace {
   int id;
   int place_id;
   String status;
   int cost;
   ProductModel product;

  ProductPlace({this.id, this.place_id, this.status, this.cost, this.product});

   factory ProductPlace.fromJson(Map<String, dynamic> json) {
     return ProductPlace(
         id : json['id'],
         place_id : json['place_id'],
         status : json['status'],
         cost : json['cost'],
         product : new ProductModel.fromJson(json['product'])
     );
   }

}