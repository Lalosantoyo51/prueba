import 'package:prue/src/models/addplace.dart';
import 'package:prue/src/models/area.model.dart';
import 'package:prue/src/models/cart.model.dart';
import 'package:prue/src/models/messageResponse.dart';
import 'package:prue/src/models/buildingResponse.dart';
import '../resource/location.service.dart';
import 'package:dio/dio.dart';
import '../models/building.model.dart';

class locationController {
  final LocationService _locationService = new LocationService();
  String error;
  AreaModel areaModel = new AreaModel();
  CartModel cart = new CartModel();
  AddPlace addPlace = new AddPlace();

  Future getlocation() async{
     return _locationService.getLocation();
  }

  Future <AreaModel> getCurrentPlace() async {
    return _locationService.getCurrentPlace(areaModel);
  }

  Future<MessageResponse> setMessage() {
    return _locationService.getMessage(areaModel.id);

  }
  Future <List<Building>> getBuilding() {
    return _locationService.getBuildings(cart.getPlace_id);
  }
  Future <AddPlace> addPlaces() {
    return _locationService.addPlace(addPlace);
  }
  Future <List<AddPlace>> getPlaces() {
    return _locationService.getPlaces();
  }
}

