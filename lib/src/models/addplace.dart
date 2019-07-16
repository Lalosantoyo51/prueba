class AddPlace {
  int id;
  int user_id;
  String address;
  String name;
  double lat;
  double lng;
  AddPlace({this.id,this.user_id,this.address,this.name,this.lat,this.lng});
  factory AddPlace.fromJson(Map<String, dynamic> json){
    return new AddPlace(
        id : json['id'],
        user_id: json['user_id'],
        name : json['name'],
        lat : json['latitude'],
        lng: json['longitude'],
        address : json['address']
    );

  }

  AddPlace.init();
  Map toJson() => {
    'latitude': this.lat,
    'longitude': this.lng,
    'name': this.name,
    'user_id': this.user_id,
    'address': this.address,
  };


}