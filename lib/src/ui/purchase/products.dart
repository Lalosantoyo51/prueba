import 'package:flutter/material.dart';
import 'package:prue/src/widgets/stepperW.dart';
import '../../models/provision.dart';
import '../../bloc/purchaseController.dart';
import '../../models/cart.model.dart';

class Products extends StatefulWidget {
  @override
  _ProductsState createState() => _ProductsState();
}


class _ProductsState extends State<Products> {
  PurchaseController  _purchaseController = new PurchaseController();
  CartModel _cartModel = new CartModel();
  List <Provision> provision = new List();



   @override
   void initState() {
     getProducts();
   }
   getProducts() async{
     print('sdasd');
     await _purchaseController.getProducts().then((List<Provision> provisions){
       setState(() {
         this.provision = provisions;
       });
       this.provision.forEach((provison){
         print(provison.product_place.product.name);
       });
     });
   }

   @override
  Widget build(BuildContext context) {
    return new Scaffold(
        appBar: AppBar(
          title: new Text('inicio'),
          centerTitle: true,
          backgroundColor: Colors.orange,
        ),
      body:Theme(
          data: ThemeData(
              primaryColor: Colors.orange
          ),
        child: Stack(
          children: <Widget>[
            Padding(padding: EdgeInsets.only(top: 20),child: StepperW(2),),
            Padding(padding: EdgeInsets.only(top: 90,bottom: 90),
              child:ListView.builder(
                  itemCount: provision.length,
                  itemBuilder: (BuildContext context, int index){
                return Padding(padding: EdgeInsets.only(top: 10),
                child: Card(
                  margin: EdgeInsets.only(left: 10,right: 10),
                  elevation: 3.0,
                  child: Stack(
                   children: <Widget>[

                     Row(
                       children: <Widget>[
                         Container(
                           width: 90,
                           height: 100,
                           color: Colors.orange.shade50,
                           child: Column(
                             children: <Widget>[
                               Text("${provision[index].quantity}",style: TextStyle(fontSize: 40,),),
                               Text("Burritos restantes",textAlign: TextAlign.center,),
                             ],
                           ),
                         ),
                         Padding(padding: EdgeInsets.only(left: 5),
                           child: Column(
                             crossAxisAlignment: CrossAxisAlignment.start,
                             children: <Widget>[
                               Text('${provision[index].product_place.product.name}',
                                 style: TextStyle(fontWeight: FontWeight.bold,
                                   color: Colors.black,
                                   fontSize: 17,
                                 ),),
                               Padding(padding: EdgeInsets.only(top: 5)),
                               Text('${provision[index].product_place.product.description}'),
                               Padding(padding: EdgeInsets.only(top: 30)),
                               Text(r'$16.00',style: TextStyle(fontSize: 17,
                                   color: Colors.orange,
                                   fontWeight: FontWeight.w600
                               ),),
                             ],
                           ),),
                       ],
                     ),
                     Positioned(
                       right: 0.0,
                         child: Container(
                           decoration: BoxDecoration(border: Border.all(color: Colors.black26)),
                           height: 100,
                           child: Column(
                             mainAxisSize: MainAxisSize.max,
                             crossAxisAlignment: CrossAxisAlignment.center,
                             mainAxisAlignment: MainAxisAlignment.center,
                             children: <Widget>[
                               GestureDetector(
                                 child: Text('+',textAlign: TextAlign.center,
                                     style: TextStyle(
                                         fontSize: 30,
                                         fontWeight: FontWeight.w500,
                                         color: Colors.black54
                                     )
                                 ),
                               ),
                               Text('0',textAlign: TextAlign.center,
                                 style: TextStyle(
                                     fontSize: 15,
                                     color: Colors.black54
                                 ),),
                               GestureDetector(
                                   child: Icon(Icons.remove,size: 34,
                                       color: Colors.black54)
                               ),
                             ],
                           ),
                         ))
                   ],
                  ),
                ),);
              }),
            ),
            Positioned(
                bottom: 5,
                left: 5,
                right: 5,
                child: Row(
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
                        width: 150,
                        height: 50,
                      ),
                      onTap: (){
                        //goToNext();
                      },
                    ),
                    GestureDetector(
                      child: Container(
                        margin: EdgeInsets.only(left: 50),
                        color: Colors.orange,
                        child: Center(
                          child: Text('Elegir productos',
                            style: TextStyle(
                                color: Colors.white,
                                fontSize: 15,
                                fontWeight: FontWeight.bold
                            ),),
                        ),
                        width: 150,
                        height: 50,
                      ),
                    ),

                  ],
                )
            )
          ],
        ),
     )
    );
  }
}



