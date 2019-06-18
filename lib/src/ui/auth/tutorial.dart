import 'package:flutter/material.dart';
import 'package:intro_views_flutter/Models/page_view_model.dart';
import 'package:intro_views_flutter/intro_views_flutter.dart';
import 'package:prue/src/ui/info/home.dart';
import 'package:shared_preferences/shared_preferences.dart';


class Tutorial extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    String tutorial = '';
    goToHome() async{
      var prefs = await SharedPreferences.getInstance();
      tutorial = 'visto';
      prefs.setString('tutorial', tutorial);
      Navigator.pop(context);
      Navigator.of(context).pushNamed("/home");
    }

    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: '', //title of app
      home: Builder(
        builder: (context) => IntroViewsFlutter(
          pages,
          onTapDoneButton: () {
            goToHome();
          },
          pageButtonTextStyles: TextStyle(
            color: Colors.orange,
            fontSize: 18.0,

          ),
        ), //IntroViewsFlutter
      ), //Builder
    ); //Material App
  }
}

final pages = [
  PageViewModel(
      pageColor: const Color(0xFFFFF9C4),
      bubbleBackgroundColor: Colors.orange.shade300,
      body: Text(
          'Incluimos servicio de geolocalización para darte un servicio puntal. ¡Activa tu GPS!'),
      title: Text(''),
      textStyle: TextStyle(fontFamily: 'MyFont', color: Colors.black,fontSize: 20),
      mainImage: Image.asset(
        'assets/tutorial/5.png',
        height: 285.0,
        width: 285.0,
        alignment: Alignment.center,
      )),
  PageViewModel(
    pageColor: const Color(0xFFFFF9C4),
    bubbleBackgroundColor: Colors.orange.shade300,
    body: Text(
      'Dentro de la app podrás realizar compras de deproductos de una manera fácil y amigable.',
    ),
    title: Text(''),
    mainImage: Image.asset(
      'assets/tutorial/1.png',
      height: 285.0,
      width: 285.0,
      alignment: Alignment.center,
    ),
    textStyle: TextStyle(fontFamily: 'MyFont', color: Colors.black,fontSize: 20),
  ),
  PageViewModel(
    pageColor: const Color(0xFFFFF9C4),
    bubbleBackgroundColor: Colors.orange.shade300,
    body: Text(
      'Consulta toda la información de tus compras de una manera rápida y sencilla.',
    ),
    title: Text(''),
    mainImage: Image.asset(
      'assets/tutorial/4.png',
      height: 285.0,
      width: 285.0,
      alignment: Alignment.center,
    ),
    textStyle: TextStyle(fontFamily: 'MyFont', color: Colors.black,fontSize: 20),
  ),
  PageViewModel(
    pageColor: const Color(0xFFFFF9C4),
    bubbleBackgroundColor: Colors.orange.shade300,
    body: Text(
      'Ahora podrás darnos retroalimentación y valorar nuestro servicio. ¡Nuestra mejora continua depende de todos!',
    ),
    title: Text(''),
    mainImage: Image.asset(
      'assets/tutorial/2.png',
      height: 285.0,
      width: 285.0,
      alignment: Alignment.center,
    ),
    textStyle: TextStyle(fontFamily: 'MyFont', color: Colors.black,fontSize: 20),
  ),
];

