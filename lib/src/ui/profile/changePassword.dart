import 'package:flutter/material.dart';
import '../../widgets/menu.dart';
import '../../bloc/authController.dart';
import 'package:dio/dio.dart';
import 'package:rflutter_alert/rflutter_alert.dart';

class changePassword extends StatefulWidget {
  @override
  _changePasswordState createState() => _changePasswordState();
}

class _changePasswordState extends State<changePassword> {
  AuthCOntroller _authCOntroller = new AuthCOntroller();
  String error;
  Future change() async {
    try{
     await _authCOntroller.changePassword().then((_){
       print(_);
       _onAlertButtonSucces(context);
     });
    }on DioError catch(e){
      print(e.response.data['errors']);
      if(e.response.data['errors']['password'] != null){
        error = "${e.response.data['errors']['password'][0]}";
        _onAlertButtonError(context);
      }else if(e.response.data['errors']['newpassword'] != null){
        error = "${e.response.data['errors']['newpassword'][0]}";
        _onAlertButtonError(context);
      }else if(e.response.data['errors']['newpassword_confirmation'] != null){
        error = "${e.response.data['errors']['newpassword_confirmation'][0]}";
        _onAlertButtonError(context);
      }
    }
  }

  _onAlertButtonError(context) {
    Alert(
      context: context,
      type: AlertType.warning,
      title: "Advertencia:",
      desc: "$error",
      buttons: [
        DialogButton(
          color: Colors.orange,
          child: Text(
            "Aceptar", style: TextStyle(color: Colors.white, fontSize: 20),
          ),
          onPressed: () => Navigator.pop(context),
          width: 120,
        )
      ],
    ).show();
  }

  _onAlertButtonSucces(context) {
    Alert(
      context: context,
      type: AlertType.success,
      title: "Éxito:",
      desc: "Se ha cambiado tu contraseña con éxito",
      buttons: [
        DialogButton(
          color: Colors.orange,
          child: Text(
            "Aceptar", style: TextStyle(color: Colors.white, fontSize: 20),
          ),
          onPressed: (){
            Navigator.pop(context);
            Navigator.of(context).pushNamed('/home');
          },
          width: 120,
        )
      ],
    ).show();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawer: MainDrawer(),
      appBar: AppBar(
        title: new Text('cambiar contraseña'),
        centerTitle: true,
        backgroundColor: Colors.orange,),
      body: Stack(
        children: <Widget>[
          Positioned(
            top: 20,
            left: 12.0,
            right: 12.0,
            child: Container(
                height: 265.0,
                width: double.infinity,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.all(Radius.circular(8.0)),
                  color: Colors.white,
                ),
                child: Card(
                  child: Column(
                    children: <Widget>[
                      Padding(
                        padding: const EdgeInsets.only(
                            left: 28.0, right: 28.0, top: 14.0, bottom: 7.0),
                        child: TextField(
                          controller: _authCOntroller.password,
                          decoration: const InputDecoration(
                              labelStyle: TextStyle(color: Colors.grey),
                              filled: false,
                              hintText: 'Contraseña Actual',
                              labelText: 'Contraseña Actual',
                              suffixIcon: Icon(Icons.lock,color: Colors.orange)),
                          obscureText: true,

                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.only(
                            left: 28.0, right: 28.0, bottom: 7.0),
                        child: TextField(
                          controller: _authCOntroller.newpassword,
                          obscureText: true,
                          decoration: const InputDecoration(
                            filled: false,
                            labelStyle: TextStyle(color: Colors.grey),
                            suffixIcon: Icon(Icons.lock,color: Colors.orange),
                            hintText: 'Nueva contraseña',
                            labelText: 'Nueva contraseña',
                          ),
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.only(
                            left: 28.0, right: 28.0, bottom: 7.0),
                        child: TextField(
                          controller: _authCOntroller.newpassword_confirmation,
                          obscureText: true,
                          decoration: const InputDecoration(
                            filled: false,
                            labelStyle: TextStyle(color: Colors.grey),
                            suffixIcon: Icon(Icons.lock,color: Colors.orange,),
                            hintText: 'Repetir Nueva Contraseña',
                            labelText: 'Repetir Nueva Contraseña',
                          ),

                        ),
                      ),
                    ],
                  ),
                )),
          ),
          Positioned(
            right: 24.0,
            left: 24.0,
            top:250,
            child: InkWell(
              onTap: (){
               change();
              },
              child: Container(
                height: 60.0,
                width: MediaQuery.of(context).size.width - 48.0,
                margin: EdgeInsets.only(left: 24.0, right: 24.0),
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.all(Radius.circular(30.0)),
                    gradient: LinearGradient(colors: [
                      Colors.orange,
                      Colors.deepOrangeAccent
                    ])),
                alignment: Alignment.center,
                child: Text(
                  "Cambiar contraseña",
                  style: TextStyle(color: Colors.white, fontSize: 22.0),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
