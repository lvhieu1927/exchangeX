import 'package:flutter/cupertino.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class OpenPainter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    var paint1 = Paint()
      ..color = Color(0x401A22ED)
      ..style = PaintingStyle.fill;
    canvas.drawCircle(Offset(5.w, 600.h), 105.h, paint1);
  }

  @override
  bool shouldRepaint(CustomPainter oldDelegate) => true;
}

class OpenPainter2 extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    var paint1 = Paint()
      ..color = Color(0x401A22ED)
      ..style = PaintingStyle.fill;
    canvas.drawCircle(Offset(444.w, 320.h), 130, paint1);
  }

  @override
  bool shouldRepaint(CustomPainter oldDelegate) => true;
}

class OpenPainter3 extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    var paint1 = Paint()
      ..color = Color(0x204D5135)
      ..style = PaintingStyle.fill;
    canvas.drawCircle(Offset(-20.w, -20.h), 105.h, paint1);
  }
  @override
  bool shouldRepaint(CustomPainter oldDelegate) => true;
}

class OpenPainter11 extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    var paint1 = Paint()
      ..color = Color(0x50040d95)
      ..style = PaintingStyle.fill;
    canvas.drawCircle(Offset(5.w, 600.h), 105.h, paint1);
  }

  @override
  bool shouldRepaint(CustomPainter oldDelegate) => true;
}

class OpenPainter22 extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    var paint1 = Paint()
      ..color = Color(0x80040d95)
      ..style = PaintingStyle.fill;
    canvas.drawCircle(Offset(444.w, 320.h), 130, paint1);
  }

  @override
  bool shouldRepaint(CustomPainter oldDelegate) => true;
}

class OpenPainter33 extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    var paint1 = Paint()
      ..color = Color(0x604D5135)
      ..style = PaintingStyle.fill;
    canvas.drawCircle(Offset(-20.w, -20.h), 105.h, paint1);
  }
  @override
  bool shouldRepaint(CustomPainter oldDelegate) => true;
}