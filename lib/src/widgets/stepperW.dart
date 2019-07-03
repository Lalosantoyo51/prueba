import 'package:flutter/material.dart';

class StepperW extends StatefulWidget {
  int step;
  StepperW(this.step);
  @override
  _StepperWState createState() => _StepperWState();
}

class _StepperWState extends State<StepperW> {
  int step;
  double _kStepSize = 40.0;

  bool _isDark() {
    return Theme.of(context).brightness == Brightness.dark;
  }


  Color _circleColor() {
    final ThemeData themeData = Theme.of(context);
    if (!_isDark()) {
      return true ? themeData.primaryColor : Colors.black38;
    } else {
      return false ? themeData.accentColor : themeData.backgroundColor;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Row(
        mainAxisSize: MainAxisSize.max,
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          Container(
            margin: const EdgeInsets.symmetric(vertical: 8.0,),
            width: _kStepSize,
            height: _kStepSize,
            child: AnimatedContainer(
              curve: Curves.fastOutSlowIn,
              duration: kThemeAnimationDuration,
              decoration: BoxDecoration(
                color: _circleColor(),
                shape: BoxShape.circle,
              ),
              child: Center(
                child: Text('1',
                style: TextStyle(
                  fontSize: 15,
                  color: Colors.white
                ),),
              ),
            ),
          ),

          Container(
            height: 8,
            width: 15,
            color: Colors
                .orange,
          ),
          widget.step >= 2 ?
          Container(
            margin: const EdgeInsets.symmetric(vertical: 8.0),
            width: _kStepSize,
            height: _kStepSize,
            child: AnimatedContainer(
              curve: Curves.fastOutSlowIn,
              duration: kThemeAnimationDuration,
              decoration: BoxDecoration(
                color: _circleColor(),
                shape: BoxShape.circle,
              ),
              child: Center(
                child: Text('2',
                  style: TextStyle(
                      fontSize: 15,
                      color: Colors.white
                  ),
                ),
              ),
            ),
          ):Container(
            margin: const EdgeInsets.symmetric(vertical: 8.0),
            width: _kStepSize,
            height: _kStepSize,
            child: AnimatedContainer(
              curve: Curves.fastOutSlowIn,
              duration: kThemeAnimationDuration,
              decoration: BoxDecoration(
                color: Colors
                    .black26,
                shape: BoxShape.circle,
              ),
              child: Center(
                child: Text('2',
                  style: TextStyle(
                      fontSize: 15,
                      color: Colors.white
                  ),
                ),
              ),
            ),
          ), widget.step >= 2 ?
          Container(
            height: 8,
            width: 15,
            color: _circleColor(),

          ):Container(
            height: 8,
            width: 15,
            color: Colors
                .black26,
          ),
          widget.step >= 3 ?
          Container(
            margin: const EdgeInsets.symmetric(vertical: 8.0),
            width: _kStepSize,
            height: _kStepSize,
            child: AnimatedContainer(
              curve: Curves.fastOutSlowIn,
              duration: kThemeAnimationDuration,
              decoration: BoxDecoration(
                color: _circleColor(),
                shape: BoxShape.circle,
              ),
              child: Center(
                child: Text('3',
                  style: TextStyle(
                      fontSize: 15,
                      color: Colors.white
                  )),

              ),
            ),
          ):Container(
            margin: const EdgeInsets.symmetric(vertical: 8.0),
            width: _kStepSize,
            height: _kStepSize,
            child: AnimatedContainer(
              curve: Curves.fastOutSlowIn,
              duration: kThemeAnimationDuration,
              decoration: BoxDecoration(
                color: Colors
                    .black26,
                shape: BoxShape.circle,
              ),
              child: Center(
                child: Text('3',
                  style: TextStyle(
                      fontSize: 15,
                      color: Colors.white
                  )),

              ),
            ),
          ),
          widget.step >= 3 ?
          Container(
            height: 8,
            width: 15,
            color: _circleColor(),
          ):Container(
            height: 8,
            width: 15,
            color: Colors
                .black26,
          ),
          widget.step >= 4 ?
          Container(
            margin: const EdgeInsets.symmetric(vertical: 8.0),
            width: _kStepSize,
            height: _kStepSize,
            child: AnimatedContainer(
              curve: Curves.fastOutSlowIn,
              duration: kThemeAnimationDuration,
              decoration: BoxDecoration(
                color: _circleColor(),
                shape: BoxShape.circle,
              ),
              child: Center(
                child: Text('4',
                  style: TextStyle(
                      fontSize: 15,
                      color: Colors.white
                  ),),
              ),
            ),
          ):Container(
            margin: const EdgeInsets.symmetric(vertical: 8.0),
            width: _kStepSize,
            height: _kStepSize,
            child: AnimatedContainer(
              curve: Curves.fastOutSlowIn,
              duration: kThemeAnimationDuration,
              decoration: BoxDecoration(
                color: Colors.black26,
                shape: BoxShape.circle,
              ),
              child: Center(
                child: Text('4',
                  style: TextStyle(
                      fontSize: 15,
                      color: Colors.white
                  ),),
              ),
            ),
          ),
        ],
      );
  }
}
