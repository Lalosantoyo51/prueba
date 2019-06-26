class PlaceModel {
  int id;
  String address;
  String name;
  int lat;
  int lng;

  PlaceModel({this.name,this.id,this.lng,this.lat,this.address});

  factory PlaceModel.fromJson(Map<String, dynamic> json) {
    return PlaceModel(
        id: json['id'],
        name: json['name']
    );
  }

}