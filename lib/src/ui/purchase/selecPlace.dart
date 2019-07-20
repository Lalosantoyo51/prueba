import 'package:flutter/material.dart';
import 'package:prue/src/bloc/location.controller.dart';
import 'package:prue/src/bloc/purchaseController.dart';
import 'package:prue/src/models/addplace.dart';
import 'package:prue/src/models/cart.model.dart';
import 'package:prue/src/models/provisionDetails.dart';
import 'package:prue/src/widgets/loadingAlert.dart';
import 'package:prue/src/widgets/menu.dart';
import 'package:prue/src/widgets/stepperW.dart';
import 'package:rflutter_alert/rflutter_alert.dart';

class SelecPlace extends StatefulWidget {
  @override
  _SelecPlaceState createState() => _SelecPlaceState();
}

class _SelecPlaceState extends State<SelecPlace> {
  String selected_place;
  locationController locationC = new locationController();
  PurchaseController  purchaseController = new PurchaseController();
  List<DropdownMenuItem<String>> listPlace = [];
  List<AddPlace> addPlace = new List() ;
  CartModel cart = new CartModel();
  double lat;
  String error;
  String message;
  var loadingContext;

  closeAlert(BuildContext _context) {
    Navigator.of(_context).pop();
  }


  @override
  void initState() {
    super.initState();
    cart.setRoute = "selec_place";
    cart.setPlaces_user_id = null;
    locationC.getPlaces().then((List<AddPlace> addPlace){
      this.addPlace = addPlace;
      setState(() {
        listPlace = [];
      });
      this.addPlace.forEach((place){
        listPlace.add(new DropdownMenuItem(
            child: new Text('${place.name}') ,
            value: place.id.toString()
        ));
      });


    });

  }
  goToAddPlaces(){
    Navigator.of(context).pushNamed('/maps');
  }
  getCurrenPlace()async{
    message = 'Obteneindo ubicación';
    loading();
    await locationC.getlocation().then((_) {
      locationC.areaModel.lat = _[0]['latitude'];
      locationC.areaModel.lng = _[0]['longitude'];
      lat = _[0]['latitude'];
      cart.setLatitude = _[0]['latitude'];
      cart.setLongitude = _[0]['longitude'];
      closeAlert(context);
      onAlertButtonSucces(context);
    });
  }
  _onAlertButtonError(context){
    Alert(
      context: context,
      type: AlertType.warning,
      title: "Advertencia",
      desc: "${error}",
      buttons: [
        DialogButton(
          color: Colors.orange,
          child: Text(
            "Aceptar",
            style: TextStyle(color: Colors.white, fontSize: 20),
          ),
          onPressed: () => Navigator.pop(context),
          width: 120,
        )
      ],
    ).show();
  }
  onAlertButtonSucces(context){
    Alert(
      context: context,
      type: AlertType.success,
      title: "Advertencia",
      desc: "Se obtuvo tu ubicacion",
      buttons: [
        DialogButton(
          color: Colors.orange,
          child: Text(
            "Aceptar",
            style: TextStyle(color: Colors.white, fontSize: 20),
          ),
          onPressed: () => Navigator.pop(context),
          width: 120,
        )
      ],
    ).show();
  }
  loading() async {
    showDialog(
        context: context,
        builder: (context) {
          loadingContext = context;
          return LoadingAlert(message);
        });
  }


  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    double height = MediaQuery.of(context).size.height;
    return Scaffold(
      appBar: AppBar(
        title: new Text('inicio'),
        centerTitle: true,
        backgroundColor: Colors.orange,
      ),
      drawer: MainDrawer(),
      body: Theme(
        data: ThemeData(
            primaryColor: Colors.orange
        ),
        child: Container(
          constraints: BoxConstraints.expand(),
          child: Stack(
            children: <Widget>[
              Padding(padding: EdgeInsets.only(top: 20),child: StepperW(1),),
              Padding(padding: EdgeInsets.only(top: 90),
                  child: Card(
                    elevation: 5.0,
                    child: Container(
                      width: width,
                      height: height/1.8,
                      padding: EdgeInsets.only(bottom: 15),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        mainAxisAlignment: MainAxisAlignment.center,
                        mainAxisSize: MainAxisSize.max,
                        children: <Widget>[
                          Text('Selecciona el lugar de tu entrega:',style:
                            TextStyle(
                              fontSize: height/30
                            ),),
                          Padding(padding: EdgeInsets.only(top: 15)),

                          RaisedButton(onPressed: (){
                            getCurrenPlace();
                          },
                            child: Text('Mi ubicacion Actual',
                              style: TextStyle(
                                  color: Colors.white,
                                fontSize: height/30
                              ),),
                            disabledColor: Colors.orange,
                            color: Colors.orange,
                            shape: new RoundedRectangleBorder(borderRadius: new BorderRadius.circular(30.0)),
                          ),
                          Padding(padding: EdgeInsets.only(top: 15)),
                          Text('Ó',style: TextStyle(
                            fontSize: height/30,
                            fontWeight: FontWeight.bold
                          ),),
                          Padding(padding: EdgeInsets.only(top: 0)),
                          Container(
                            width: width,
                            padding: EdgeInsets.only(left: width/10,right:width/10),
                            child:DropdownButton(
                            elevation: 5,
                            isExpanded: true,
                            icon: Icon(Icons.place),
                            value: selected_place,
                            items: listPlace,
                            hint: Container(
                              child:Row(
                                mainAxisSize: MainAxisSize.min,
                                crossAxisAlignment: CrossAxisAlignment.end,
                                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                children: <Widget>[
                                  Text("Mis lugares"),
                                ],
                              ),
                            ),
                            onChanged: (value){
                              setState(() {
                                selected_place = value;
                                print(value);
                                cart.setPlaces_user_id = int.parse(value);
                              });
                            },
                          ),),
                          Padding(padding: EdgeInsets.only(top: 15)),
                          RaisedButton(
                            onPressed: goToAddPlaces,
                            child: Text('Añadir nuevo lugar',
                              style: TextStyle(
                                  color: Colors.white,
                                  fontSize: height/30
                              ),),
                            disabledColor: Colors.orange,
                            hoverColor: Colors.orange,
                            color: Colors.orange,
                            shape: new RoundedRectangleBorder(borderRadius: new BorderRadius.circular(30.0)),
                          ),
                        ],
                      ),
                    ),
                  )),
              Positioned(
                  bottom: 5,
                  left: 5,
                  right: 5,
                  child: Container(
                    width: width,
                    child: Row(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      mainAxisSize: MainAxisSize.max,
                      mainAxisAlignment: MainAxisAlignment.center,
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
                                ),
                              ),
                            ),
                            height: 50,
                            width: width/2.2,
                          ),
                          onTap: (){
                            Navigator.pop(context);
                          },
                        ),
                        GestureDetector(
                          child: Container(
                            margin: EdgeInsets.only(left: 10),
                            color: Colors.orange,
                            child: Center(
                              child: Text('Elegir productos',
                                style: TextStyle(
                                    color: Colors.white,
                                    fontSize: 15,
                                    fontWeight: FontWeight.bold
                                ),),
                            ),
                            height: 50,
                            width: width/2.2,
                          ),
                          onTap: (){
                            if(lat == null && cart.getPlaces_user_id == null){
                              error =  "Hey amigo selecciona tu lugar de entrega";
                              _onAlertButtonError(context);

                            }else {
                              purchaseController.getProductsStreet().then((List<ProvisionDetails> provisionDetails){
                                print(provisionDetails);
                                if(provisionDetails == null){
                                  error = "";
                                  error =  "¡Lo sentimos, no hay provisiones para tu zona!, intenta más tarde.";
                                  _onAlertButtonError(context);
                                }else {
                                  Navigator.of(context).pushNamed('/products');
                                }
                              });
                            }
                          },
                        ),

                      ],
                    ),
                  )
              )
            ],
          ),
        ),
      ),
    );
  }
}
