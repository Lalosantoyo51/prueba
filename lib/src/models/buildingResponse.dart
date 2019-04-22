import './building.model.dart';

class buildingResponse {
  final Building building;

  buildingResponse(this.building);

  buildingResponse.fromJson(Map<String, dynamic> json)
      : building = new Building.fromJson(json);
}