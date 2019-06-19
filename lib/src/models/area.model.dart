import 'location.model.dart';

class AreaModel implements LocationModel{
  int id;
  String type;
  String name;
  String description;
  bool isOnShift;
  String message;

  AreaModel({this.id, this.type, this.name, this.description, this.isOnShift,
    this.message});

  Map toJson() => {
    'lat': this.lat,
    'lng': this.lng,
  };

  AreaModel.fromJson(Map<String, dynamic> json)
      : id = json["id"],
        type = json["type"],
        name = json["name"],
        description = json['description'],
        message = json["message"],
        isOnShift = json['isOnShift'];

  @override
  double lat;

  @override
  double lng;

}