import 'package:flutter/material.dart';
import 'package:prue/src/models/area.model.dart';
import 'package:prue/src/models/areaResponse.dart';
import '../../bloc/location.controller.dart';
import '../../bloc/authController.dart';
import '../../models/messageResponse.dart';
import '../../models/areaResponse.dart';
import '../../models/buildingResponse.dart';
import '../../widgets/menu.dart';
import '../../models/user.model.dart';
import '../../models/Userget.dart';
import '../../models/Userget.dart';

class Home extends StatefulWidget {
  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {
  locationController _locationController = new locationController();
  AuthCOntroller _authController = new AuthCOntroller();


  User user = new User();


  String message;
  String area_type;

  final GlobalKey<ScaffoldState> _scaffoldKey = new GlobalKey<ScaffoldState>();

  Future zoneOut() async{
      _scaffoldKey.currentState.showSnackBar(
          SnackBar(content: Text("No se te encuentras en zona burrera"),backgroundColor: Colors.red.shade400,));
  }



  @override
  Widget build(BuildContext context) {
    return new Scaffold(
        key: _scaffoldKey,
        drawer: MainDrawer(),
        appBar: AppBar(
        title: new Text('Inicio'),
        centerTitle: true,
        backgroundColor: Colors.orange,
      ),
      body: Container(
        child: Center(
          child: Column(
            children: <Widget>[
              Text(("$message")),


            ],
          ),
        ),
      ),

      floatingActionButton: new FloatingActionButton(
        onPressed: (){
          print(area_type);
          if(area_type == 'Building'){
            Navigator.of(context).pushNamed('/building');
          }
        },
        tooltip: 'Add Item',
        backgroundColor: Colors.green,
        child: new ListTile(
          title: new  Icon(Icons.shopping_cart),
        ),
      ),

    );
  }

  @override
  void initState() {
    if(user.getName == null){
      _authController.getUser().then((UserModel userModel){
        user.setName = userModel.name;
        user.setGender = userModel.gender;
        user.setBirthday = userModel.birthday;
        user.setPhone = userModel.phone;
        user.setLast_Name = userModel.last_name;
        user.setUser_id = userModel.id;
        print(userModel.gender);
      });
    }
    _locationController.getlocation().then((_){
      print('nose que sea ${_[0]['latitude']}');
      _locationController.areaModel.lat = _[0]['latitude'];
      _locationController.areaModel.lng = _[0]['longitude'];
      _locationController.getCurrentPlace().then((AreaModel areaModel){
        print(areaModel.type);
        area_type = areaModel.type;
        _locationController.setMessage().then((MessageResponse messageModel){
          setState(() {
            message = messageModel.results.message;
          });
        });
      }).catchError((e){
        new Future.delayed(Duration.zero,() {
          zoneOut();
        });

      });
    });
  }

  getUser() async{

  }

  buy(){

  }
}