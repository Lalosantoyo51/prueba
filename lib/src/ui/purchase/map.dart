import 'dart:async';
import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:prue/src/bloc/location.controller.dart';
import 'package:prue/src/widgets/menu.dart';

class Maps extends StatefulWidget {
  @override
  _MapsState createState() => _MapsState();
}

class _MapsState extends State<Maps> {
  locationController locationCOntroller = new locationController();
  Completer<GoogleMapController> _controller = Completer();
  double myLat;
  double myLng;
  var loadingContext;
  bool isLoading = true;
  bool isVissible = true;
  LatLng pont = new LatLng(0.0, 0.0);
  Set<Marker> markers = Set<Marker>();

  @override
  Widget build(BuildContext context) {
    return new Scaffold(
        appBar: AppBar(
          title: Text('Añadir lugar'),
          centerTitle: true,
          backgroundColor: Colors.orange,
        ),
        drawer: MainDrawer(),
        body: isLoading == true
            ? Container()
            : Card(
          elevation: 2.0,
          margin: EdgeInsets.all(10),
          child: Column(
            children: <Widget>[
              Padding(padding: EdgeInsets.all(10),child:
              TextFormField(cursorRadius: 
                Radius.circular(20),
                style: TextStyle(color: Colors.orange),
                cursorColor: Colors.orange,
                controller: null,
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
                controller: null,
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
                height: 350,
                child: Stack(
                  children: <Widget>[
                    Padding(
                      padding: EdgeInsets.only(top: 100),
                    ),
                    GoogleMap(
                      onCameraMove: _updateCameraPosition,
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
                        : Container()
                  ],
                ),
              )
            ],
          ),
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
  }

  _handleTap(LatLng point) {
    setState(() {
      print(point);
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

  void _updateCameraPosition(CameraPosition position) {
    setState(() {
      pont = position.target;
    });
  }
}
