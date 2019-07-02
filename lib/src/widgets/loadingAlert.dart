import 'package:flutter/material.dart';

class LoadingAlert extends StatefulWidget {
  @override
  _LoadingAlertState createState() => _LoadingAlertState();
}

class _LoadingAlertState extends State<LoadingAlert> {
  @override
  Widget build(BuildContext context) {
    var sizeWidth = MediaQuery.of(context).size.width;
    return AlertDialog(
      content: Container(
        width: sizeWidth,
        child: Row(
          mainAxisSize: MainAxisSize.max,
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: <Widget>[
            Container(
              child: CircularProgressIndicator(),
            ),
            Container(
              child: Text(
                "Cargando. Por favor espere...",
                style: TextStyle(),
                overflow: TextOverflow.ellipsis,
              ),
            )
          ],
        ),
      ),
    );
  }
}
