import 'dart:async';
import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:prue/src/bloc/location.controller.dart';
import 'package:prue/src/models/Userget.dart';
import 'package:prue/src/models/addplace.dart';
import 'package:prue/src/models/cart.model.dart';
import 'package:prue/src/widgets/loadingAlert.dart';
import 'package:prue/src/widgets/menu.dart';
import 'package:rflutter_alert/rflutter_alert.dart';

class Maps extends StatefulWidget {
  @override
  _MapsState createState() => _MapsState();
}

class _MapsState extends State<Maps> {
  final TextEditingController name = new TextEditingController();
  final TextEditingController adddres = new TextEditingController();
  CartModel cart = new CartModel();
  locationController locationCOntroller = new locationController();
  Completer<GoogleMapController> _controller = Completer();
  double myLat;
  double myLng;
  double latitude;
  double longitude;
  User user = new User();
  String error;

  var loadingContext;
  bool isLoading = true;
  bool isVissible = true;
  LatLng pont = new LatLng(0.0, 0.0);
  Set<Marker> markers = Set<Marker>();

  closeAlert(BuildContext _context) {
    Navigator.of(_context).pop();
  }

  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    double height = MediaQuery.of(context).size.height;
    return new Scaffold(
        appBar: AppBar(
          title: Text('Añadir lugar'),
          centerTitle: true,
          backgroundColor: Colors.orange,
        ),
        drawer: MainDrawer(),
        body: isLoading == true
            ? Container()
            : Stack(
          children: <Widget>[
            Container(
              child: Card(
                elevation: 2.0,
                margin: EdgeInsets.all(10),
                child: Column(
                  children: <Widget>[
                    Padding(padding: EdgeInsets.all(10),child:
                    TextFormField(cursorRadius:
                    Radius.circular(20),
                      style: TextStyle(color: Colors.orange),
                      cursorColor: Colors.orange,
                      controller: name,
                      decoration: const InputDecoration(
                          fillColor: Colors.white,
                          focusedBorder: UnderlineInputBorder(
                            borderSide: BorderSide(color: Colors.orange),
                          ),
                          enabledBorder: UnderlineInputBorder(
                              borderRadius: BorderRadius.only(
                                  topLeft: const Radius.circular(40.0),
                                  topRight: const Radius.circular(40.0)
                              ),
                              borderSide: BorderSide(color: Colors.orange)),
                          filled: true,
                          hintText: 'Nombre del lugar',
                          hintStyle:
                          TextStyle(color: Colors.orange, fontSize: 18),
                          prefixIcon:
                          Icon(Icons.account_box, color: Colors.orange),
                          border: UnderlineInputBorder(
                              borderSide:
                              BorderSide(color: Colors.orange))),
                      keyboardType: TextInputType.text,
                    ),),
                    Padding(padding: EdgeInsets.all(10),child:
                    TextFormField(
                      style: TextStyle(color: Colors.orange),
                      cursorColor: Colors.orange,
                      controller: adddres,
                      decoration: const InputDecoration(
                          focusedBorder: UnderlineInputBorder(
                            borderSide: BorderSide(color: Colors.orange),
                          ),
                          enabledBorder: UnderlineInputBorder(
                              borderSide: BorderSide(color: Colors.orange,)),
                          filled: true,
                          hintText: 'Dirección',
                          hintStyle:
                          TextStyle(color: Colors.orange, fontSize: 18),
                          prefixIcon:
                          Icon(Icons.location_on, color: Colors.orange),
                          border: UnderlineInputBorder(
                              borderSide:
                              BorderSide(color: Colors.orange))),
                      keyboardType: TextInputType.text,
                    ),),
                    Container(
                      padding: EdgeInsets.only(left: 20, right: 20),
                      height: height/2,
                      child: Stack(
                        children: <Widget>[
                          Padding(
                            padding: EdgeInsets.only(top: 100),
                          ),
                          GoogleMap(
                            onCameraMove: _updateCameraPosition,
                            myLocationEnabled: true,
                            markers: markers,
                            mapType: MapType.normal,
                            onTap: _handleTap,
                            initialCameraPosition: CameraPosition(
                              target: LatLng(myLat, myLng),
                              zoom: 14.4746,
                            ),
                            onMapCreated: (GoogleMapController controller) {
                              _controller.complete(controller);
                            },
                          ),
                          isVissible == true
                              ? Center(
                              child: Padding(
                                padding: EdgeInsets.only(bottom: 40),
                                child: GestureDetector(
                                  child: Image.asset(
                                    'assets/marcadornaranja.png',
                                    width: 50,
                                    height: 50,
                                  ),
                                  onTap: () {
                                    addMarket();
                                    setState(() {
                                      isVissible = false;
                                    });
                                  },
                                ),
                              ))
                              : Container(),
                        ],
                      ),
                    )
                  ],
                ),
              ),
            ),
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
                          goBack();
                        },
                      ),
                      GestureDetector(
                        child: Container(
                          margin: EdgeInsets.only(left: 10),
                          color: Colors.orange,
                          child: Center(
                            child: Text('Añadir lugar',
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
                          addPlaces();
                        },
                      ),
                    ],
                  ),
                )
            )
          ],
        ));
  }

  getLocation() async {
    await locationCOntroller.getlocation().then((_) async {
      print(_);
      setState(() {
        myLat = _[0]['latitude'];
        myLng = _[0]['longitude'];
        isLoading = false;
        LatLng myposition = LatLng(myLat, myLng);
        pont = myposition;
      });
    });
  }

  @override
  void initState() {
    getLocation();
    print(cart.getRoute);
  }

  _handleTap(LatLng point) {
    setState(() {
      print(point);
      latitude = point.latitude;
      longitude = point.longitude;
    });
  }
  addMarket() {
    markers.add(Marker(
      markerId: MarkerId('MyPosition'),
      position: pont,
      infoWindow: InfoWindow(
        title: 'Mi posición',
      ),
    ));
  }
  loading() async {
    showDialog(
        context: context,
        builder: (context) {
          loadingContext = context;
          return LoadingAlert('Guardando lugar');
        });
  }
  goBack(){
    Navigator.pop(context);
  }
  addPlaces(){
    if(isVissible == true){
      print('no has selecionado ningun lugar');
      error = 'no has selecionado ningun lugar';
      _onAlertButtonError2(context);


    }else {
      loading();
      latitude = pont.latitude;
      longitude = pont.longitude;
      locationCOntroller.addPlace.name = name.text;
      locationCOntroller.addPlace.address = adddres.text;
      locationCOntroller.addPlace.lat = latitude;
      locationCOntroller.addPlace.lng = longitude;
      locationCOntroller.addPlace.user_id = user.getUser_id;
      if(name.text.length > 0){
        if(adddres.text.length > 0){
          locationCOntroller.addPlaces().then((AddPlace addplace){
            closeAlert(context);
            _onAlertButtonError(context);
            print(addplace.name);

          });
        }else {
          print('el campo direccion es obligatorio');
          error = 'el campo direccion es obligatorio';
          _onAlertButtonError2(context);
        }
      }else{
        print('el campo nombre del lugar es obligatorio');
        error = 'el campo nombre del lugar es obligatorio';
        _onAlertButtonError(context);

      }
    }
  }

  _onAlertButtonError(context){
    Alert(
      context: context,
      type: AlertType.success,
      title: "Tu lugar se añadido",
      desc: "",
      buttons: [
        DialogButton(
          color: Colors.orange,
          child: Text(
            "Aceptar",
            style: TextStyle(color: Colors.white, fontSize: 20),
          ),
          onPressed: (){
            Navigator.popAndPushNamed(context, "/${cart.getRoute}");
          },
          width: 120,
        )
      ],
    ).show();
  }
  _onAlertButtonError2(context){
    Alert(
      context: context,
      type: AlertType.warning,
      title: "Advertencia",
      desc: "$error",
      buttons: [
        DialogButton(
          color: Colors.orange,
          child: Text(
            "Aceptar",
            style: TextStyle(color: Colors.white, fontSize: 20),
          ),
          onPressed: (){
            Navigator.pop(context);
          },
          width: 120,
        )
      ],
    ).show();
  }

  void _updateCameraPosition(CameraPosition position) {
    setState(() {
      pont = position.target;
    });
  }
}