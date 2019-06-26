import 'package:flutter/material.dart';
import '../models/purchase.model.dart';


class Orders extends StatefulWidget {
  PurchaseModel purchase = new PurchaseModel();
  String title;
  String image;
  Orders({Key key, this.purchase,this.title,this.image}): super(key:key);
  @override
  _OrdersState createState() => _OrdersState();
}

class _OrdersState extends State<Orders> {
  @override
  // TODO: implement widget
  Orders get widget => super.widget;


  @override
  void initState() {
    print(widget.purchase.id);
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Card(
        child: ListView(
          children: <Widget>[
            Text("${widget.purchase.id}"),
            Text("${widget.purchase.cost}"),
            Text("${widget.purchase.place.name}"),
          ],
        ),
      )
    );
  }
}
