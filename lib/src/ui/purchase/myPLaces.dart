import 'package:flutter/material.dart';
import 'package:prue/src/bloc/location.controller.dart';
import 'package:prue/src/models/addplace.dart';
import 'package:prue/src/models/cart.model.dart';
import 'package:prue/src/widgets/loadingAlert.dart';
import 'package:prue/src/widgets/menu.dart';

class Myplaces extends StatefulWidget {
  @override
  _MyplacesState createState() => _MyplacesState();
}


class _MyplacesState extends State<Myplaces> {
  locationController locationC = new locationController();
  List<AddPlace> addPlace = new List() ;
  CartModel cart = new CartModel();
  bool isloading = true;
  String message;

  @override
  void initState() {
    cart.setRoute = "myPlaces";
    getPlaces();
  }
  getPlaces(){
    message = 'Descargando tus lugares...';
    addPlace = [];
    print(cart.getRoute);
    locationC.getPlaces().then((List<AddPlace> place){
      setState(() {
        addPlace.addAll(place);
        isloading =false;

      });
    });
  }




  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    double height = MediaQuery.of(context).size.height;
    return Scaffold(
      appBar: AppBar(
        title: Text('Mis lugares'),
        backgroundColor: Colors.orange,
        actions: <Widget>[
          PopupMenuButton<String>(
            onSelected: choiceAction,
            itemBuilder: (BuildContext context) {
              return Constants.choices.map((String choice) {
                return PopupMenuItem<String>(
                  value: choice,
                  child: Text(choice),
                );
              }).toList();
            },
          )
        ],
        centerTitle: true,
      ),
      drawer: MainDrawer(),
      body:isloading == true ?Container(
        child: LoadingAlert(message),
      ): Stack(
        children: <Widget>[
          ListView.builder(
              itemCount: addPlace.length,
              itemBuilder: (BuildContext context, int index){
            return Padding(padding: EdgeInsets.all(10),
            child: Card(
              elevation: 5.0,
              child: Stack(
                children: <Widget>[
                  Column(
                    mainAxisSize: MainAxisSize.max,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children:
                  <Widget>[
                    Padding(padding: EdgeInsets.all(10),
                    child: Row(
                      children: <Widget>[
                        Text('Nombre: ',
                          style: TextStyle(fontWeight: FontWeight.bold,
                          fontSize: height/35),),
                        Text('${addPlace[index].name}',
                          style: TextStyle(fontSize: height/35),)
                      ],
                    ),),
                    Container(
                      width: width/1.2,
                      padding: EdgeInsets.only(left: 10),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.start,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: <Widget>[
                          Text('Dirección: ',
                            style:TextStyle(
                                fontSize: height/35,
                                fontWeight: FontWeight.bold
                            ),),
                          Container(
                            width: width/2,
                            child:Text('${addPlace[index].address}',
                            style: TextStyle(fontSize: height/35),),
                          ),
                        ],
                      ),
                    ),
                    Padding(padding: EdgeInsets.only(top: 10),
                      child: Container(
                        height: 10,
                      ),),
                  ],),
                  Positioned(
                      right: 10.0,
                      top: 10,
                      child: GestureDetector(
                        onTap: (){
                          setState(() {
                            isloading = true;
                            message = "Eliminando lugar";
                          });
                          locationC.place_id = addPlace[index].id;
                          locationC.deletePlace().then((_){
                            print(_);
                            getPlaces();
                          });
                        },
                        child: Icon(Icons.delete,color: Colors.orange,
                        size: height/16,),
                      ))
                ],
              ),
            ),);
          })

        ],
      ),
    );
  }
  void choiceAction(String choice) {
    if (choice == Constants.Subscribe) {
      Navigator.of(context).pushNamed('/maps');
    }
  }
}

class Constants {
  static const String Subscribe = 'Añadir lugars';
  static const List<String> choices = <String>[
    Subscribe,
  ];
}

