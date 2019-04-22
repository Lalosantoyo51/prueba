class AreaModel{
  int id;
  String type;
  String name;
  String description;
  bool isOnShift;
  String message;

  AreaModel(this.id, this.type, this.name, this.description, this.isOnShift,
      this.message);

  AreaModel.fromJson(Map<String, dynamic> json)
      : id = json["id"],
        type = json["type"],
        name = json["name"],
        description = json['description'],
        message = json["message"];

}