import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:prue/src/bloc/purchaseController.dart';
import 'package:prue/src/models/purchase.model.dart';
import 'package:prue/src/models/sale-details-model.dart';
import 'package:prue/src/widgets/column.dart';
import 'package:prue/src/widgets/loadingAlert.dart';
import 'package:prue/src/widgets/raiting.dart';
import 'package:smooth_star_rating/smooth_star_rating.dart';
import '../../widgets/menu.dart';
import 'package:intl/intl.dart';
import 'package:intl/date_symbol_data_local.dart';

class History extends StatefulWidget {
  List<PurchaseModel> purchaseModel = new List();
  History({Key key, this.purchaseModel}) : super(key: key);
  @override
  _HistoryState createState() => _HistoryState();
}

class _HistoryState extends State<History> {
  var loadingContext;
  closeAlert(
      BuildContext _context) {
    Navigator.of(_context).pop();
  }
  var rating = 0.0;

  DateFormat dateFormat;
  final formatter = new NumberFormat("0.00");
  PurchaseController purchaseController = new PurchaseController();
  ScrollController _scrollController = new ScrollController();

  int currentPage = 0;
  List<PurchaseModel> purchaseModel = new List();
  List<SaleDetailsModel> sale = new List();
  List types = [];
  List src = new List();
  List titles = new List();
  List<SaleDetailsModel> saleDatails = new List();
  bool isloading = true;

  @override
  void initState() {
    initializeDateFormatting();
    _scrollController.addListener(() {
      //method listview end
      if (_scrollController.position.pixels ==
          _scrollController.position.maxScrollExtent) {
        purchaseController.numberpage = this.currentPage += 1;
        getPurchase();
      }
    });
    purchaseController.numberpage = this.currentPage += 1;
    getPurchase();
  }

  contains(a, b) {
    for (var i = 0; i < a.length; i++) {
      if (a[i] == b) return true;
    }
    return false;
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
      appBar: AppBar(
        title: Text('Historial'),
        centerTitle: true,
        backgroundColor: Colors.orange,
      ),
      drawer: MainDrawer(),
      body:isloading == true ?Container(
        child: LoadingAlert('Cargando historial...'),
      ): Stack(
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
                                          style: TextStyle(color: Colors.black38,
                                              fontSize: width/24),
                                        ),
                                      ),
                                      Align(
                                        alignment: Alignment.topLeft,
                                        child: Text(
                                          dateFormat.format(new DateFormat(
                                              "yyyy-MM-dd HH:mm:ss")
                                              .parse(
                                              purchaseModel[index].created_at)),
                                          style: TextStyle(color: Colors.black38,
                                              fontSize: width/24),
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
                                            style: TextStyle(color: Colors.black38,fontSize: width/24),)
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
                                        top: height/4.3, left: 15, right: 10),
                                    child: Row(
                                      crossAxisAlignment: CrossAxisAlignment.center,
                                      mainAxisSize: MainAxisSize.max,
                                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                      children: <Widget>[
                                        Padding(
                                          padding: EdgeInsets.only(
                                            bottom: 10,
                                          ),
                                          child: Container(
                                            width: width/4,
                                            child: Text(r"$" +'${formatter.format(purchaseModel[index].cost)}',
                                                style: TextStyle(
                                                    fontSize: height/24,                                                    color: Colors.orange,
                                                    fontWeight: FontWeight.bold)),
                                          )),
                                        purchaseModel[index].status != 'Delivered' && purchaseModel[index].qualified_by_customer == 'Unrated' ?
                                        Padding(
                                            padding: EdgeInsets.only(left: 0),
                                            child: FlatButton(
                                              child: Icon(
                                                Icons.star,
                                                color: Colors.orange,
                                                size: height/22,
                                              ),
                                              onPressed: (){
                                                showDialog(
                                                    context: context,
                                                    builder:
                                                        (BuildContext context) {
                                                      return MyDialog(purchaseModel[index].employeeModel.name,purchaseModel[index].id + 1000,purchaseModel[index].created_at);});
                                              },
                                            )):Padding(
                                            padding: EdgeInsets.only(left:0),
                                            child: FlatButton(
                                              child: Container(),)),
                                        Padding(
                                            padding: EdgeInsets.only(left: 0),
                                            child: FlatButton(
                                                child: Icon(
                                                  Icons.info_outline,
                                                  color: Colors.orange,
                                                  size: height/22,
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
                                                                    child: ColumnBuilder(
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
    purchaseController.history().then((List<PurchaseModel> purchase) {
      print(purchase.length);
      setState(() {
        purchaseModel.addAll(purchase);
        if(purchase.length > 0){
          isloading = false;
        }else {
          isloading = false;
        }
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
}

