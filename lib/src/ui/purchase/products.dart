import 'package:flutter/material.dart';
import '../../models/provision.dart';
import '../../bloc/purchaseController.dart';
import '../../models/cart.model.dart';

class Products extends StatefulWidget {
  @override
  _ProductsState createState() => _ProductsState();
}


class _ProductsState extends State<Products> {
  PurchaseController  _purchaseController = new PurchaseController();
  List <Provision> provision;
  CartModel _cartModel = new CartModel();

   @override
   void initState() {
     print("no funco :C${_cartModel.gethola}");
   }

   @override
  Widget build(BuildContext context) {
    return new Scaffold(
        appBar: AppBar(
          title: new Text('inicio'),
          centerTitle: true,
          backgroundColor: Colors.orange,
        ),

    );
  }
}



