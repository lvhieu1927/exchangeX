import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:intl/intl.dart'  as intl;

class BoxBuySell extends StatelessWidget {
  const BoxBuySell({
    Key? key,
    required this.deviceWidth,
    required this.deviceHeight,
    required this.colorOfBox,
    required this.textOfBox,
    required this.leftOrRightMargin,
    required this.price,
  }) : super(key: key);

  final double deviceWidth;
  final double deviceHeight;
  final Color colorOfBox;
  final String textOfBox;
  final int leftOrRightMargin;
  final double price;

  @override
  Widget build(BuildContext context) {
    double cusMarginLeft =
    leftOrRightMargin == 1 ? 20 * deviceWidth : 9.5 * deviceWidth;
    double custMarginright =
    leftOrRightMargin == 1 ? 9.5 * deviceWidth : 20 * deviceWidth;

    final formatter =  intl.NumberFormat.decimalPattern().format(price);

    return Container(
      decoration: BoxDecoration(
        color: colorOfBox,
        borderRadius: BorderRadius.circular(12.0),
      ),
      width: 138 * deviceWidth,
      height: 93 * deviceHeight,
      margin: EdgeInsets.only(left: cusMarginLeft, right: custMarginright),
      child: Column(
        children: [
          Container(
            padding:
            EdgeInsets.only(left: 20 * deviceWidth, top: 20 * deviceWidth),
            child: Align(
              alignment: Alignment.topLeft,
              child: Text(
                textOfBox,
                textAlign: TextAlign.left,
                style: TextStyle(
                    color: Colors.white,
                    fontWeight: FontWeight.w600,
                    fontSize: 18),
              ),
            ),
          ),
          Container(
            padding:
            EdgeInsets.only(top: 20 * deviceWidth, left: 24 * deviceWidth),
            child: Row(
              children: [
                Text(
                  "~",
                  style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 18,
                      color: Colors.white),
                ),
                SizedBox(
                  width: 4,
                ),
                Text("đ",
                    style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 18,
                        color: Colors.white)),
                Text(
                  "${formatter}",
                  style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 18,
                      color: Colors.white),
                ),
                Container(
                    padding: EdgeInsets.only(bottom: 3 * deviceWidth),
                    child: Text("",
                        style: TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: 24,
                            color: Colors.white))),
              ],
            ),
          )
        ],
      ),
    );
  }
}