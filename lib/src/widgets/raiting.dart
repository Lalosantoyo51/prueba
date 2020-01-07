import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:prue/src/bloc/purchaseController.dart';
import 'package:smooth_star_rating/smooth_star_rating.dart';
import 'package:intl/intl.dart';
import 'package:intl/intl.dart';
import 'package:intl/date_symbol_data_local.dart';

class MyDialog extends StatefulWidget {
  String date;
  String employye;
  String employye_lastname;
  int folio;
  @override
  MyDialog(this.employye,this.folio,this.date);
  _MyDialogState createState() => new _MyDialogState();
}

class _MyDialogState extends State<MyDialog> {
  PurchaseController purchaseController = new PurchaseController();
  double rating = 0.0;
  DateFormat dateFormat;


  @override
  void initState() {
    initializeDateFormatting();
    dateFormat = new DateFormat.yMMMMd('es');

  }

  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    double height = MediaQuery.of(context).size.height;
    return AlertDialog(
      title: Container(
        width: width,
        child: Text('Calificar',textAlign: TextAlign.center,),
      ),
      content: Container(
        height: height/4,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: <Widget>[
            Container(
              width: width,
              child:Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  Text('Vendedor: ',style: TextStyle(fontWeight: FontWeight.bold)),
                  Text('${widget.employye}'),
                ],
              ),
            ),
            Container(
              width: width,
              child:Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  Text('Folio: #', style: TextStyle(fontWeight: FontWeight.bold),),
                  Text('${widget.folio}'),
                ],
              ),
            ),
            Container(
              width: width,
              child:Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  Text('Fecha ', style: TextStyle(fontWeight: FontWeight.bold),),
                  Text('${dateFormat.format(new DateFormat(
                      "yyyy-MM-dd HH:mm:ss")
                      .parse(widget.date.toString()))}'),
                ],
              ),
            ),

            SmoothStarRating(
              rating: rating,
              size: 45,
              starCount: 5,
              spacing: 2.0,
              color: Colors.orange,
              borderColor: Colors.orange,
              onRatingChanged: (value) {
                setState(() {
                  rating = value;
                });
              },
            ),
               TextField(
              maxLines: null,
              keyboardType: TextInputType.multiline,
              decoration: new InputDecoration(
                hintText: 'Comentarios',
              ),
              onChanged: (value){
                if(value.length ==0 ){
                  purchaseController.comment = null;
                }else {
                  purchaseController.comment = value;
                }

              },
            ),
          ],
        ),
      ),
      actions: <Widget>[
        FlatButton(
            child: Text('Calificar'),
            onPressed:(){

            })
      ],
    );
  }
}