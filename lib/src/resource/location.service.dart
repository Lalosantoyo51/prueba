import 'dart:async';
import 'package:flutter/services.dart';
import 'package:location/location.dart';
import 'package:prue/src/utils/enviroment.dart';
import '../models/location.model.dart';
import 'package:dio/dio.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../models/messageResponse.dart';
import '../models/areaResponse.dart';
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
          _locationModel.lat = location.latitude;
          _locationModel.lng = location.longitude;
          var prefs = await SharedPreferences.getInstance();
          prefs.setString('lat', location.latitude.toString());
          prefs.setString('lng', location.longitude.toString());
          print(location.latitude.toString());

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

  Future <MessageResponse> getMessage()async{
    var prefs = await SharedPreferences.getInstance();
    var token = prefs.getString('access_token');
    var url = '${API_URL}places/${prefs.getInt('place_id')}/message';
    Response response;
    response = await dio.get(url, options: RequestOptions(
        headers:{
          'Content-Type': 'application/x-www-form-urlencoded',
          'X-Requested-With': 'XMLHttpRequest',
          'authorization' : 'Bearer $token'
        }
    ));
    return MessageResponse.fromJson(response.data);
  }

 Future <AreaResponse> getCurrentPlace() async{
   var prefs = await SharedPreferences.getInstance();
   var token = prefs.getString('access_token');
    var url = '${API_URL}users/current/place';
    var getcurrentFrom = {
      //"lat": prefs.getString('lat'),
      //"lng": prefs.getString('lng'),
      "lat": 21.912089,
      "lng": -102.312895 ,
      //"lat": 21.812089,
      //"lng": -102.432895 ,
    };

    Response response;
    response = await dio.post(url, data:getcurrentFrom , options: RequestOptions(
        headers:{
          'Content-Type': 'application/x-www-form-urlencoded',
          'X-Requested-With': 'XMLHttpRequest',
          'authorization' : 'Bearer $token'
        }
    ));
    prefs.setInt('place_id', response.data['id']);
    return AreaResponse.fromJson(response.data);

 }

  Future <List<Building>> getBuildings(int id)async{
     List<Building> list_buildin;
     var prefs = await SharedPreferences.getInstance();
     var token = prefs.getString('access_token');
    var url = '${API_URL}places/$id}/buildings';
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

  addLocation(){

  }
  getPlaces(){

  }

}