import 'package:flutter/material.dart';
import 'package:prue/src/models/produc.model.dart';
import 'package:prue/src/models/sale.dart';
import 'package:prue/src/widgets/stepperW.dart';
import '../../models/provisionDetails.dart';
import '../../bloc/purchaseController.dart';
import '../../models/cart.model.dart';
import 'dart:convert';

class Products extends StatefulWidget {
  @override
  _ProductsState createState() => _ProductsState();
}


class _ProductsState extends State<Products> {
  PurchaseController  purchaseController = new PurchaseController();
  CartModel cart = new CartModel();
  Sale sale = new Sale();
  List <ProvisionDetails> provisionDestils = new List();
  List <ProductModel> product = new List();




   @override
   void initState() {
     getProducts();
   }
   getProducts() async{
     print('sdasd');
     await purchaseController.getProducts().then((List<ProvisionDetails> provisionDestils){

       setState(() {
         this.provisionDestils = provisionDestils;
       });
       this.provisionDestils.forEach((provisionDestil){
         provisionDestil.product_place.product.provision_detail_id = provisionDestil.id;
         provisionDestil.product_place.product.product_place_id = provisionDestil.product_place_id;
         print('product place id ${provisionDestil.product_place.product.product_place_id}');
         print('provicion detail ${provisionDestil.product_place.product.provision_detail_id}');

         cart.setSeller_id = provisionDestil.provision.seller_id;
         setState(() {
           provisionDestil.product_place.product.value = 0;
         });
       });
     });
   }
   next(){
     Navigator.of(context).pushNamed('/payment');
   }
   prue(){
     var total = 0;
     product.clear();
     provisionDestils.forEach((provision){
       if(provision.product_place.product.value > 0 ){
         print('cost ${provision.product_place.cost}');
         product.add(provision.product_place.product);
         total = total + (provision.product_place.cost * provision.product_place.product.value);
         print('total: ${total}');
         cart.setTotal = total;
       }

       cart.setProducts = product;
       purchaseController.sale.place_id  = cart.getPlace_id;
       purchaseController.sale.employee_id = cart.getSeller_id;
       purchaseController.sale.payment_type = "Cash";
       purchaseController.sale.office_id = cart.getOffice_id;
       purchaseController.sale.products = cart.getProduct;
       purchaseController.sale.products.forEach((sale){
         sale.cost = provision.product_place.cost;
       });

     });
     print('id del lugar${purchaseController.sale.place_id}');
     print('id del empleado${purchaseController.sale.employee_id}');
     print('tipo de pago${purchaseController.sale.payment_type}');
     print('id de la oficina${purchaseController.sale.office_id}');

     purchaseController.sale.products.forEach((product){
       print(product.product_place_id);
       print(product.name);
       print(product.value);
       print(product.provision_detail_id);
     });
     Navigator.of(context).pushNamed('/payment');


  }
   @override
  Widget build(BuildContext context) {
     double width = MediaQuery.of(context).size.width;
     double height = MediaQuery.of(context).size.height;
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
                  itemCount: provisionDestils.length,
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
                               Text("${provisionDestils[index].availables}",style: TextStyle(fontSize: 40,),),
                               Text("Burritos restantes",textAlign: TextAlign.center,),
                             ],
                           ),
                         ),
                         Padding(padding: EdgeInsets.only(left: 5),
                           child: Column(
                             crossAxisAlignment: CrossAxisAlignment.start,
                             children: <Widget>[
                               Text('${provisionDestils[index].product_place.product.name}',
                                 style: TextStyle(fontWeight: FontWeight.bold,
                                   color: Colors.black,
                                   fontSize: 17,
                                 ),),
                               Padding(padding: EdgeInsets.only(top: 5)),
                               Text('${provisionDestils[index].product_place.product.description}'),
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
                                 onTap: (){

                                   if (provisionDestils[index].product_place.product.value < provisionDestils[index].availables) {
                                     setState(() {
                                       provisionDestils[index].product_place.product.value = provisionDestils[index].product_place.product.value + 1;
                                     });
                                   }
                                 },
                               ),
                               Text('${provisionDestils[index].product_place.product.value}',textAlign: TextAlign.center,
                                 style: TextStyle(
                                     fontSize: 15,
                                     color: Colors.black54
                                 ),),
                               GestureDetector(
                                 onTap: (){
                                  setState(() {
                                    if (provisionDestils[index].product_place.product.value > 0){
                                      provisionDestils[index].product_place.product.value = provisionDestils[index].product_place.product.value - 1;
                                    }
                                  });
                                 },
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
                          width: width/2.2,
                        ),
                        onTap: (){
                          prue();
                        },
                      ),
                      GestureDetector(
                        onTap: next,
                        child: Container(
                          margin: EdgeInsets.only(left: 10),
                          color: Colors.orange,
                          child: Center(
                            child: Text('Elegir metodo de pago',
                              style: TextStyle(
                                  color: Colors.white,
                                  fontSize: 15,
                                  fontWeight: FontWeight.bold
                              ),),
                          ),
                          height: 50,
                          width: width/2.2,
                        ),
                      ),
                    ],
                  ),
                )
            )
          ],
        ),
     )
    );
  }
}



