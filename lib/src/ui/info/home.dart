import 'package:flutter/material.dart';
import 'package:prue/src/bloc/purchaseController.dart';
import 'package:prue/src/models/area.model.dart';
import 'package:prue/src/models/areaResponse.dart';
import 'package:prue/src/models/purchase.model.dart';
import 'package:prue/src/models/sale-details-model.dart';
import '../../bloc/location.controller.dart';
import '../../bloc/authController.dart';
import '../../models/messageResponse.dart';
import '../../models/areaResponse.dart';
import '../../models/buildingResponse.dart';
import '../../widgets/menu.dart';
import '../../models/user.model.dart';
import '../../models/Userget.dart';
import 'package:intl/intl.dart';
import 'package:intl/date_symbol_data_local.dart';

class Home extends StatefulWidget {
  List<PurchaseModel> purchaseModel = new List();
  Home({Key key, this.purchaseModel}) : super(key: key);
  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {
  final GlobalKey<ScaffoldState> _scaffoldKey = new GlobalKey<ScaffoldState>();
  final formatter = new NumberFormat("0.00");

  locationController _locationController = new locationController();
  AuthCOntroller _authController = new AuthCOntroller();
  PurchaseController purchaseController = new PurchaseController();
  ScrollController _scrollController = new ScrollController();
  User user = new User();
  List<PurchaseModel> purchaseModel = new List();
  List<SaleDetailsModel> sale = new List();
  List src = new List();
  List titles = new List();
  List<SaleDetailsModel> saleDatails = new List();
  List types = [];
  String message;
  String area_type;
  DateFormat dateFormat;

  Future zoneOut() async{
    _scaffoldKey.currentState.showSnackBar(
        SnackBar(content: Text("No se te encuentras en zona burrera"),backgroundColor: Colors.red.shade400,));
  }

  @override
  void initState() {
    if(user.getName == null){
      _authController.getUser().then((UserModel userModel){
        user.setName = userModel.name;
        user.setGender = userModel.gender;
        user.setBirthday = userModel.birthday;
        user.setPhone = userModel.phone;
        user.setLast_Name = userModel.last_name;
        user.setUser_id = userModel.id;
        print(userModel.gender);
      });
    }
    _locationController.getlocation().then((_){
      print('nose que sea ${_[0]['latitude']}');
      _locationController.areaModel.lat = _[0]['latitude'];
      _locationController.areaModel.lng = _[0]['longitude'];
      _locationController.getCurrentPlace().then((AreaModel areaModel){
        print(areaModel.type);
        area_type = areaModel.type;
        _locationController.setMessage().then((MessageResponse messageModel){
          setState(() {
            message = messageModel.results.message;
          });
        });
      }).catchError((e){
        new Future.delayed(Duration.zero,() {
          zoneOut();
        });

      });
    });
    getPurchase();
  }

  contains(a, b) {
    for (var i = 0; i < a.length; i++) {
      if (a[i] == b) return true;
    }
    return false;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Inicio'),
        centerTitle: true,
        backgroundColor: Colors.orange,
      ),
      drawer: MainDrawer(),
      body: Stack(
        children: <Widget>[
          Container(
            child: ListView.builder(
              controller: _scrollController,
              itemCount: purchaseModel.length,
              itemBuilder: (BuildContext context, int index) {
                return Container(
                    child: Padding(
                        padding: EdgeInsets.only(left: 20, right: 20, top: 10),
                        child: Card(
                            child: Stack(
                              children: <Widget>[
                                Image.asset(
                                  "assets/orders/${src[index]}",
                                  width: 100,
                                ),
                                Padding(
                                  padding: EdgeInsets.only(
                                    top: 10,
                                    left: 110,
                                  ),
                                  child: Column(
                                    children: <Widget>[
                                      Center(
                                          child: Align(
                                            child: Text(
                                              '${titles[index]}',
                                              style: TextStyle(
                                                  fontSize: 20, color: Colors.black),
                                            ),
                                            alignment: Alignment.topLeft,
                                          )),
                                      Align(
                                        alignment: Alignment.topLeft,
                                        child: Text(
                                          'Pedido #${purchaseModel[index].id + 1000}',
                                          style: TextStyle(color: Colors.black38),
                                        ),
                                      ),
                                      Align(
                                        alignment: Alignment.topLeft,
                                        child: Text(
                                          dateFormat.format(new DateFormat(
                                              "yyyy-MM-dd HH:mm:ss")
                                              .parse(
                                              purchaseModel[index].created_at)),
                                          style: TextStyle(color: Colors.black54),
                                        ),
                                      ) , purchaseModel[index].status == 'Order' ?
                                      Align(
                                        alignment: Alignment.topLeft,
                                        child: Text('Orden Activa',
                                          style: TextStyle(color: Colors.black38),),
                                      ): purchaseModel[index].status == 'Delivered' ?
                                      Align(
                                        alignment: Alignment.topLeft,
                                        child: Text('Orden completa',
                                          style: TextStyle(color: Colors.black38),),
                                      ):purchaseModel[index].status =='Rejected' ?
                                      Align(
                                        alignment: Alignment.topLeft,
                                        child: Text('Orden cancelada',
                                          style: TextStyle(color: Colors.black38),),
                                      ):
                                      Container(),
                                      purchaseModel[index].place_user.name == null && purchaseModel[index].offices.name != null  ?
                                      Align(
                                          alignment: Alignment.topLeft,
                                          child:
                                          Text('${purchaseModel[index].offices.buildin.name} ${purchaseModel[index].offices.name}',
                                            style: TextStyle(color: Colors.black38),)
                                      ):purchaseModel[index].place_user.name != null && purchaseModel[index].offices.name == null  ?
                                      Align(
                                          alignment: Alignment.topLeft,
                                          child:
                                          Text('${purchaseModel[index].place_user.name} ',
                                            style: TextStyle(color: Colors.black38),)
                                      ):Align(
                                          alignment: Alignment.topLeft,
                                          child:
                                          Text('tu ubicacion actual',
                                            style: TextStyle(color: Colors.black38),)
                                      )
                                    ],
                                  ),
                                ),
                                Padding(
                                    padding: EdgeInsets.only(
                                        top: 110, left: 10, right: 10),
                                    child: Container(
                                      height: 1,
                                      width: 300,
                                      color: Colors.black12,
                                    )),
                                Padding(
                                    padding: EdgeInsets.only(
                                        top: 110, left: 15, right: 10),
                                    child: Row(
                                      children: <Widget>[
                                        Padding(
                                          padding: EdgeInsets.only(
                                            top: 20,
                                            bottom: 20,
                                          ),
                                          child: Text(r"$",
                                              style: TextStyle(
                                                  fontSize: 25,
                                                  color: Colors.orange,
                                                  fontWeight: FontWeight.bold)),
                                        ),
                                        Text(
                                            '${formatter.format(purchaseModel[index].cost)}',
                                            style: TextStyle(
                                                fontSize: 25,
                                                color: Colors.orange,
                                                fontWeight: FontWeight.bold)),
                                        purchaseModel[index].status == 'Delivered' && purchaseModel[index].qualified_by_customer == 'Unrated' ?
                                        Padding(
                                            padding: EdgeInsets.only(left: 10),
                                            child: FlatButton(
                                              child: Icon(
                                                Icons.star,
                                                color: Colors.orange,
                                              ),)):Padding(
                                            padding: EdgeInsets.only(left: 10),
                                            child: FlatButton(
                                              child: Container(),)),
                                        Padding(
                                            padding: EdgeInsets.only(left: 10),
                                            child: FlatButton(
                                                child: Icon(
                                                  Icons.info_outline,
                                                  color: Colors.orange,
                                                ),
                                                color: Colors.white,
                                                onPressed: () {
                                                  sale = [];
                                                  sale = purchaseModel[index]
                                                      .sale_details;
                                                  showDialog(
                                                      context: context,
                                                      builder:
                                                          (BuildContext context) {
                                                        return AlertDialog(
                                                            title: Image.asset(
                                                              "assets/orders/${src[index]}",
                                                              height: 100,
                                                            ),
                                                            content: Container(
                                                              height: 200,
                                                              child: Column(
                                                                children: <Widget>[
                                                                  Text(
                                                                    '${titles[index]}',
                                                                    style: TextStyle(
                                                                        fontSize:
                                                                        20,
                                                                        color: Colors
                                                                            .black),
                                                                  ),
                                                                  Padding(
                                                                      padding:
                                                                      EdgeInsets
                                                                          .only(
                                                                          top: 10)),
                                                                  Row(
                                                                    children: <
                                                                        Widget>[
                                                                      Align(
                                                                        alignment:
                                                                        Alignment
                                                                            .topLeft,
                                                                        child: Text(
                                                                          'Cantidad',
                                                                          style: Theme.of(
                                                                              context)
                                                                              .primaryTextTheme
                                                                              .caption
                                                                              .copyWith(
                                                                              color: Colors.black),
                                                                          overflow:
                                                                          TextOverflow
                                                                              .ellipsis,
                                                                        ),
                                                                      ),
                                                                      Padding(
                                                                        padding: EdgeInsets
                                                                            .only(
                                                                            left:
                                                                            40),
                                                                        child:
                                                                        Align(
                                                                          alignment:
                                                                          Alignment
                                                                              .topLeft,
                                                                          child:
                                                                          Text(
                                                                            'Producto',
                                                                            style: Theme.of(context)
                                                                                .primaryTextTheme
                                                                                .caption
                                                                                .copyWith(color: Colors.black),
                                                                            overflow:
                                                                            TextOverflow.ellipsis,
                                                                          ),
                                                                        ),
                                                                      ),
                                                                      Padding(
                                                                        padding: EdgeInsets
                                                                            .only(
                                                                            left:
                                                                            30),
                                                                        child:
                                                                        Align(
                                                                          alignment:
                                                                          Alignment
                                                                              .topLeft,
                                                                          child:
                                                                          Text(
                                                                            'Importe',
                                                                            style: Theme.of(context)
                                                                                .primaryTextTheme
                                                                                .caption
                                                                                .copyWith(color: Colors.black),
                                                                            overflow:
                                                                            TextOverflow.ellipsis,
                                                                          ),
                                                                        ),
                                                                      ),
                                                                    ],
                                                                  ),
                                                                  Container(
                                                                    child: ListView
                                                                        .builder(
                                                                      shrinkWrap:
                                                                      true,
                                                                      itemCount: sale
                                                                          .length,
                                                                      itemBuilder:
                                                                          (BuildContext
                                                                      context,
                                                                          int index) {
                                                                        return Column(
                                                                          children: <
                                                                              Widget>[
                                                                            Row(
                                                                              children: <
                                                                                  Widget>[
                                                                                Padding(
                                                                                  padding: EdgeInsets.only(left: 20, right: 40),
                                                                                  child: Text(
                                                                                    '${sale[index].quantity}',
                                                                                    style: Theme.of(context).primaryTextTheme.caption.copyWith(color: Colors.black),
                                                                                    overflow: TextOverflow.ellipsis,
                                                                                  ),
                                                                                ),
                                                                                Expanded(
                                                                                    child: Container(
                                                                                        child: Text(
                                                                                          "${sale[index].productPlace.product.name}",
                                                                                          maxLines: 3,
                                                                                          style: Theme.of(context).primaryTextTheme.caption.copyWith(color: Colors.black),
                                                                                          overflow: TextOverflow.ellipsis,
                                                                                        ))),
                                                                                Padding(
                                                                                    padding: EdgeInsets.only(right: 25),
                                                                                    child: Row(
                                                                                      children: <Widget>[
                                                                                        Text(
                                                                                          r'$',
                                                                                          style: Theme.of(context).primaryTextTheme.caption.copyWith(color:Colors.black,),
                                                                                          overflow: TextOverflow.ellipsis,
                                                                                        ),
                                                                                        Text(
                                                                                          '${formatter.format(sale[index].cost)}',
                                                                                          style: Theme.of(context).primaryTextTheme.caption.copyWith(color:Colors.black,),
                                                                                          overflow: TextOverflow.ellipsis,
                                                                                        ),
                                                                                      ],
                                                                                    )
                                                                                ),
                                                                              ],
                                                                            ),
                                                                          ],
                                                                        );
                                                                      },
                                                                    ),
                                                                  ),
                                                                  Padding(
                                                                      padding: EdgeInsets
                                                                          .only(
                                                                          top:
                                                                          10,
                                                                          left:
                                                                          5,
                                                                          right:
                                                                          5),
                                                                      child:
                                                                      Container(
                                                                        height: 1,
                                                                        width: 300,
                                                                        color: Colors
                                                                            .black12,
                                                                      )),
                                                                  Padding(
                                                                    padding: EdgeInsets.only(right: 20),
                                                                    child:
                                                                    Align(
                                                                      child: Text(
                                                                          r'$'+'${formatter.format(purchaseModel[index].cost)}',
                                                                          style: TextStyle(
                                                                              fontSize: 14,
                                                                              color: Colors.orange,
                                                                              fontWeight: FontWeight.bold)),
                                                                      alignment: Alignment
                                                                          .topRight,
                                                                    ),
                                                                  ),
                                                                ],
                                                              ),
                                                            ));
                                                      });
                                                  print(sale.length);
                                                  sale.forEach((sale) {
                                                    print(sale
                                                        .productPlace.product.name);
                                                  });
                                                })),
                                      ],
                                    )),
                              ],
                            ))));
              },
            ),
          ),
        ],
      ),
      floatingActionButton: new FloatingActionButton(
        onPressed: (){
          print(area_type);
          if(area_type == 'Building'){
            Navigator.of(context).pushNamed('/building');
          }
        },
        tooltip: 'Add Item',
        backgroundColor: Colors.green,
        child: new ListTile(
          title: new  Icon(Icons.shopping_cart),
        ),
      ),

    );
  }

  unique(array) {
    List arr = [];
    for (var i = 0; i < array.length; i++) {
      if (!this.contains(arr, array[i])) {
        arr.add(array[i]);
      }
    }
    return arr;
  }

  getPurchase() {
    this.saleDatails = [];
    purchaseController.getOrders().then((List<PurchaseModel> purchase) {
      setState(() {
        purchaseModel.addAll(purchase);
      });
      purchaseModel.forEach((purchase) {
        dateFormat = new DateFormat.yMMMMd('es');
        print(new DateFormat("dd-MM-yyyy").format(new DateTime(1995, 12, 13)));
        this.types = [];
        purchase.sale_details.forEach((saleDetails) {
          this.types.add(saleDetails.productPlace.product.product_type);
          this.types = this.unique(this.types);
        });
        if (contains(types, 'Food') &&
            !contains(types, 'Drink') &&
            !contains(types, 'Dessert')) {
          this.src.add('B.png');
          this.titles.add('Sólo burritos');
        } else if (contains(types, 'Food') &&
            contains(types, 'Drink') &&
            !contains(types, 'Dessert')) {
          this.src.add('BV.png');
          this.titles.add('Burritos y bebida');
        } else if (this.contains(this.types, 'Food') &&
            !this.contains(this.types, 'Drink') &&
            this.contains(this.types, 'Dessert')) {
          this.src.add('BP.png');
          this.titles.add('Salado y dulce');
        } else if (this.contains(this.types, 'Drink') &&
            !this.contains(this.types, 'Food') &&
            !this.contains(this.types, 'Dessert')) {
          this.src.add('V.png');
          this.titles.add('Tengo sed');
        } else if (this.contains(this.types, 'Drink') &&
            !this.contains(this.types, 'Food') &&
            this.contains(this.types, 'Dessert')) {
          this.src.add('VP.png');
          this.titles.add('Sin burritos u.u');
        } else if (this.contains(this.types, 'Dessert') &&
            !this.contains(this.types, 'Food') &&
            !this.contains(this.types, 'Drink')) {
          this.src.add('P.png');
          this.titles.add('Un postrecito');
        } else if (this.contains(this.types, 'Drink') &&
            this.contains(this.types, 'Food') &&
            this.contains(this.types, 'Dessert')) {
          this.src.add('BVP.png');
          this.titles.add('Comida completa');
        }
      });
    });
  }
}