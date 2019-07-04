import 'package:flutter/material.dart';
import 'package:prue/src/bloc/location.controller.dart';
import 'package:prue/src/models/building.model.dart';
import 'package:prue/src/models/buildingResponse.dart';
import 'package:prue/src/models/offices.dart';
import 'package:prue/src/models/provision.dart';
import 'package:prue/src/widgets/stepperW.dart';
import '../../bloc/purchaseController.dart';
import '../../models/cart.model.dart';
import '../../resource/cart.service.dart';

class Buildind extends StatefulWidget {
  @override
  _BuildindState createState() => _BuildindState();
}

class _BuildindState extends State<Buildind> {

  locationController _locationController = new locationController();
  CartService _cartService = new CartService();
  List<DropdownMenuItem<String>> listBuiling = [];
  List<DropdownMenuItem<String>> listoffices = [];
  String selected_buildign = null;
  String selected_offices = null;
  List <Building> buildings;
  List<Offices> offices;
  List<Provision> provisions = new List();
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
    Navigator.of(context).pushNamed('/products');
    _cartService.setSeller_id =1;
    _cartService.setPlace_id =1;
    print(_cartService.getPlace_id);
    print(_cartService.getSeller_id);

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
      body: Theme(
          data: ThemeData(
              primaryColor: Colors.orange
          ),
          child: Container(
            constraints: BoxConstraints.expand(
            ),
            child: Stack(
              children: <Widget>[
                Padding(padding: EdgeInsets.only(top: 20),child: StepperW(1),),
                Padding(padding: EdgeInsets.only(top: 90, left: 30,right: 30),
                child: Card(
                  elevation: 5.0,
                  margin: EdgeInsets.only(bottom: 100),
                  child: Center(
                    child: Column(
                      mainAxisSize: MainAxisSize.max,
                      children: <Widget>[
                        Padding(padding: EdgeInsets.only(top: 40)),
                        Text('Selecciona el lugar de tu entrega;',
                          style: TextStyle(color: Colors.orange,
                            fontWeight: FontWeight.bold),),
                        Padding(padding: EdgeInsets.only(left: 40,top: 40,right: 40),
                        child:  DropdownButton(
                          elevation: 5,
                          isExpanded: true,
                          icon: Icon(Icons.business),
                          value: selected_buildign,
                          items: listBuiling,
                          hint: Container(
                            child:Row(
                              mainAxisSize: MainAxisSize.min,
                              crossAxisAlignment: CrossAxisAlignment.end,
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: <Widget>[
                                Text("Edificio"),
                              ],
                            ),
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
                        ),),
                        Padding(padding: EdgeInsets.only(left: 40,top: 20,right: 40),
                        child: DropdownButton(
                          isExpanded: true,
                          icon: Icon(Icons.place),
                          value: selected_offices,
                          items: listoffices,
                          hint: new Row(
                            children: <Widget>[
                              new Text("Oficina"),
                            ],
                          ),
                          onChanged: (value){
                            selected_offices = value;
                            setState(() {

                            });
                          },
                        ),)
                      ],
                    ),
                  ),
                ),),
                Positioned(
                    bottom: 5,
                    left: 5,
                    right: 5,
                    child: Row(
                      children: <Widget>[
                        GestureDetector(
                          child: Container(
                            color: Colors.orange,
                            child: Center(
                              child: Text('Cancelar',
                              style: TextStyle(
                                color: Colors.white,
                                fontSize: 15,
                                fontWeight: FontWeight.bold
                              ),),
                            ),
                            width: 150,
                            height: 50,
                          ),
                          onTap: (){
                            goToNext();
                          },
                        ),
                        GestureDetector(
                          child: Container(
                            margin: EdgeInsets.only(left: 50),
                            color: Colors.orange,
                            child: Center(
                              child: Text('Elegir productos',
                                style: TextStyle(
                                  color: Colors.white,
                                  fontSize: 15,
                                  fontWeight: FontWeight.bold
                              ),),
                            ),
                            width: 150,
                            height: 50,
                          ),
                        ),

                      ],
                    )
                )
              ],
            )
          ),
      )
    );
  }
}



