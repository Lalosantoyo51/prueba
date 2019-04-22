import 'package:flutter/material.dart';
import 'package:datetime_picker_formfield/datetime_picker_formfield.dart';
import 'package:flutter_facebook_login/flutter_facebook_login.dart';
import 'package:intl/intl.dart';
import 'package:prue/src/bloc/authController.dart';
import 'package:dio/dio.dart';
import 'package:prue/src/utils/enviroment.dart';
import 'package:rflutter_alert/rflutter_alert.dart';
import 'dart:convert';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:dio/dio.dart';

var dio=Dio();

class SignUp extends StatefulWidget {
  @override
  _SignUpState createState() => _SignUpState();
}

class _SignUpState extends State<SignUp> {
  AuthCOntroller _authCOntroller = new AuthCOntroller();
  static final FacebookLogin facebookSignIn = new FacebookLogin();
  String error;
  String fb_token;
  bool isIndicador = false;
  bool _isTextFieldVisible = false;


  //calendar
  final formats = {
    InputType.date: DateFormat('yyyy-MM-dd'),
  };
  InputType inputType = InputType.date;
  bool editable = true;
  DateTime date;

  //dropdawn
  List<DropdownMenuItem<String>> listDrop = [];
  String selected = null;
  String gender = null;
  void loadItems(){
    listDrop = [];
   listDrop.add(new DropdownMenuItem(
     child: new Text('Masculino') ,
     value: 'Male'
   ));
   listDrop.add(new DropdownMenuItem(
     child: new Text('Femenino') ,
     value: 'Female',));
  }


  @override
  void initState() {
    setState(() {
      _isTextFieldVisible = true;
      getUserfb();
    });
  }

