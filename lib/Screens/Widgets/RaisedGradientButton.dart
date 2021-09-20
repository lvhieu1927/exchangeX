import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class RaisedGradientButton extends StatelessWidget {
  final Widget child;
  final Color gradient1;
  final Color gradient2;
  final double width;
  final double height;
  final Function onPressed;

  const RaisedGradientButton({
    Key? key,
    required this.child,
    required this.gradient1,
    required this.gradient2,
    this.width = double.infinity,
    this.height = 50.0,
    required this.onPressed,
  }) : super(key: key);



  @override
  Widget build(BuildContext context) {
    print("create button!!");
    return Container(
      width: width,
      height: 50.0,
      decoration: BoxDecoration(
          gradient: RadialGradient(
            radius: 1.8,
            colors: [
              gradient1,
              gradient2
            ]
          ),
          borderRadius: new BorderRadius.all(Radius.circular(15)),
          boxShadow: [
            BoxShadow(
              offset: Offset(0.0, 1.0),
              blurRadius: 0.8,
            ),
          ]),
      child: Material(
        color: Colors.transparent,
        child: InkWell(
            onTap: ()=>{onPressed()},
            child: Center(
              child: child,
            )),
      ),
    );
  }
}
