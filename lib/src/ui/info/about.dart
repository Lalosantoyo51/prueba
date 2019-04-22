import 'dart:async';
import 'package:flutter/material.dart';
import '../../widgets/menu.dart';
import 'package:connectivity/connectivity.dart';
import 'package:flutter/services.dart';
import 'package:url_launcher/url_launcher.dart';
import '../../utils/enviroment.dart';
const url = SERVER_URL;
const urlCCEO = 'http://www.cceo.com.mx';




//status conection internet
final Connectivity _connectivity = Connectivity();
StreamSubscription<ConnectivityResult> _connectivitySubscription;

class About extends StatefulWidget {
  @override
  _AboutState createState() => _AboutState();
}

class _AboutState extends State<About> {

  //create alert down
  final GlobalKey<ScaffoldState> _scaffoldKey = new GlobalKey<ScaffoldState>();


  String error = '';
  @override
  void initState(){
    super.initState();
    //init method internet
    _connectivitySubscription =
        _connectivity.onConnectivityChanged.listen(_updateConnectionStatus);
    initConnectivity();
  }

  //create alert
  Future alert() async{
    _scaffoldKey.currentState.showSnackBar(
        SnackBar(content: Text("$error"),backgroundColor: Colors.red.shade400,));
  }

  // detect if you have internet
  Future<void> initConnectivity() async {
    ConnectivityResult result;
    try {

      result = await _connectivity.checkConnectivity();
      if(result.index == 0){
      }else if(result.index ==1){
        new Future.delayed(Duration.zero,() {
          alert();
        });
        error = "Sin conexión a Internet";
      }
      else if(result.index ==2){
        new Future.delayed(Duration.zero,() {
          alert();
        });
        error = "Sin conexión a Internet";
      }
    } on PlatformException catch (e) {
      print(e.toString());
    }

  }

  //update detect if you have internet
  Future<void> _updateConnectionStatus(ConnectivityResult result ) async {
    if(result.index == 0){
    }else if(result.index ==1){
      error = "Sin conexión a Internet";
      new Future.delayed(Duration.zero,() {
        alert();
      });
    }
    else if(result.index ==2){
      error = "Sin conexión a Internet";
      new Future.delayed(Duration.zero,() {
        alert();
      });
    }

    //go to links
    urlnino() async {
      if (await canLaunch(url)) {
        await launch(url);
      } else {
        throw 'Could not launch $url';
      }
    }
    urlcceo() async{
      if (await canLaunch(url)) {
      await launch(urlCCEO);
      } else {
      throw 'Could not launch $url';
      }
    }

  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: _scaffoldKey,
      drawer: MainDrawer(),
      appBar: AppBar(
        title: new Text('Informacion'),
        centerTitle: true,
        backgroundColor: Colors.orange,
      ),
      body: Column(
        children: <Widget>[
          //new Image.asset(name)
          new Center(
            child: Image.asset(
              'assets/about/burrito.png',
              height: 100.0,
              width: 100.0,
              alignment: Alignment.center,
            ),
          ),

          new Container(
            child: Column(
              children: <Widget>[
                Text('El Niño de los Burritos es una aplicación móvil que te permite ordenar comida, para que posteriormente te sea llevada a donde te encuentras.',
                  textAlign: TextAlign.center,
                ),
                new Padding(
                  padding: const EdgeInsets.only(top: 20.0),
                ),
                Text('Versión de App 2.0',
                  textAlign: TextAlign.center,
                  style: TextStyle(color: Colors.black, fontSize: 20),
                ),
                new Padding(
                  padding: const EdgeInsets.only(top: 20.0),
                ),
                Text('El Niño de los burritos es un producto de Familia Burrera S.A. de C.V.',
                  textAlign: TextAlign.center,
                ),
                new Padding(
                  padding: const EdgeInsets.only(top: 20.0),
                ),
                Text('© 2017 El Niño de los Burritos y su familia burrera.',
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    color: Colors.black54
                  ),
                ),
                new Padding(
                  padding: const EdgeInsets.only(top: 20.0),
                ),
                Text('Si necesitas revisar los términos y condiciones lo puedes hacer en el siguiente enlace.',
                  textAlign: TextAlign.center,
                ),
                FlatButton(
                  child: Text('Términos y Condiciones',style: TextStyle(color: Colors.orange),),
                  onPressed:(){
                    launch(url);
                  }
                ),
                Text('Desarrollado por',
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    fontSize: 20
                  ),
                ),
                FlatButton(
                    child: Text('CCEO - Software Development',style: TextStyle(color: Colors.lightBlue.shade300),),
                    onPressed:(){
                      launch(urlCCEO);
                    }
                ),
                
              ],
            ),
            margin: EdgeInsets.only(left: 30,right: 30),
          ),
        ],
      ),
    );
  }
}
