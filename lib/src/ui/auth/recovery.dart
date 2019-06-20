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
    return new Scaffold(
      body: new Stack(children: <Widget>[
        new Column(
          mainAxisAlignment: MainAxisAlignment.start,
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
        new Card(
            margin: EdgeInsets.only(top: 200, left: 20,right: 20),
            elevation: 10,
            child: new SizedBox(
              height: 250,
              width: 325,
              child:  new ListView(
                children: <Widget>[
                  new Container(
                    margin: EdgeInsets.only(left: 10, right: 10),
                    child: new TextField(
                      controller: _authController.email,
                      decoration: new InputDecoration(
                        icon: new Icon(Icons.email),
                        labelText: "ingresa correo",
                        hintStyle: TextStyle(color: Colors.orangeAccent),
                      ),
                    ),

                  ),

                  new Padding(
                    padding: const EdgeInsets.only(top: 40.0),
                  ),

                  new Container(
                    margin: EdgeInsets.only(left: 30, right: 30),
                    child: new MaterialButton(
                      onPressed: login,
                      height: 50.0,
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

                  new Padding(
                    padding: const EdgeInsets.only(top: 40.0),
                  ),

                  new Text('Cancelar' , textAlign: TextAlign.center,style: new TextStyle(
                    color: Colors.black38
                  ),)
                ],
              ),
            )
        ),

      ]),
    );

  }

}
