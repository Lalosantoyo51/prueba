import 'package:flutter/material.dart';
import 'package:prue/src/bloc/purchaseController.dart';
import 'package:prue/src/models/cart.model.dart';
import 'package:prue/src/models/sale.dart';
import 'package:prue/src/widgets/loadingAlert.dart';
import 'package:prue/src/widgets/menu.dart';
import 'package:prue/src/widgets/stepperW.dart';
import 'package:intl/intl.dart';



class Confirm extends StatefulWidget {
  @override
  _ConfirmState createState() => _ConfirmState();
}

class _ConfirmState extends State<Confirm> {
  PurchaseController  purchaseController = new PurchaseController();
  CartModel cart = new CartModel();
  Sale sale = new Sale();
  final formatter = new NumberFormat("0.00");
  var loadingContext;

  closeAlert(BuildContext _context) {
    Navigator.of(_context).pop();
  }

  goToBack(){
    Navigator.pop(context);
  }
  Future buy(){
    purchaseController.createOrder().then((Sale sale){
      loading();
      print('compra realizada');
        Navigator.of(context).pushNamedAndRemoveUntil("/home",  (Route<dynamic> route) => false);

    });
  }
  loading() async{
    await showDialog(
        context: context,
        builder: (context) {
          loadingContext = context;
          return LoadingAlert('Creando compra...');
        });
  }



  @override
    Widget build(BuildContext context) {
      double width = MediaQuery
          .of(context)
          .size
          .width;
      double height = MediaQuery
          .of(context)
          .size
          .height;
      return Scaffold(
          appBar: AppBar(
            title: new Text('Confirmar'),
            centerTitle: true,
            backgroundColor: Colors.orange,
          ),
          drawer: MainDrawer(),
          body: Theme(
              data: ThemeData(primaryColor: Colors.orange),
              child: Stack(
                  children: <Widget>[
                    Padding(
                      padding: EdgeInsets.only(top: 20),
                      child: StepperW(4),
                    ),
                    Padding(
                      padding: EdgeInsets.only(
                          top: 90, left: 10, right: 10, bottom: height / 4),
                      child: Container(
                        width: width,
                        child: Card(
                            elevation: 5.0,
                            child: Stack(
                              children: <Widget>[
                                Padding(
                                  padding:
                                  EdgeInsets.only(top: 15, left: 10, right: 10),
                                  child: Row(
                                    mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                    mainAxisSize: MainAxisSize.max,
                                    crossAxisAlignment: CrossAxisAlignment
                                        .center,
                                    children: <Widget>[
                                      Container(
                                        width: width / 5,
                                        child: Text(
                                          'Cantidad',
                                          textAlign: TextAlign.center,
                                          style: TextStyle(
                                              fontWeight: FontWeight.bold),
                                        ),
                                      ),
                                      Container(
                                        width: width / 5,
                                        child: Text('Producto',
                                            textAlign: TextAlign.center,
                                            style: TextStyle(
                                                fontWeight: FontWeight.bold)),
                                      ),
                                      Container(
                                        width: width / 5,
                                        child: Text('Pre. Unit',
                                            textAlign: TextAlign.center,
                                            style: TextStyle(
                                                fontWeight: FontWeight.bold)),
                                      ),
                                      Container(
                                        width: width / 5,
                                        child: Text('Importe',
                                            textAlign: TextAlign.center,
                                            style: TextStyle(
                                                fontWeight: FontWeight.bold)),
                                      ),
                                    ],
                                  ),
                                ),
                                Padding(
                                  padding: EdgeInsets.only(top: 45, bottom: 50),
                                  child:
                                  ListView.builder(
                                      itemCount: cart.cart.products.length,
                                      itemBuilder: (BuildContext context,
                                          int index) {
                                        return Padding(
                                          padding:
                                          EdgeInsets.only(
                                              top: 5, left: 10, right: 10),
                                          child:
                                          Column(
                                            children: <Widget>[
                                              Row(
                                                mainAxisSize: MainAxisSize.max,
                                                crossAxisAlignment:
                                                CrossAxisAlignment.center,
                                                mainAxisAlignment:
                                                MainAxisAlignment.spaceBetween,
                                                children: <Widget>[
                                                  Container(
                                                    width: width / 5,
                                                    child: Text(
                                                      '${cart.cart
                                                          .products[index]
                                                          .value}',
                                                      textAlign: TextAlign
                                                          .center,
                                                    ),
                                                  ),
                                                  Container(
                                                    width: width / 5,
                                                    child: Text(
                                                      '${cart.cart
                                                          .products[index]
                                                          .name}',
                                                      textAlign: TextAlign
                                                          .center,
                                                    ),
                                                  ),
                                                  Container(
                                                    width: width / 5,
                                                    child: Text(
                                                      r'$' + "${formatter.format(cart.cart
                                                          .products[index]
                                                          .cost)}",
                                                      textAlign: TextAlign
                                                          .center,
                                                    ),
                                                  ),
                                                  Container(
                                                    width: width / 5,
                                                    child: Text(
                                                      r'$' + "${formatter.format(cart.cart
                                                          .products[index]
                                                          .cost * cart.cart.products[index].value)}",
                                                      textAlign: TextAlign
                                                          .center,
                                                    ),
                                                  ),
                                                ],
                                              ),
                                              Padding(padding: EdgeInsets.only(
                                                  top: 1)),
                                            ],
                                          ),
                                        );
                                      }),
                                ),
                                Padding(padding: EdgeInsets.only(
                                    top: height / 2.4, left: 20, right: 20),
                                    child: Column(
                                      children: <Widget>[
                                        Container(
                                          height: 1, color: Colors.black26,),
                                        Padding(
                                            padding: EdgeInsets.only(top: 10)),
                                        Container(width: width,
                                          child: Text(r'Total $' +
                                              '${formatter.format(
                                                  cart.getTotal)}',
                                            style: TextStyle(
                                                fontSize: height / 32,
                                                fontWeight: FontWeight.bold,
                                                color: Colors.orange
                                            ),
                                            textAlign: TextAlign.right,
                                          ),)
                                      ],
                                    ))
                              ],
                            )),
                      ),
                    ),
                    Positioned(
                        bottom: 5,
                        left: 5,
                        right: 5,
                        child: Container(
                          width: width,
                          child: Row(
                            crossAxisAlignment: CrossAxisAlignment.center,
                            mainAxisSize: MainAxisSize.max,
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: <Widget>[
                              GestureDetector(
                                child: Container(
                                  color: Colors.orange,
                                  child: Center(
                                    child: Text('Cancelar',
                                      style: TextStyle(
                                          color: Colors.white,
                                          fontSize: 15,
                                          fontWeight: FontWeight.bold
                                      ),),
                                  ),
                                  height: 50,
                                  width: width / 2.2,
                                ),
                                onTap:goToBack,
                              ),
                              GestureDetector(
                                child: Container(
                                  margin: EdgeInsets.only(left: 10),
                                  color: Colors.green,
                                  child: Center(
                                    child: Text('Confirmar',
                                      style: TextStyle(
                                          color: Colors.white,
                                          fontSize: 15,
                                          fontWeight: FontWeight.bold
                                      ),),
                                  ),
                                  height: 50,
                                  width: width / 2.2,
                                ),
                                onTap: (){
                                  showDialog(
                                      context: context,
                                      builder: (context) {
                                        loadingContext = context;
                                        return LoadingAlert('Realizando tu compra...');
                                      });
                                  buy();
                                },
                              ),

                            ],
                          ),
                        )
                    )
                  ])
          ));

  }
}