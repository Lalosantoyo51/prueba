class Offices {
   int id;
   int building_id;
   String name;
   String status;


  Offices({this.id, this.building_id, this.name, this.status});

  Offices.fromJson(Map<String, dynamic> json)
      : id = json["id"],
        name = json["name"],
        building_id = json["building_id"],
        status = json["status"];

}