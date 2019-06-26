import 'package:prue/src/models/purchase_building.dart';

class OficcesPurchase {
  int id;
  String name;
  int building_id;
  BuildingPurchase buildin;

  OficcesPurchase({this.name,this.id,this.building_id,this.buildin});


  factory OficcesPurchase.fromJson(Map<String, dynamic> json) {
    return OficcesPurchase(
        id: json['id'],
        name: json['name'],
        buildin: BuildingPurchase.fromJson(json['building'])
    );
  }

}