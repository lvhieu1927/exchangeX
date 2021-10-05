import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:intl/intl.dart' as intl;
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:intl/intl.dart';

class BoxBuySell extends StatelessWidget {
  const BoxBuySell({
    Key? key,
    required this.colorOfBox,
    required this.textOfBox,
    required this.leftOrRightMargin,
    required this.price,
  }) : super(key: key);

  final Color colorOfBox;
  final String textOfBox;
  final int leftOrRightMargin;
  final double price;

  @override
  Widget build(BuildContext context) {
    double cusMarginLeft = leftOrRightMargin == 1 ? 20.w : 9.5.w;
    double custMarginright = leftOrRightMargin == 1 ? 9.5.w : 20.w;

    final formatter = NumberFormat.simpleCurrency(locale: 'vi',decimalDigits: 2).format(price);

    return Container(
      decoration: BoxDecoration(
        color: colorOfBox,
        borderRadius: BorderRadius.circular(12.0),
      ),
      width: 138.w,
      height: 93.h,
      margin: EdgeInsets.only(left: cusMarginLeft, right: custMarginright),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Container(
            padding: EdgeInsets.only(left: 20.w, top: 20.w),
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
            padding: EdgeInsets.only(top: 20.h, left: 20.w, bottom: 10.h),
            child: Center(
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Spacer(),
                  Text(
                    "${formatter}",
                    style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 20.sp,
                        color: Colors.white),
                  ),
                  SizedBox(width: 10.w,)
                ],
              ),
            ),
          )
        ],
      ),
    );
  }
}
