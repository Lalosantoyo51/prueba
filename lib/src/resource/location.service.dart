import 'dart:async';
import 'dart:convert';
import 'package:flutter/services.dart';
import 'package:location/location.dart';
import 'package:prue/src/models/addplace.dart';
import 'package:prue/src/models/area.model.dart';
import 'package:prue/src/utils/enviroment.dart';
import '../models/location.model.dart';
import 'package:dio/dio.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../models/messageResponse.dart';
import '../models/building.model.dart';



class LocationService  {
  var dio = Dio();
  StreamSubscription<LocationData> _locationSubscription;

  Location _locationService  = new Location();
  bool _permission = false;
  String error;

  bool currentWidget = true;
  double lat;
  double lng;
  LocationModel _locationModel = new LocationModel();

  Future getLocation() async {
    final prefs = await SharedPreferences.getInstance();
    await _locationService.changeSettings(accuracy: LocationAccuracy.HIGH);
    var coordinates = [];

    LocationData location;
    // Platform messages may fail, so we use a try/catch PlatformException.
    try {
      bool serviceStatus = await _locationService.serviceEnabled();
      print("Service status: $serviceStatus");
      if (serviceStatus) {
        _permission = await _locationService.requestPermission();
        print("Permission: $_permission");
        if (_permission) {
          location = await _locationService.getLocation();
          var prefs = await SharedPreferences.getInstance();
          prefs.setString('lat', location.latitude.toString());
          prefs.setString('lng', location.longitude.toString());
          print(location.latitude.toString());
          coordinates =[{
            'latitude' : location.latitude,
            'longitude' : location.longitude,
          }];
          print(coordinates);
          return coordinates;
        }
      } else {
        bool serviceStatusResult = await _locationService.requestService();
        print("Service status activated after request: $serviceStatusResult");
        if(serviceStatusResult){
          getLocation();
        }
      }
    } on PlatformException catch (e) {
      print(e);
      if (e.code == 'PERMISSION_DENIED') {
        error = e.message;
      } else if (e.code == 'SERVICE_STATUS_ERROR') {
        error = e.message;
      }
      location = null;
    }
  }

  Future <MessageResponse> getMessage(int id)async{
    var prefs = await SharedPreferences.getInstance();
    var token = prefs.getString('access_token');
    var url = '${API_URL}places/$id/message';
    print(url);
    Response response;
    try {
    response = await dio.get(url, options: RequestOptions(
        headers:{
          'Content-Type': 'application/x-www-form-urlencoded',
          'X-Requested-With': 'XMLHttpRequest',
          'authorization' : 'Bearer $token'
        }
    ));
    if(response.data.toString().length > 0){
      return MessageResponse.fromJson(response.data);
    }
    }on DioError catch (e) {
      print(e.response.data);
      return MessageResponse.fromJson(e.response.data);

    }

  }

 Future <AreaModel> getCurrentPlace(AreaModel areaModel) async{
    print(API_URL);
   var prefs = await SharedPreferences.getInstance();
   var _data =  {"coordinate" : json.encode(areaModel)};
   var token = prefs.getString('access_token');
    var url = '${API_URL}users/current/place';
    print('location ${_data}');
    Response response;
    try {
    response = await dio.post(url, data:_data , options: RequestOptions(
        headers:{
          'Content-Type': 'application/x-www-form-urlencoded',
          'X-Requested-With': 'XMLHttpRequest',
          'authorization' : 'Bearer $token'
        }
    ));
    return AreaModel.fromJson(response.data);
    }on DioError catch (e) {
      print(e.response.data);
      return AreaModel.fromJson(e.response.data);
    }
 }

  Future <List<Building>> getBuildings(int id)async{
     List<Building> list_buildin;
     var prefs = await SharedPreferences.getInstance();
     var token = prefs.getString('access_token');
    var url = '${API_URL}places/$id/buildings';
    print(url);
      Response response;
      response = await dio.get(url, options: RequestOptions(
          headers:{
            'Content-Type': 'application/x-www-form-urlencoded',
            'X-Requested-With': 'XMLHttpRequest',
            'authorization' : 'Bearer $token'
          }
      ));
      var rest = response.data as List;

     list_buildin = rest.map<Building>((json) => Building.fromJson(json)).toList();
     return list_buildin;




  }

  Future <AddPlace> addPlace(AddPlace addPlace) async{
    print(API_URL);
    var _data = json.encode(addPlace);
    var prefs = await SharedPreferences.getInstance();
    var token = prefs.getString('access_token');
    var url = '${API_URL}users/current/places';
    print(_data);
    print('location ${_data}');
    Response response;
    try {
      response = await dio.post(url, data:_data , options: RequestOptions(
          headers:{
            'Content-Type': 'application/x-www-form-urlencoded',
            'X-Requested-With': 'XMLHttpRequest',
            'authorization' : 'Bearer $token'
          }
      ));
      return AddPlace.fromJson(response.data);
    }on DioError catch (e) {
      print(e.response.data);

    }
  }
  Future <List<AddPlace>> getPlaces() async{
    List<AddPlace> list_places;
    print(API_URL);
    var prefs = await SharedPreferences.getInstance();
    var token = prefs.getString('access_token');
    var url = '${API_URL}users/current/places';
    Response response;
    try {
      response = await dio.get(url, options: RequestOptions(
          headers:{
            'Content-Type': 'application/x-www-form-urlencoded',
            'X-Requested-With': 'XMLHttpRequest',
            'authorization' : 'Bearer $token'
          }
      ));
      var rest = response.data as List;
      list_places = rest.map<AddPlace>((json) => AddPlace.fromJson(json)).toList();
      return list_places;
    }on DioError catch (e) {
      print(e.response.data);

    }
  }

}