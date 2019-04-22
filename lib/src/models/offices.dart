class Offices {
  final int id;
  final int building_id;
  final String name;
  final String status;


  Offices({this.id, this.building_id, this.name, this.status});

  Offices.fromJson(Map<String, dynamic> json)
      : id = json["id"],
        name = json["name"],
        building_id = json["building_id"],
        status = json["status"];

}