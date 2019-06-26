
import 'dart:async';

import 'package:connectivity/connectivity.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:prue/src/ui/purchase/history.dart';
import 'package:shared_preferences/shared_preferences.dart';

import './src/ui/auth/recovery.dart';
import './src/ui/auth/signIn.dart';
import './src/ui/auth/signUp.dart';
import './src/ui/auth/tutorial.dart';
import './src/ui/info/home.dart';
import './src/ui/info/about.dart';
import './src/ui/purchase/building.dart';
import './src/ui/purchase/products.dart';
import './src/ui/profile/profile.dart';
import './src/ui/profile/changePassword.dart';
import './src/ui/auth/verefication.dart';
import './src/models/token.model.dart';
import './src/widgets/order.dart';

String _connectionStatus = 'Unknown';
String tutorial = '';

Future<void> main() async {
  final prefs = await SharedPreferences.getInstance();
  TokenModel tokenModel = TokenModel();
  tokenModel.setToken(prefs.getString('access_token'));
  print(prefs.getString('access_token'));
  tutorial = prefs.getString('tutorial');
  print(prefs.getString('tutorial'));
  runApp(
    new MaterialApp(
      title: 'El niño de los burritos',
      debugShowCheckedModeBanner: false,
      //home: Verification(),
      home:(tokenModel.token  == null || tokenModel.token == "") ? SignIn() : (tokenModel.token  != null && tutorial == 'visto') ? Home() : Tutorial(),
      routes: <String, WidgetBuilder>{
        '/sign-in': (BuildContext context) => new SignIn(),
        '/home': (BuildContext context) => new Home(),
        '/sign-up': (BuildContext context) => new SignUp(),
        '/recovery': (BuildContext context) => new Recovery(),
        '/building': (BuildContext context) => new Buildind(),
        '/products': (BuildContext context) => new Products(),
        '/tutorial': (BuildContext context) => new Tutorial(),
        '/about': (BuildContext context) => new About(),
        '/profile': (BuildContext context) => new Profile(),
        '/changePassword': (BuildContext context) => new changePassword(),
        '/Verification': (BuildContext context) => new Verification(),
        '/history': (BuildContext context) => new History(),
        '/order' : (BuildContext context) => new Orders()
      },
    ),
  );
}