  signUp() async {
     final prefs = await SharedPreferences.getInstance();
     setState(() {
       isIndicador  = true;
     });
     try  {
       await _authCOntroller.signUp().then((_){
        var token = prefs.getString('access_token');
         print(token);
         if( token != null){
           Navigator.pop(context);
           Navigator.of(context).pushNamed('/Verification');
           setState(() {
              isIndicador  = false;
           });
         }
       });
     } on DioError catch(e) {
       //erros api
       setState(() {
         print(e.response.data);
         if(e.response != null) {
           print(e.response.data['errors']['email']);
           //print(e.response.data['errors']['last_name'].toString().substring(1,41));
           if(e.response.data['errors']['phone'] != null){
             error = "${e.response.data['errors']['phone'][0].toString()}";
             _onAlertButtonError(context);
             if(e.response.data['errors']['phone'][0].toString() =='Mensaje entregado correctamente.'){
               Navigator.pop(context);
               Navigator.of(context).pushNamed('/Verification');
             }
           }else
           if(e.response.data['errors']['name'] != null){
             error = "${e.response.data['errors']['name'][0].toString()}";
             _onAlertButtonError(context);
           }else if(e.response.data['errors']['last_name'] != null){
             error = "${e.response.data['errors']['last_name'][0].toString()}";
             _onAlertButtonError(context);
           }else if(e.response.data['errors']['email'] != null){
             error = "${e.response.data['errors']['email'][0].toString()}";
             _onAlertButtonError(context);
           }else if(e.response.data['errors']['gender'] != null){
             error = "${e.response.data['errors']['gender'][0].toString()}";
             _onAlertButtonError(context);
           }else if(e.response.data['errors']['password'] != null){
             error = "${e.response.data['errors']['password'][0].toString()}";
             _onAlertButtonError(context);
           }else if(e.response.data['errors']['birthday'] != null){
             error = "El campo Fecha de nacimiento es obligatorio.";
             _onAlertButtonError(context);
           }
           isIndicador  = false;

         } else{
           print('todo chido ');
           print(e.request);
           print(e.message);
         }
       });
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
  Future _loginFb() async {
    final FacebookLoginResult result =
    await facebookSignIn.logInWithReadPermissions(['email']);
    FacebookAccessToken accessToken = result.accessToken;
    var token =accessToken.token;
    print(token);
    Response response;
    response = await dio.get(
        '${FACEBOOK_GRAPH_API_URL}me?fields=id%2Cemail%2Cgender%2Cfirst_name%2Clast_name&access_token=${token}');
    Map<String, dynamic> user = jsonDecode(response.data);
    print(response.data);
    print(user['email']);
    var prefs = await SharedPreferences.getInstance();
    prefs.setString('fb_token', token);
    fb_token = token;
    _authCOntroller.fb_token = token;
    _authCOntroller.facebook_id = int.parse(user['id']);
   _authCOntroller.email.text =  user['email'];
   _authCOntroller.name.text =  user['first_name'];
   _authCOntroller.last_name.text =  user['last_name'];
   _authCOntroller.gender.text = user['gender'];
    setState(() => _isTextFieldVisible = false);
if(user['gender'] == 'male'){
      _authCOntroller.gender.text = 'Male';
    }
  }
  getUserfb()async{
    final prefs = await SharedPreferences.getInstance();
    fb_token = prefs.getString('fb_token');
    print(fb_token);
    Response response;
    response = await dio.get(
        '${FACEBOOK_GRAPH_API_URL}me?fields=id%2Cemail%2Cgender%2Cfirst_name%2Clast_name&access_token=${fb_token}');
    Map<String, dynamic> user = jsonDecode(response.data);
    print(response.data);
    print(user['email']);
    _authCOntroller.fb_token = fb_token;
    _authCOntroller.facebook_id = int.parse(user['id']);
    _authCOntroller.email.text =  user['email'];
    _authCOntroller.name.text =  user['first_name'];
    _authCOntroller.last_name.text =  user['last_name'];
    if(user['gender'] == 'male'){
      _authCOntroller.gender.text = 'Male';
    }
    setState(() => _isTextFieldVisible = false);

  }
  signUpwithFB() async {
    try  {
      await _authCOntroller.signUpFacebook().then((_){
        print(_);
      });
    } on DioError catch(e) {
      print(e.response.data);
      if(e.response != null) {
        if(e.response.data['errors']['name'] != null){
          error = "${e.response.data['errors']['name'][0].toString()}";
          _onAlertButtonError(context);
        }else if(e.response.data['errors']['last_name'] != null){
          error = "${e.response.data['errors']['last_name'][0].toString()}";
          _onAlertButtonError(context);
        }else if(e.response.data['errors']['email'] != null){
          error = "${e.response.data['errors']['email'][0].toString()}";
          _onAlertButtonError(context);
        }else if(e.response.data['errors']['gender'] != null){
          error = "${e.response.data['errors']['gender'][0].toString()}";
          _onAlertButtonError(context);
        }else if(e.response.data['errors']['birthday'] != null){
          error = "El campo Fecha de nacimiento es obligatorio.";
          _onAlertButtonError(context);
        }
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    loadItems();
    return new MaterialApp(
      home: new Scaffold(
        body: new Container(
          child: Center(
            child:  isIndicador
                ? CircularProgressIndicator()
                : new Stack(children: <Widget>[
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
              new ListView(
                children: <Widget>[
                  Card(
                      margin: EdgeInsets.only(top: 170, left: 20,right: 20),
                      elevation: 10,
                      child: new SizedBox(
                        height: 350,
                        width: 325,
                        child:  new ListView(
                          children: <Widget>[
                            new Container(
                              margin: EdgeInsets.only(left: 10, right: 10),
                              child: new TextField(
                                controller: _authCOntroller.name,
                                decoration: new InputDecoration(
                                  icon: new Icon(Icons.person_pin_circle),
                                  labelText: "Nombre",
                                  hintStyle: TextStyle(color: Colors.orangeAccent),
                                ),
                              ),

                            ),
                            new Padding(
                              padding: const EdgeInsets.only(top: 10.0),
                            ),
                            new Container(
                                margin: EdgeInsets.only(left: 10, right: 10),
                                child: TextField(
                                  controller: _authCOntroller.last_name,
                                  decoration: new InputDecoration(
                                    labelText: "Apellido",
                                    icon: new Icon(Icons.person_pin_circle),
                                  ),
                                )
                            ),

                            new Padding(
                              padding: const EdgeInsets.only(top: 10.0),
                            ),
                            new Container(
                                margin: EdgeInsets.only(left: 10, right: 10),
                                child: TextField(
                                  controller: _authCOntroller.email,
                                  decoration: new InputDecoration(
                                    labelText: "Correo electronico",
                                    icon: new Icon(Icons.email),
                                  ),
                                )
                            ),
                            new Padding(
                              padding: const EdgeInsets.only(top: 10.0),
                            ),
                            new Container(
                                margin: EdgeInsets.only(left: 10, right: 10),
                                child: TextField(
                                  controller: _authCOntroller.phone,
                                  decoration: new InputDecoration(
                                    labelText: "Numero telefonico",
                                    icon: new Icon(Icons.phone),
                                  ),
                                  keyboardType: TextInputType.numberWithOptions(),
                                )
                            ),


                            new Padding(
                              padding: const EdgeInsets.only(top: 10.0),
                            ),
                            new Container(
                              margin: EdgeInsets.only(left: 10, right: 10),
                              child: new DateTimePickerFormField(
                                  inputType: inputType,
                                  format: formats[inputType],
                                  editable: editable,
                                  decoration: InputDecoration(
                                      fillColor:Color(9),
                                      icon: new Icon(Icons.calendar_today),
                                      labelText: 'Cumpleaños', hasFloatingPlaceholder: false),
                                  onChanged: (dt) => {
                                  setState(
                                        () => date = dt,
                                  ),
                                  _authCOntroller.birthday = "${date.year}-${date.month}-${date.day}",
                                  print(_authCOntroller.birthday)
                                  }
                              ),
                            ),

                            new Padding(
                              padding: const EdgeInsets.only(top: 10.0),
                            ),
                            _isTextFieldVisible
                            ? new Container(
                                margin: EdgeInsets.only(left: 10, right: 10),
                                child: new DropdownButton(
                                  value: selected,
                                  items: listDrop,
                                  hint: new Row(
                                    children: <Widget>[
                                      new Icon(Icons.person_pin_circle,),
                                      new Text("    Genero"),
                                    ],
                                  ),
                                  onChanged: (value){
                                    selected = value;
                                    _authCOntroller.gender.text = value;
                                    setState(() {

                                    });
                                  },
                                )
                            ):
                            new Container(
                                margin: EdgeInsets.only(left: 10, right: 10),
                                child: TextField(
                                  controller: _authCOntroller.gender,
                                  decoration: new InputDecoration(
                                    labelText: "Genero",
                                    icon: new Icon(Icons.person_pin_circle),
                                  ),
                                )
                            ),


                            new Padding(
                              padding: const EdgeInsets.only(top: 10.0),
                            ),
                            _isTextFieldVisible
                            ? new Container(
                                margin: EdgeInsets.only(left: 10, right: 10),
                                child: TextField(
                                  controller: _authCOntroller.password,
                                  decoration: new InputDecoration(
                                    labelText: "Contraseña",
                                    icon: new Icon(Icons.lock),
                                  ),
                                  obscureText: true,
                                )
                            ):
                            new Padding(
                              padding: const EdgeInsets.only(top: 0.0),
                            ),
                            new Padding(
                              padding: const EdgeInsets.only(top: 15.0),
                            ),
                            _isTextFieldVisible
                            ? new Container(
                                margin: EdgeInsets.only(left: 10, right: 10),
                                child: TextField(
                                  controller: _authCOntroller.password_confirmation,
                                  decoration: new InputDecoration(
                                    labelText: "Confirmar Contraseña",
                                    icon: new Icon(Icons.lock),
                                  ),
                                  obscureText: true,
                                )
                            ):
                            new Padding(
                              padding: const EdgeInsets.only(top: 0.0),
                            ),
                            new Padding(
                              padding: const EdgeInsets.only(top: 10.0),
                            ),
                            new Container(
                              margin: EdgeInsets.only(left: 30, right: 30),
                              child: new MaterialButton(
                                onPressed: signUp,
                                height: 50.0,
                                color: Colors.orangeAccent,
                                splashColor: Colors.deepOrangeAccent,
                                textColor: Colors.white,
                                child: new Text("Registrarse", style: new TextStyle(
                                    color: Colors.white,
                                    fontSize: 20
                                ),),
                                shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
                              ),
                            ),
                            new Padding(
                              padding: const EdgeInsets.only(top: 20.0),
                            ),
                            new Container(
                              margin: EdgeInsets.only(left: 30, right: 30),
                              child: new MaterialButton(
                                onPressed: (){
                                  if(fb_token == null){
                                    _loginFb();
                                  }else{
                                    signUpwithFB();
                                  }
                                },
                                height: 50.0,
                                color: Color(0xFF01579B),
                                splashColor: Colors.deepOrangeAccent,
                                textColor: Colors.white,
                                child: new Text("Registrarme con Facebook", style: new TextStyle(
                                    color: Colors.white,
                                    fontSize: 15
                                ),),
                                shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
                              ),
                            ),
                            new Padding(
                              padding: const EdgeInsets.only(bottom: 40.0),
                            ),
                          ],
                        ),
                      )
                  ),
                ],
              )
            ]),
          )
        ) ),

    );

  }
  void updateInputType({bool date, bool time}) {
    date = date ?? inputType != InputType.time;
    time = time ?? inputType != InputType.date;
    setState(() => inputType =
    date ? time ? InputType.both : InputType.date : InputType.time);
  }
}

