import 'package:flutter/material.dart';
import 'package:prue/src/models/cart.model.dart';
import 'package:prue/src/widgets/menu.dart';
import 'package:prue/src/widgets/stepperW.dart';
import 'package:intl/intl.dart';


class Payment extends StatefulWidget {
  @override
  _PaymentState createState() => _PaymentState();
}

class _PaymentState extends State<Payment> {
  CartModel cart = new CartModel();
  final formatter = new NumberFormat("0.00");

  goTONext(){
    Navigator.of(context).pushNamed('/confirm');
  }
  goToBack(){
    Navigator.pop(context);
  }

  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    double height = MediaQuery.of(context).size.height;
    return Scaffold(
        appBar: AppBar(
          title: new Text('Metodo de pago'),
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
                  child: StepperW(3),
                ),
                Padding(
                    padding: EdgeInsets.only(
                        top: 90, left: 10, right: 10, bottom: height / 4),
                    child: Container(
                      width: width,
                      child: Card(
                        elevation: 5.0,
                        child: Row(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          mainAxisAlignment: MainAxisAlignment.spaceAround,
                          mainAxisSize: MainAxisSize.max,
                          children: <Widget>[
                            GestureDetector(
                              child: Text('Efectivo'),
                            ),
                            GestureDetector(
                              child: Text('Tarjeta'),
                            ),
                          ],
                        ),
                      ),
                    )),
                Padding(
                    padding: EdgeInsets.only(
                        top: 150, left: 10, right: 10, bottom: height / 4),
                    child: Container(
                      width: width,
                      child: Card(
                        elevation: 5.0,

                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: <Widget>[
                            Text(r"Cantidad a pagar: $" + "${formatter.format(cart.getTotal)}"),
                            Container(
                              width: width/1.3,
                              child: Text('Prepara tu efectivo y entregalo al vendedor una vez te sea llevado el pedido.',),
                            )
                          ],
                        ),
                      ),
                    )),
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
                            onTap: goToBack,
                          ),
                          GestureDetector(
                            onTap: goTONext,
                            child: Container(
                              margin: EdgeInsets.only(left: 10),
                              color: Colors.orange,
                              child: Center(
                                child: Text('Verificar compra',
                                  style: TextStyle(
                                      color: Colors.white,
                                      fontSize: 15,
                                      fontWeight: FontWeight.bold
                                  ),),
                              ),
                              height: 50,
                              width: width / 2.2,
                            ),
                          ),
                        ],
                      ),
                    )
                )
              ])
        ));
  }
}
