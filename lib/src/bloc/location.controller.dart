import 'package:prue/src/models/messageResponse.dart';
import 'package:prue/src/models/areaResponse.dart';
import 'package:prue/src/models/buildingResponse.dart';
import '../resource/location.service.dart';
import 'package:dio/dio.dart';
import '../models/building.model.dart';

class locationController {
  final LocationService _locationService = new LocationService();
  String error;


  Future getlocation() async{
     return _locationService.getLocation();
  }

  Future <AreaResponse> getCurrentPlace() async {
    return _locationService.getCurrentPlace();

  }

  Future<MessageResponse> setMessage() {
    return _locationService.getMessage();

  }
  Future <List<Building>> getBuilding() {
    return _locationService.getBuildings(1);

  }
}

