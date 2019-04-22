import 'package:flutter/material.dart';
import '../../resource/auth.service.dart';
import 'package:dio/dio.dart';


class Verification extends StatefulWidget {
  @override
  _VerificationState createState() => _VerificationState();
}

class _VerificationState extends State<Verification> {
  AuthService _authService = new AuthService();

  //controller
  TextEditingController number1 = TextEditingController();
  TextEditingController number2 = TextEditingController();
  TextEditingController number3 = TextEditingController();
  TextEditingController number4 = TextEditingController();

  //next textform
  final FocusNode focus = FocusNode();
  final FocusNode focus2 = FocusNode();
  final FocusNode focus3 = FocusNode();

  String result;

  verify(){
    result = "${int.parse(number1.text)}${int.parse(number2.text)}${int.parse(number3.text)}${int.parse(number4.text)}";
    _authService.verifycode(1234).then((e){

    }).catchError((err){
      print(err);
    });
  }

  signOut(){
    _authService.signOut();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        resizeToAvoidBottomPadding: false,
        body: Stack(
        children: <Widget>[
          Container(
            decoration: BoxDecoration(
                gradient: LinearGradient(colors: [
                  Colors.deepOrangeAccent,
                  Colors.orangeAccent
                ])),
          ),
          Center(
            child: Column(
              children: <Widget>[
                Padding(padding: EdgeInsets.only(top: 50),),
                new Image.asset('assets/logo.png',scale: 2.8),
                Padding(padding: EdgeInsets.only(top: 50),),
                Container(
                    margin: EdgeInsets.only(left: 30, right: 30),
                    child:  Row(
                    children: <Widget>[
                      Expanded(child: new InkWell(
                          onTap: () {
                          },
                          child: new Theme(
                              data: new ThemeData(
                                hintColor: Colors.white,
                              ),
                              child: new TextFormField(
                                controller: number1,
                                textInputAction: TextInputAction.next,
                                keyboardType: TextInputType.number,
                                maxLength: 1,
                                decoration: new InputDecoration(
                                    border: new OutlineInputBorder(),
                                ),
                                onFieldSubmitted: (v){
                                  FocusScope.of(context).requestFocus(focus);
                                },
                              )
                          )
                        ),
                      ),
                      Expanded(child: new InkWell(
                          onTap: () {},
                          child: new Theme(
                              data: new ThemeData(
                                hintColor: Colors.white,
                              ),
                              child: new TextFormField(
                                controller: number2,
                                textInputAction: TextInputAction.next,
                                keyboardType: TextInputType.number,
                                maxLength: 1,
                                focusNode: focus,
                                decoration: new InputDecoration(
                                    border: new OutlineInputBorder(),
                                ),
                                onFieldSubmitted: (v){
                                  FocusScope.of(context).requestFocus(focus2);
                                },
                              )
                          )
                      ),
                      ),
                      Expanded(child: new InkWell(
                          onTap: () {},
                          child: new Theme(
                              data: new ThemeData(
                                hintColor: Colors.white,
                              ),
                              child: new TextFormField(
                                controller: number3,
                                textInputAction: TextInputAction.next,
                                keyboardType: TextInputType.number,
                                focusNode: focus2,
                                maxLength: 1,
                                decoration: new InputDecoration(
                                    border: new OutlineInputBorder(),
                                ),
                                onFieldSubmitted: (v){
                                  FocusScope.of(context).requestFocus(focus3);
                                },
                              )
                          )
                      ),
                      ),
                      Expanded(child: new InkWell(
                          onTap: () {},
                          child: new Theme(
                              data: new ThemeData(
                                hintColor: Colors.white,
                              ),
                              child: new TextFormField(
                                controller: number4,
                                keyboardType: TextInputType.number,
                                focusNode: focus3,
                                textInputAction: TextInputAction.next,
                                maxLength: 1,
                                decoration: new InputDecoration(
                                    border: new OutlineInputBorder(),
                                ),

                              )
                          )
                        ),
                      ),
                    ],
                  )
                ),

                Padding(padding: EdgeInsets.only(top: 50),),
                Container(
                  child: new InkWell(
                    onTap: verify,
                    child: Container(
                      height: 60.0,
                      width: MediaQuery.of(context).size.width - 48.0,
                      margin: EdgeInsets.only(left: 24.0, right: 24.0),
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.all(Radius.circular(30.0)),
                          gradient:LinearGradient(colors: [
                            Colors.orange,
                            Colors.deepOrange,
                          ])),
                      alignment: Alignment.center,
                      child: Text(
                        "Verificar",
                        style: TextStyle(color: Colors.white, fontSize: 22.0),
                      ),
                    ),
                  ),
                ),
                Padding(padding: EdgeInsets.only(top: 20),),
                Text('¿No has recibido el codigo?'),
                FlatButton(
                    child: Text('Reenviar codigo',style: TextStyle(color: Colors.black,),),
                    onPressed:(){
                      _authService.resendCode().then((_){
                        print(_);
                      }).catchError((error){
                        print(error);
                      });
                    }
                ),
                FlatButton(
                    child: Text('Cerrar sesión',style: TextStyle(color: Colors.black,),),
                    onPressed:(){
                      signOut();
                      Navigator.pop(context);
                      Navigator.of(context).pushNamed('/sign-in');
                    }
                ),
              ],
            ),
          ),
        ],
      )
    );
  }
}

