import './offices.dart';
import 'dart:convert';


class Building {

   int id;
   int zone_id;
   String name;
   List<Offices> offices;


  Building({this.id, this.zone_id, this.name, this.offices});


  factory Building.fromJson(Map<String, dynamic> json){
    return new Building(
      name: json['name'],
      id: json['id'],
      zone_id: json['zone_id'],
      offices: (json["offices"] as List).map((i) => new Offices.fromJson(i)).toList()
    );
  }
}