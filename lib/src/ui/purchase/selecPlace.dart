import 'package:flutter/material.dart';
import 'package:prue/src/widgets/menu.dart';
import 'package:prue/src/widgets/stepperW.dart';

class SelecPlace extends StatefulWidget {
  @override
  _SelecPlaceState createState() => _SelecPlaceState();
}

class _SelecPlaceState extends State<SelecPlace> {
  String selected_place;
  List _cities =
  ["Cluj-Napoca", "Bucuresti", "Timisoara", "Brasov", "Constanta"];
  List<DropdownMenuItem<String>> listBuiling = [];

  List<DropdownMenuItem<String>> _dropDownMenuItems;
  String _currentCity;


  @override
  void initState() {
    _dropDownMenuItems = getDropDownMenuItems();
    _currentCity = _dropDownMenuItems[0].value;
    super.initState();
  }
  List<DropdownMenuItem<String>> getDropDownMenuItems() {
    List<DropdownMenuItem<String>> items = new List();
    for (String city in _cities) {
      // here we are creating the drop down menu items, you can customize the item right here
      // but I'll just use a simple text for this
      items.add(new DropdownMenuItem(
          value: city,
          child: new Text(city)
      ));
    }
    return items;
  }

  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    double height = MediaQuery.of(context).size.height;
    return Scaffold(
      appBar: AppBar(
        title: new Text('inicio'),
        centerTitle: true,
        backgroundColor: Colors.orange,
      ),
      drawer: MainDrawer(),
      body: Theme(
        data: ThemeData(
            primaryColor: Colors.orange
        ),
        child: Container(
          constraints: BoxConstraints.expand(),
          child: Stack(
            children: <Widget>[
              Padding(padding: EdgeInsets.only(top: 20),child: StepperW(1),),
              Padding(padding: EdgeInsets.only(top: 90),
                  child: Card(
                    elevation: 5.0,
                    child: Container(
                      width: width,
                      height: height/1.8,
                      padding: EdgeInsets.only(bottom: 15),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        mainAxisAlignment: MainAxisAlignment.center,
                        mainAxisSize: MainAxisSize.max,
                        children: <Widget>[
                          Text('Selecciona el lugar de tu entrega:',style:
                            TextStyle(
                              fontSize: height/30
                            ),),
                          Padding(padding: EdgeInsets.only(top: 15)),

                          RaisedButton(onPressed: null,
                            child: Text('Mi ubicacion Actual',
                              style: TextStyle(
                                  color: Colors.white,
                                fontSize: height/30
                              ),),
                            disabledColor: Colors.orange,
                            shape: new RoundedRectangleBorder(borderRadius: new BorderRadius.circular(30.0)),
                          ),
                          Padding(padding: EdgeInsets.only(top: 15)),
                          Text('Ó',style: TextStyle(
                            fontSize: height/30,
                            fontWeight: FontWeight.bold
                          ),),
                          Padding(padding: EdgeInsets.only(top: 0)),
                          Container(
                            width: width,
                            padding: EdgeInsets.only(left: width/10,right:width/10),
                            child:DropdownButton(
                            elevation: 5,
                            isExpanded: true,
                            icon: Icon(Icons.place),
                            value: selected_place,
                            items: _dropDownMenuItems,
                            hint: Container(
                              child:Row(
                                mainAxisSize: MainAxisSize.min,
                                crossAxisAlignment: CrossAxisAlignment.end,
                                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                children: <Widget>[
                                  Text("Mis lugares"),
                                ],
                              ),
                            ),
                            onChanged: (value){
                            },
                          ),),
                          Padding(padding: EdgeInsets.only(top: 15)),
                          RaisedButton(onPressed: null,
                            child: Text('Añadir nuevo lugar',
                              style: TextStyle(
                                  color: Colors.white,
                                  fontSize: height/30
                              ),),
                            disabledColor: Colors.orange,
                            shape: new RoundedRectangleBorder(borderRadius: new BorderRadius.circular(30.0)),
                          ),
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
                                ),
                              ),
                            ),
                            height: 50,
                            width: width/2.2,
                          ),
                          onTap: (){

                          },
                        ),
                        GestureDetector(
                          child: Container(
                            margin: EdgeInsets.only(left: 10),
                            color: Colors.orange,
                            child: Center(
                              child: Text('Elegir productos',
                                style: TextStyle(
                                    color: Colors.white,
                                    fontSize: 15,
                                    fontWeight: FontWeight.bold
                                ),),
                            ),
                            height: 50,
                            width: width/2.2,
                          ),
                          onTap: null,
                        ),

                      ],
                    ),
                  )
              )
            ],
          ),
        ),
      ),
    );
  }
}
