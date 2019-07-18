import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:prue/src/bloc/authController.dart';
import 'package:prue/src/models/cart.model.dart';
import 'package:prue/src/models/user.model.dart';
import '../resource/auth.service.dart';
import '../models/Userget.dart';

class MainDrawer extends StatefulWidget {
  @override
  _MainDrawerState createState() => _MainDrawerState();
}

class _MainDrawerState extends State<MainDrawer> {
  AuthService _authService = new AuthService();
  AuthCOntroller _authCOntroller = new AuthCOntroller();
  CartModel cart = new CartModel();

  User user = new User();
  bool isLoading = true;

  IconData profile = const IconData(
      0xf47d,
      fontFamily: CupertinoIcons.iconFont,
      fontPackage: CupertinoIcons.iconFontPackage);

  IconData home = const IconData(
      0xf447,
      fontFamily: CupertinoIcons.iconFont,
      fontPackage: CupertinoIcons.iconFontPackage);

  IconData categories = const IconData(
      0xf453,
      fontFamily: CupertinoIcons.iconFont,
      fontPackage: CupertinoIcons.iconFontPackage);


  IconData history = const IconData(
      0xf402,
      fontFamily: CupertinoIcons.iconFont,
      fontPackage: CupertinoIcons.iconFontPackage);
  IconData myPlaces = const IconData(
      0xf455,
      fontFamily: CupertinoIcons.iconFont,
      fontPackage: CupertinoIcons.iconFontPackage);

  IconData about = const IconData(
      0xf44c,
      fontFamily: CupertinoIcons.iconFont,
      fontPackage: CupertinoIcons.iconFontPackage);



  @override
  void initState() {
    super.initState();
    if(user.getName == null){
      _authCOntroller.getUser().then((UserModel userModel){
        user.setName = userModel.name;
        user.setGender = userModel.gender;
        user.setBirthday = userModel.birthday;
        user.setPhone = userModel.phone;
        user.setLast_Name = userModel.last_name;
        user.setUser_id = userModel.id;
        print(userModel.gender);
      });
    }
    if (user.getName != null){
      isLoading = false;
    }
  }

  @override
  Widget build(BuildContext context) {
    final drawerHeader = DrawerHeader(
      decoration: BoxDecoration(color: Colors.orange),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: <Widget>[
          Container(
            padding: EdgeInsets.fromLTRB(0, 0, 150, 0),
            child: isLoading
                ? Container()
                : CircleAvatar(
                radius: 40.0,
                child: new Image.asset("assets/user/${user.getGender}.png",
                  width: 200,
                  height: 200,),
            ),
          ),
          Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              isLoading
                  ? CircularProgressIndicator()
                  : Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisSize: MainAxisSize.min,
                children: <Widget>[
                  Text(
                    '${user.getName} ${user.getLast_Name}',
                    style: TextStyle(
                        fontSize: 18, fontWeight: FontWeight.bold,color:Colors.white),
                  ),
                  Container(
                    padding: EdgeInsets.fromLTRB(0, 0, 150, 0),
                    child: Text(
                      '${user.getPhone}',
                      style: TextStyle(
                          fontSize: 18, fontWeight: FontWeight.bold,color:Colors.white),
                    ),
                  )
                ],
              ),
            ],
          ),
        ],
      ),
    );

    Widget createDrawerItems(String text, IconData icon, String route) {
      return ListTile(
          contentPadding: EdgeInsets.symmetric(vertical: 3, horizontal: 25),
          title: Text(text, style: TextStyle(fontSize: 15.0, color: Colors.black, fontWeight: FontWeight.w300), ),
          leading: Icon(icon, size: 25.0,),
          onTap: () {
            Navigator.pushReplacementNamed(context, route);
          });
    }

    final drawerItems = ListView(
      children: <Widget>[
        createDrawerItems("Inicio", home, '/home'),
        createDrawerItems("Historial", history, '/history'),
        createDrawerItems("Mi perfil", profile, '/profile'),
        cart.getAreaType == 'Street' ?
        createDrawerItems("Mis lugares ",myPlaces , '/about') : Container(),
        createDrawerItems("Acerca de ", about, '/about'),


      ],
    );

    return Drawer(
        elevation: 20,
        child: Column(
          children: <Widget>[drawerHeader, Expanded(child: drawerItems)],
        ));
  }
}