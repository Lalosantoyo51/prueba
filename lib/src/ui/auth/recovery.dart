import 'package:flutter/material.dart';
import 'package:prue/src/bloc/authController.dart';
import 'package:rflutter_alert/rflutter_alert.dart';
import 'package:dio/dio.dart';


class Recovery extends StatefulWidget {
  @override
  _RecoveryState createState() => _RecoveryState();
}

class _RecoveryState extends State<Recovery> {
  AuthCOntroller _authController = new AuthCOntroller();
  String error;

   login() async{
     _authController.reset().catchError((e){
        print("data${e.response?.data['errors']['email']}");
        error = e.response?.data['errors']['email'].toString();
        _onAlertWarning(context);
       }).then((res){
         if(res != null){
           _onAlertSucess(context);

         }
     });
  }
  _onAlertWarning(context) {
    Alert(
      context: context,
      type: AlertType.warning,
      title: "",
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
  _onAlertSucess(context) {
    Alert(
      context: context,
      type: AlertType.success,
      title: "",
      desc: "Mensaje enviado. Revisa tu correo electrónico",
      buttons: [
        DialogButton(
          color: Colors.orange,
          child: Text(
            "Aceptar",
            style: TextStyle(color: Colors.white, fontSize: 20),
          ),
          onPressed: (){
            Navigator.pop(context);
            Navigator.of(context).pushNamed('/sign-in');
          },
          width: 120,
        )
      ],
    ).show();
  }

  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;

    return new Scaffold(
      body: Stack(
          children: <Widget>[
            ListView(
              children: <Widget>[
                new Container(
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  begin: Alignment.bottomLeft,
                  end: Alignment.bottomRight,
                  colors: [
                    Colors.deepOrangeAccent,
                    Colors.orangeAccent
                  ],
                ),
              ),
              child: new Container(
                child: new Image.asset('assets/logo.png',scale: 2.8,
                ),
                margin: EdgeInsets.only(bottom: 90),
              ),
              height: 330,
              width: 500,
            ),
          ],
        ),
        Container(
          height: 370,
          child:  Card(
            margin: EdgeInsets.only(top: 200, left: 20,right: 20),
            elevation: 10,
            child:  Container(
                margin: EdgeInsets.only(left: 10, right: 10,bottom: 30),
                child:  Center(
                  child: TextField(
                    controller: _authController.email,
                    decoration: new InputDecoration(
                      icon: new Icon(Icons.email),
                      labelText: "ingresa correo",
                      hintStyle: TextStyle(color: Colors.orangeAccent),
                    ),
                  ),
                )
            ),
          ),
        ),
            Positioned(
                top: 340,
                right: 30,
                left: 30,
                child:Container(
                  child: Center(
                    child:Container(
                      width: width,
                      child: new MaterialButton(
                        onPressed: login,
                        color: Colors.orangeAccent,
                        splashColor: Colors.deepOrangeAccent,
                        textColor: Colors.white,
                        child: new Text("Recuperar", style: new TextStyle(
                            color: Colors.white,
                            fontSize: 20
                        ),),
                        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
                      ),
                    ),
                  ),
                ),
            ),
            Positioned(
                top: 430,
                child: Container(
                  width: width,
                  child: Center(
                    child: GestureDetector(
                      onTap: (){
                        Navigator.of(context).pushNamed('/sign-in');
                      },
                      child: Text('Cancelar' ,
                          textAlign: TextAlign.center,style: new TextStyle(
                            fontSize: 18,
                              color: Colors.black38,fontWeight: FontWeight.bold)
                      ),
                    ),
                  ),
                ),
            )
      ]),
    );

  }

}
