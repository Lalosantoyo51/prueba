import 'package:flutter/material.dart';
import 'package:prue/src/bloc/location.controller.dart';
import 'package:prue/src/models/building.model.dart';
import 'package:prue/src/models/buildingResponse.dart';
import 'package:prue/src/models/offices.dart';
import '../../bloc/purchaseController.dart';
import '../../models/cart.model.dart';
import '../../resource/cart.service.dart';

class Buildind extends StatefulWidget {
  @override
  _BuildindState createState() => _BuildindState();
}

class _BuildindState extends State<Buildind> {
  locationController _locationController = new locationController();
  PurchaseController _purchaseController = new PurchaseController();
  CartService _cartService = new CartService();
  List<DropdownMenuItem<String>> listBuiling = [];
  List<DropdownMenuItem<String>> listoffices = [];
  String selected_buildign = null;
  String selected_offices = null;
  List <Building> buildings;
  List<Offices> offices;

  @override
  void initState() {
    _locationController.getBuilding().then((List<Building> buildings ){
      this.buildings = buildings;
      setState(() {
        listBuiling = [];
        selected_buildign;
        this.buildings.forEach((building){
          listBuiling.add(new DropdownMenuItem(
              child: new Text('${building.name}') ,
              value: building.id.toString()
          ));
        });
      });
    });

  }
  goToNext(){
    //Navigator.of(context).pushNamed('/products');
    _cartService.setSeller_id =1;
    _cartService.setPlace_id =1;

  }

  getOffices(int buildingId){
    return this.buildings.where((building)=> building.id == buildingId).toList()[0].offices;
  }

  @override
  Widget build(BuildContext context) {
    return new Scaffold(
      appBar: AppBar(
        title: new Text('inicio'),
        centerTitle: true,
        backgroundColor: Colors.orange,
      ),
      body: Container(
        child: new Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            mainAxisSize: MainAxisSize.max,
            children: <Widget>[
              DropdownButton(
                value: selected_buildign,
                items: listBuiling,
                hint: new Row(
                  children: <Widget>[
                    new Icon(Icons.business,),
                    new Text("Edificio"),
                  ],
                ),
                onChanged: (value){
                  setState(() {
                    selected_offices = null;
                    selected_buildign = value;
                    this.offices = this.getOffices(int.parse(value));
                    this.listoffices.clear();
                    selected_offices;
                    this.offices.forEach((office){
                      listoffices.add(new DropdownMenuItem(
                          child: new Text('${office.name}') ,
                          value: office.id.toString()
                      ));
                    });
                  });
                },
              ),
              DropdownButton(
                value: selected_offices,
                items: listoffices,
                hint: new Row(
                  children: <Widget>[
                    new Icon(Icons.business,),
                    new Text("Oficina"),
                  ],
                ),
                onChanged: (value){
                  selected_offices = value;
                  setState(() {

                  });
                },
              ),
              new Padding(
                padding: const EdgeInsets.only(bottom: 100.0),
              ),
              new Container(
                child: new MaterialButton(
                  onPressed: goToNext,
                  height: 50.0,
                  color: Colors.orangeAccent,
                  splashColor: Colors.deepOrangeAccent,
                  textColor: Colors.white,
                  child: new Icon(Icons.chevron_right,size: 50, color: Colors.white,),
                  shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
                ),
              ),

            ],

          ),
        ),
      )
    );
  }
}



