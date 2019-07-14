class LocationModel {
  //latitude
  double lat;

  //longitud
  double lng;
  LocationModel({this.lat,this.lng});

  Map toJson() => {
    'lat' : this.lat,
    'lng' : this.lng,
  };
  factory LocationModel.fromJson(Map<String, dynamic> json){
    return new LocationModel(
      lat : json['lat'],
      lng : json['lng'],
    );
  }

  

}
