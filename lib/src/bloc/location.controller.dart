import 'package:prue/src/models/area.model.dart';
import 'package:prue/src/models/messageResponse.dart';
import 'package:prue/src/models/areaResponse.dart';
import 'package:prue/src/models/buildingResponse.dart';
import '../resource/location.service.dart';
import 'package:dio/dio.dart';
import '../models/building.model.dart';

class locationController {
  final LocationService _locationService = new LocationService();
  String error;
  AreaModel areaModel = new AreaModel();


  Future getlocation() async{
     return _locationService.getLocation();
  }

  Future <AreaModel> getCurrentPlace() async {
    return _locationService.getCurrentPlace(areaModel);

  }

  Future<MessageResponse> setMessage() {
    return _locationService.getMessage();

  }
  Future <List<Building>> getBuilding() {
    return _locationService.getBuildings(1);

  }
}

