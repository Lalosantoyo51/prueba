import 'package:flutter/material.dart';
import 'package:date_format/date_format.dart';
import '../../models/Userget.dart';
import '../../bloc/authController.dart';

import '../../widgets/menu.dart';

class Profile extends StatefulWidget {
  @override
  _ProfileState createState() => _ProfileState();
}

class _ProfileState extends State<Profile> {
  AuthCOntroller _authController = new AuthCOntroller();
  User user = new User();
  int year;
  int day;
  int month;
  String fecha;


  @override
  void initState() {
    year = int.parse(user.getBirthday.substring(0,4));
    month = int.parse(user.getBirthday.substring(6,7));
    day = int.parse(user.getBirthday.substring(8,10));
    fecha =formatDate(DateTime(year, month, day), [yy, '-', MM, '-', d]);
  }

  @override
  Widget build(BuildContext context) {
    return new Scaffold(
        drawer: MainDrawer(),
    appBar: AppBar(
    title: new Text('Perfil'),
    centerTitle: true,
    backgroundColor: Colors.orange,),
      body: Stack(
        children: <Widget>[
          Column(
            children: <Widget>[
              Flexible(
                flex: 1,
                child: Container(
                  decoration: BoxDecoration(
                      gradient: LinearGradient(colors: [
                        Colors.deepOrangeAccent,
                        Colors.orangeAccent
                      ])),
                ),
              ),

              Flexible(
                flex: 1,
                child: Container(
                  color: Colors.white,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: <Widget>[

                      Container(
                        height: 150.0,
                      ),
                    ],
                  ),
                ),
              )
            ],
          ),
          Positioned(
            top: MediaQuery.of(context).size.height / 2 - 140.0,
            left: 12.0,
            right: 12.0,
            child: Container(
                height: 150.0,
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
                            left: 28.0, right: 28.0, top: 40.0,),
                        child: Text('${user.getName} ${user.getLast_Name}',style: TextStyle(fontWeight: FontWeight.bold,fontSize: 30, color: Colors.orange),)
                      ),
                      Padding(
                        padding: const EdgeInsets.only(
                            left: 28.0, right: 28.0, top: 15.0),
                        child: Text('${fecha}',style: TextStyle(fontWeight: FontWeight.bold,))
                      ),
                    ],
                  ),
                )),
          ),
          Positioned(
            right: 24.0,
            left: 24.0,
            top: MediaQuery
                .of(context)
                .size
                .height / 2 - 80.0 + 90.0 - 30.0,
            child: InkWell(
              onTap: () {
                Navigator.of(context).pushNamed('/changePassword');
              },

              child: Container(
                height: 60.0,
                width: MediaQuery
                    .of(context)
                    .size
                    .width - 48.0,
                margin: EdgeInsets.only(left: 24.0, right: 24.0),
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.all(Radius.circular(30.0)),
                    gradient: LinearGradient(colors: [
                      Colors.deepOrangeAccent,
                      Colors.orangeAccent
                    ])),
                alignment: Alignment.center,
                child: Text(
                  "Cambiar contraseña",
                  style: TextStyle(color: Colors.white, fontSize: 22.0),
                ),
              ),
            ),
          ),
          Positioned(
            right: 24.0,
            left: 24.0,
            bottom: 320,
            child: CircleAvatar(
              radius: 75.0,
              child: new Image.asset("assets/user/${user.getGender}.png",
                width: 200,
                height: 200,),
            ),
          ),

          Positioned(
            right: 50.0,
            left: 50.0,
            height: 55,
            top: MediaQuery
                .of(context)
                .size
                .height / 2 - 80.0 + 180.0 - 30.0,
            child:  OutlineButton(
              child: Text('Cerrar Sesión',
              style: TextStyle(fontWeight: FontWeight.bold,
              color: Colors.orange,fontSize: 20),),
              shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(30)),
              borderSide: BorderSide(
                style: BorderStyle.solid, //Style of the border
                width: 1.8, //width of the border
                color: Colors.orange
              ),
              onPressed: (){
                _authController.signOut().then((_){
                  Navigator.pop(context);
                  Navigator.of(context).pushNamed('/sign-in');
                });
              },
            )
          ),
        ],
      ),
    );
  }


}