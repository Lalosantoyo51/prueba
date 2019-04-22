import './offices.dart';
import 'dart:convert';


class Building {
  /*final int id;
  final int zone_id;
  final String name;
  final List<Offices> offices;*/
   int id;
   int zone_id;
   String name;
   List<Offices> offices;


  Building({this.id, this.zone_id, this.name, this.offices});

  /*Building.fromJson(Map<String, dynamic> json)
      : name = json['name'],
        id = json['id'],
        zone_id = json['zone_id'],
        offices = (json["offices"] as List).map((i) => new Offices.fromJson(i)).toList();*/

  factory Building.fromJson(Map<String, dynamic> json){
    return new Building(
      name: json['name'],
      id: json['id'],
      zone_id: json['zone_id'],
      offices: (json["offices"] as List).map((i) => new Offices.fromJson(i)).toList()
    );
  }
}