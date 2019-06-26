class BuildingPurchase {
  int id;
  String name;

  BuildingPurchase({this.id,this.name});

  factory BuildingPurchase.fromJson(Map<String, dynamic> json) {
    return BuildingPurchase(
        id: json['id'],
        name: json['name']
    );
  }


}