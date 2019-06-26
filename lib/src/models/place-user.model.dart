class PlaceUserModel {
  int id;
  String name;

  PlaceUserModel({this.name,this.id});

  factory PlaceUserModel.fromJson(Map<String, dynamic> json) {
    return PlaceUserModel(
      id: json['id'],
      name: json['name']
    );
  }

}