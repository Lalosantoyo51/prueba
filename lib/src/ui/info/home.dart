import 'dart:async';
import 'package:connectivity/connectivity.dart';
import 'package:flutter/material.dart';
import 'package:prue/src/bloc/purchaseController.dart';
import 'package:prue/src/models/area.model.dart';
import 'package:prue/src/models/cart.model.dart';
import 'package:prue/src/models/purchase.model.dart';
import 'package:prue/src/models/sale-details-model.dart';
import 'package:prue/src/widgets/loadingAlert.dart';
import 'package:rflutter_alert/rflutter_alert.dart';
import '../../bloc/location.controller.dart';
import '../../bloc/authController.dart';
import '../../models/messageResponse.dart';
import '../../widgets/menu.dart';
import '../../models/user.model.dart';
import '../../models/Userget.dart';
import 'package:intl/intl.dart';
import 'package:intl/date_symbol_data_local.dart';
import 'package:dio/dio.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:flutter/services.dart';

//status conection internet
final Connectivity _connectivity = Connectivity();
StreamSubscription<ConnectivityResult> _connectivitySubscription;

class Home extends StatefulWidget {
  List<PurchaseModel> purchaseModel = new List();
  Home({Key key, this.purchaseModel}) : super(key: key);
  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {
  var loadingContext;
  closeAlert(BuildContext _context) {
    Navigator.of(_context).pop();
  }

  final GlobalKey<ScaffoldState> _scaffoldKey = new GlobalKey<ScaffoldState>();
  final formatter = new NumberFormat("0.00");
  CartModel cart = new CartModel();
  bool isloading = true;
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
  String error = '';
  String area_type;
  DateFormat dateFormat;

  @override
  void initState(){
    super.initState();
    initializeDateFormatting();
    //init method internet
    _connectivitySubscription =
        _connectivity.onConnectivityChanged.listen(_updateConnectionStatus);
    initConnectivity();
    if(user.getName == null){
      _authController.getUser().then((UserModel userModel){
        user.setName = userModel.name;
        user.setGender = userModel.gender;
        user.setBirthday = userModel.birthday;
        user.setPhone = userModel.phone;
        user.setLast_Name = userModel.last_name;
        user.setUser_id = userModel.id;
        cart.setUser_id = userModel.id;
        print(userModel.gender);
      });
    }
    getLocation();
  }

  getLocation() async{
       await _locationController.getlocation().then((_) {
        _locationController.areaModel.lat = _[0]['latitude'];
        _locationController.areaModel.lng = _[0]['longitude'];
          _locationController.getCurrentPlace().then((AreaModel areaModel) async {
            if(areaModel.id != null){
              cart.setPlace_id = areaModel.id;
              area_type = areaModel.type;
              _locationController.areaModel =areaModel ;
              await _locationController.setMessage().then((MessageResponse messageModel){
                if(messageModel == null || messageModel =='null'){
                  getPurchase();
                  setState(() {
                    isloading = false;
                    message = 'No hay mensaje de la franquisia';
                  });
                }else{
                  setState(() {
                    isloading = false;
                    message = messageModel.results.message;
                  });
                }
              });
            }else {
              closeAlert(context);
            }
          });

      });
  }

  contains(a, b) {
    for (var i = 0; i < a.length; i++) {
      if (a[i] == b) return true;
    }

    return false;
  }
  _onAlertButtonError(context){
    Alert(
      context: context,
      type: AlertType.warning,
      title: "Advertencia",
      desc: "El campo comentario es obligatorio",
      buttons: [
        DialogButton(
          color: Colors.orange,
          child: Text(
            "Aceptar",
            style: TextStyle(color: Colors.white, fontSize: 20),
          ),
          onPressed: () => Navigator.pop(context),
          width: 120,
        )
      ],
    ).show();
  }
  _onAlertButtonSucces(context){
    Alert(
      context: context,
      type: AlertType.success,
      title: "Tu orden fue Cancelada exitosamente",
      desc: "",
      buttons: [
        DialogButton(
          color: Colors.orange,
          child: Text(
            "Aceptar",
            style: TextStyle(color: Colors.white, fontSize: 20),
          ),
          onPressed: () {
            Navigator.of(context).pushNamedAndRemoveUntil("/home",  (Route<dynamic> route) => false);
          },
          width: 120,
        )
      ],
    ).show();
  }
  loading() async{
     await showDialog(
        context: context,
        builder: (context) {
          loadingContext = context;
          return LoadingAlert('Cargando...');
        });

  }

  @override
  Widget build(BuildContext context) {

    double width = MediaQuery.of(context).size.width;
    double height = MediaQuery.of(context).size.height;
    return Scaffold(
      key: _scaffoldKey,
      appBar: AppBar(
        title: Text('Inicio'),
        centerTitle: true,
        backgroundColor: Colors.orange,
      ),
      drawer: MainDrawer(),
      body: isloading == true ?Container(
        child: LoadingAlert('Cargando...'),
      ): message == null ? Center(
        child: Text('No estas en zona burrera'),
      ):
      purchaseModel.length < 1 && message != null ?Center(
        child: Text('$message'),
      ):Stack(
        children: <Widget>[
          Container(
            child: ListView.builder(
              controller: _scrollController,
              itemCount: purchaseModel.length,
              itemBuilder: (BuildContext context, int index) {
                return Container(
                    height: height/3,
                    width: width,
                    child: Padding(
                        padding: EdgeInsets.only(left: 20, right: 20, top: 10),
                        child: Card(
                            child: Stack(
                              children: <Widget>[
                                Image.asset(
                                  "assets/orders/${src[index]}",
                                  width: width/3,
                                ),
                                Padding(
                                  padding: EdgeInsets.only(
                                    top: 10,
                                    left: width/3,
                                  ),
                                  child: Column(
                                    children: <Widget>[
                                      Center(
                                          child: Align(
                                            child: Text(
                                              '${titles[index]}',
                                              style: TextStyle(
                                                  fontSize: width/15,
                                                  color: Colors.black),
                                            ),
                                            alignment: Alignment.topLeft,
                                          )),
                                      Align(
                                        alignment: Alignment.topLeft,
                                        child: Text(
                                          'Pedido #${purchaseModel[index].id + 1000}',
                                          style: TextStyle(color: Colors.black38,fontSize: width/24),
                                        ),
                                      ),
                                      Align(
                                        alignment: Alignment.topLeft,
                                        child: Text(
                                          dateFormat.format(new DateFormat(
                                              "yyyy-MM-dd HH:mm:ss")
                                              .parse(
                                              purchaseModel[index].created_at)),
                                          style: TextStyle(color: Colors.black45,
                                              fontSize: width/24),
                                        ),
                                      ) , purchaseModel[index].status == 'Order' ?
                                      Align(
                                        alignment: Alignment.topLeft,
                                        child: Text('Orden Activa',
                                          style: TextStyle(color: Colors.black38,
                                              fontSize: width/24),),
                                      ): purchaseModel[index].status == 'Delivered' ?
                                      Align(
                                        alignment: Alignment.topLeft,
                                        child: Text('Orden completa',
                                          style: TextStyle(color: Colors.black38,
                                              fontSize: width/24),),
                                      ):purchaseModel[index].status =='Rejected' ?
                                      Align(
                                        alignment: Alignment.topLeft,
                                        child: Text('Orden cancelada',
                                          style: TextStyle(color: Colors.black38,
                                              fontSize: width/24),),
                                      ):
                                      Container(),
                                      purchaseModel[index].place_user.name == null && purchaseModel[index].offices.name != null  ?
                                      Align(
                                          alignment: Alignment.topLeft,
                                          child:
                                          Text('${purchaseModel[index].offices.buildin.name} ${purchaseModel[index].offices.name}',
                                            style: TextStyle(color: Colors.black38,
                                                fontSize: width/24),)
                                      ):purchaseModel[index].place_user.name != null && purchaseModel[index].offices.name == null  ?
                                      Align(
                                          alignment: Alignment.topLeft,
                                          child:
                                          Text('${purchaseModel[index].place_user.name} ',
                                            style: TextStyle(color: Colors.black38,
                                                fontSize: width/24),)
                                      ):Align(
                                          alignment: Alignment.topLeft,
                                          child:
                                          Text('tu ubicacion actual',
                                            style: TextStyle(color: Colors.black38,
                                                fontSize: width/24),)
                                      )
                                    ],
                                  ),
                                ),
                                Padding(
                                    padding: EdgeInsets.only(
                                        top: height/4.5, left: 10, right: 10),
                                    child: Container(
                                      height: 1,
                                      width: width,
                                      color: Colors.black12,
                                    )),
                                Padding(
                                    padding: EdgeInsets.only(
                                        top: height/4.3, left: width/15, right: width/10),
                                    child: Row(
                                      crossAxisAlignment: CrossAxisAlignment.center,
                                      mainAxisSize: MainAxisSize.max,
                                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                      children: <Widget>[
                                        Padding(
                                          padding: EdgeInsets.only(
                                            bottom: 10,
                                          ),
                                          child: Text(r"$" +'${formatter.format(purchaseModel[index].cost)}',
                                              style: TextStyle(
                                                  fontSize: height/22,
                                                  color: Colors.orange,
                                                  fontWeight: FontWeight.bold)),
                                        ),

                                        Padding(
                                            padding: EdgeInsets.only(left: width/20),
                                            child: Container(
                                              width: width/10,
                                              child: GestureDetector(
                                                child: Icon(
                                                  Icons.chat_bubble,
                                                  color: Colors.orange,
                                                  size: height/22,
                                                ),),
                                            )),
                                        Padding(
                                            padding: EdgeInsets.only(left: width/40),
                                            child: Container(
                                              width: width/10,
                                              child: GestureDetector(
                                                child: Icon(
                                                  Icons.phone,
                                                  color: Colors.orange,
                                                  size: height/22,
                                                ),
                                                onTap:(){
                                                  launch("tel://${purchaseModel[index].employeeModel.phone }");
                                                },
                                              ),
                                            )),
                                        Padding(
                                            padding: EdgeInsets.only(left: width/40),
                                            child: Container(
                                              width: width/10,
                                              child: GestureDetector(
                                                child: Icon(
                                                  Icons.info,
                                                  color: Colors.orange,
                                                  size: height/22,
                                                ),
                                                onTap: (){
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
                                                                          style: TextStyle(
                                                                              fontSize: 15
                                                                          ),
                                                                        ),
                                                                      ),
                                                                      Padding(
                                                                        padding: EdgeInsets
                                                                            .only(
                                                                            left:
                                                                            25),
                                                                        child:
                                                                        Align(
                                                                          alignment:
                                                                          Alignment
                                                                              .topLeft,
                                                                          child:
                                                                          Text(
                                                                            'Producto',
                                                                            style: TextStyle(
                                                                                fontSize: 15
                                                                            ),
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
                                                                            style: TextStyle(
                                                                                fontSize: 15
                                                                            ),
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
                                                                                  padding: EdgeInsets.only(left: 30, right: 40),
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
                                                                                    padding: EdgeInsets.only(right: 10),
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
                                                                    padding: EdgeInsets.only(right: 10),
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
                                                                  Padding(padding: EdgeInsets.only(top: 15),
                                                                      child: GestureDetector(
                                                                        child: Text('Cancelar orden', style: TextStyle(color: Colors.red),),
                                                                        onTap: (){
                                                                          showDialog(
                                                                              context: context,
                                                                              builder:
                                                                                  (BuildContext context) {
                                                                                return AlertDialog(
                                                                                  title: Text('¿Por qué quieres cancelar el pedido?'),
                                                                                  content: Container(
                                                                                      height: 250,
                                                                                      child: ListView(
                                                                                        children: <Widget>[
                                                                                          Container(
                                                                                            height: 200,
                                                                                            decoration: BoxDecoration(
                                                                                              border: Border.all(color: Colors.black54),
                                                                                              borderRadius: BorderRadius.circular(2.00),
                                                                                            ),
                                                                                            child: TextField(
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
                                                                                          ),
                                                                                          Padding(padding: EdgeInsets.only(top: 10)),
                                                                                          Center(
                                                                                            child: GestureDetector(
                                                                                              child: Text('confirmar',
                                                                                                style: TextStyle(color: Colors.red, fontSize: 20),),
                                                                                              onTap: ()  {
                                                                                                if(purchaseController.comment == null || purchaseController.comment == 'null'){
                                                                                                  _onAlertButtonError(context);
                                                                                                }else {
                                                                                                  purchaseController.id = purchaseModel[index].id;
                                                                                                  try  {
                                                                                                    purchaseController.cancelOrder().then((_){
                                                                                                      _onAlertButtonSucces(context);
                                                                                                      purchaseModel.clear();
                                                                                                      getPurchase();

                                                                                                    });
                                                                                                  } on DioError catch(e) {
                                                                                                    print('dsadsa');
                                                                                                    print(e.response.data);
                                                                                                  }
                                                                                                }
                                                                                              },
                                                                                            ),
                                                                                          ),
                                                                                        ],
                                                                                      )

                                                                                  ),
                                                                                );
                                                                              }).then((_){
                                                                            Navigator.pop(context);
                                                                          });
                                                                        },
                                                                      ))
                                                                ],
                                                              ),
                                                            ));
                                                      });
                                                  sale.forEach((sale) {
                                                    print(sale
                                                        .productPlace.product.name);
                                                  });
                                                },
                                              ),
                                            )),
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
        hoverColor: Colors.orange,
        onPressed: (){
          if(area_type == 'Building'){
            Navigator.of(context).pushNamed('/building');
          }
        },
        tooltip: 'ver edificios',
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

   Future getPurchase() async{
    this.saleDatails = [];
    await purchaseController.getOrders().then((List<PurchaseModel> purchase) {

      setState(() {
        purchaseModel.addAll(purchase);
      });
      purchaseModel.forEach((purchase) {
        dateFormat = new DateFormat.yMMMMd('es');

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
  //create alert
  Future alert() async{
    _scaffoldKey.currentState.showSnackBar(
        SnackBar(content: Text("$error"),backgroundColor: Colors.red.shade400,));
  }

  // detect if you have internet
  Future<void> initConnectivity() async {
    ConnectivityResult result;
    try {

      result = await _connectivity.checkConnectivity();
      if(result.index == 0){
      }else if(result.index ==1){
        new Future.delayed(Duration.zero,() {
          alert();
        });
        error = "Sin conexión a Internet";
      }
      else if(result.index ==2){
        new Future.delayed(Duration.zero,() {
          alert();
        });
        error = "Sin conexión a Internet";
      }
    } on PlatformException catch (e) {
      print(e.toString());
    }

  }

  //update detect if you have internet
  Future<void> _updateConnectionStatus(ConnectivityResult result ) async {
    if(result.index == 0){
    }else if(result.index ==1){
      error = "Sin conexión a Internet";
      new Future.delayed(Duration.zero,() {
        alert();
      });
    }
    else if(result.index ==2){
      error = "Sin conexión a Internet";
      new Future.delayed(Duration.zero,() {
        alert();
      });
    }
  }
}