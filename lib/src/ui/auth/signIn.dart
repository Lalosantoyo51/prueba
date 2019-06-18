import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:prue/src/bloc/authController.dart';
import 'package:prue/src/models/sign-in.dart';
import 'package:rflutter_alert/rflutter_alert.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:dio/dio.dart';
import 'package:flutter_facebook_login/flutter_facebook_login.dart';
import '../../utils/enviroment.dart';

var dio = Dio();

class SignIn extends StatefulWidget {
  @override
  _SignInState createState() => _SignInState();
}

class _SignInState extends State<SignIn> {
  AuthCOntroller _authCOntroller = new AuthCOntroller();
  static final FacebookLogin facebookSignIn = new FacebookLogin();
  String fb_token;
  String error;

  bool isBussing = false;
  login() async{
    var prefs = await SharedPreferences.getInstance();
    _authCOntroller.signInModel.username = _authCOntroller.username.text;
    _authCOntroller.signInModel.password = _authCOntroller.password.text;
    setState(() {
      isBussing = true;
      _authCOntroller.signIn().then((SignInModel signInModel){
        prefs.setString('access_token', signInModel.access_token);
        _onAlertSucces(context);
      }).catchError((e){
        print(e.response?.toString());
        setState(() {
          isBussing = false;
          _onAlertButtonError(context);
        });
      }
      );
    });
  }
  _onAlertButtonError(context){

    Alert(
      context: context,
      type: AlertType.error,
      title: "Error de autentificación",
      desc: "Amigo burrero, tus credenciales no coinciden con nuestros registros.",
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

  _onAlertButtonErrorFB(context){

    Alert(
      context: context,
      type: AlertType.error,
      title: "Error de autentificación",
      desc: "$error",
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



  // Alert custom images
  _onAlertSucces(context)async{
    final prefs = await SharedPreferences.getInstance();
    String tutorial = '';
    tutorial = prefs.getString('tutorial');
    Alert(
      context: context,
      type: AlertType.success,
      title: "",
      desc: "¡Bienvenido de regreso a la Familia Burrera!",
      buttons: [
        DialogButton(
          color: Colors.orange,
          child: Text(
            "Aceptar",
            style: TextStyle(color: Colors.white, fontSize: 20),
          ),
          onPressed: (){
             if(tutorial == 'visto'){
                Navigator.pop(context);
                Navigator.pushReplacementNamed(context, '/home');
                }else {
                Navigator.pop(context);
                Navigator.pushReplacementNamed(context, '/tutorial');
                }
          },
          width: 120,
        )
      ],
    ).show();
  }

  Future _loginFb() async {
    var prefs = await SharedPreferences.getInstance();
    final FacebookLoginResult result =
    await facebookSignIn.logInWithReadPermissions(['email']);
    FacebookAccessToken accessToken = result.accessToken;
    var token =accessToken.token;
    print(token);
    prefs.setString('fb_token', token);
    Response response;
    response = await dio.get(
        '${FACEBOOK_GRAPH_API_URL}me?fields=id%2Cemail%2Cgender%2Cfirst_name%2Clast_name&access_token=${token}');
    Map<String, dynamic> user = jsonDecode(response.data);
    print(user['email']);
    fb_token = token;
    _authCOntroller.fb_token = token;
    _authCOntroller.facebook_id = int.parse(user['id']);
    signInwithFB();


  }

  signInwithFB() async {
    try  {
      setState(() {
        isBussing = true;
      });
      await _authCOntroller.signInWithFacebook().then((_){
       print(_);
       _onAlertSucces(context);
      });
    } on DioError catch(e) {
      print('heeeeeeeeeeeeeeeeeeeeeeeeeeeeee ${e.response}');
      if(e.response != null) {
        if(e.response.data['errors']['facebook_id'] != null){
          error = "${e.response.data['errors']['facebook_id'][0].toString()}";
          _onAlertButtonErrorFB(context);
          setState(() {
            isBussing = false;
          });
        }
      }
    }
  }


      @override
  Widget build(BuildContext context) {
    return new Scaffold(
        body:new Container(
          child:Center(
              child: isBussing
                  ? CircularProgressIndicator(backgroundColor: Colors.orange,)
                  : Container(
                child: new Stack(children: <Widget>[
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
                            Padding(
                              padding: const EdgeInsets.only(
                                  left: 28.0, right: 28.0, top: 14.0, bottom: 7.0),
                              child: TextFormField(
                                controller: _authCOntroller.username,
                                decoration: const InputDecoration(
                                    labelStyle: TextStyle(color: Colors.grey),
                                    filled: false,
                                    hintText: 'ingresa correo',
                                    suffixIcon: Icon(Icons.email)),
                                keyboardType: TextInputType.text,
                              ),
                            ),
                            new Padding(
                              padding: const EdgeInsets.only(top: 10.0),
                            ),
                            Padding(
                              padding: const EdgeInsets.only(
                                  left: 28.0, right: 28.0, top: 14.0, bottom: 7.0),
                              child: TextFormField(
                                controller: _authCOntroller.password,
                                decoration: const InputDecoration(
                                    labelStyle: TextStyle(color: Colors.grey),
                                    filled: false,
                                    hintText: 'ingresa contraseña',
                                    suffixIcon: Icon(Icons.lock)),
                                keyboardType: TextInputType.text,
                                obscureText: true,
                              ),
                            ),
                            new FlatButton(child: new Text('Ovidé mi contraseña',style: new TextStyle(color:Colors.black38,),),onPressed: ()=> Navigator.of(context).pushNamed('/recovery'),),

                            new Padding(
                              padding: const EdgeInsets.only(top: 40.0),
                            ),
                          ],
                        ),
                      )
                  ),
                  new Positioned(
                    top: 420,
                    left: 50,
                    right: 50,
                    child:Container (
                      child: new MaterialButton(
                        onPressed: login,
                        height: 50.0,
                        minWidth: 250,
                        color: Colors.orangeAccent,
                        splashColor: Colors.deepOrangeAccent,
                        textColor: Colors.white,
                        child: new Text("Iniciar sesión", style: new TextStyle(
                            color: Colors.white,
                            fontSize: 20
                        ),),
                        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
                      ),
                    ),
                  ),
                  new Positioned(
                    top: 500,
                    left: 50,
                    right: 50,
                    child:Container (
                      child: new MaterialButton(
                        onPressed: (){
                          setState(() {
                            isBussing = true;
                          });
                          _loginFb();
                        },
                        height: 50.0,
                        minWidth: 250,
                        color: Color(0xFF01579B),
                        splashColor: Colors.deepOrangeAccent,
                        textColor: Colors.white,
                        child: new Text("Iniciar con Facebook", style: new TextStyle(
                            color: Colors.white,
                            fontSize: 20
                        ),),
                        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
                      ),
                    ),
                  ),
                  new Positioned(
                    top: 550,
                    child:Container (
                      child:  Row(
                        children: <Widget>[
                          Text('¿No tienes una cuenta?',),
                          FlatButton(child: new Text('Registrarse',style: new TextStyle(color:Colors.black),),onPressed: ()=> Navigator.of(context).pushNamed('/sign-up'),)
                        ],
                      ),
                      alignment: FractionalOffset(0.25,0.90),
                      margin: EdgeInsets.only(left: 50),
                    ),
                  ),
                ]),
              ),
          ) ,
        )
    );

  }
}
