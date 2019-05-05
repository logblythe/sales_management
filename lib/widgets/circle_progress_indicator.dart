import 'dart:math';

import 'package:flutter/material.dart';

class CircleProgressIndicator extends StatefulWidget {
  final Widget child;
  final double percentage;

  const CircleProgressIndicator({Key key, this.percentage, this.child})
      : super(key: key);

  @override
  State<StatefulWidget> createState() =>
      CircleProgressIndicatorState(percentage);
}

class CircleProgressIndicatorState extends State<CircleProgressIndicator>
    with SingleTickerProviderStateMixin {
  double _fraction = 0.0;
  Animation<double> animation;
  AnimationController controller;
  double percentage;

  CircleProgressIndicatorState(this.percentage);

  @override
  void initState() {
    super.initState();
    print("inside initstate");
    controller = AnimationController(
        duration: Duration(milliseconds: 5000), vsync: this);
    // animation =
    //     Tween(begin: _fraction, end: widget.percentage).animate(controller)
    //       ..addListener(() {
    //         print("the animation value is {$animation.value}");
    //         setState(() {
    //           _fraction = animation.value;
    //         });
    //       });
    // controller.forward();
  }

  @override
  Widget build(BuildContext context) {
    animation = Tween(begin: _fraction, end: percentage).animate(controller)
      ..addListener(() {
        print("the animation value is {$animation.value}");
        setState(() {
          _fraction = animation.value;
        });
      });
    controller.forward();
    print("inside the build method");
    return CustomPaint(
      painter: CirclePainter(percentage, fraction: _fraction),
      child: Padding(
        padding: const EdgeInsets.all(32.0),
        child: ClipRect(
          child: Padding(
            padding: const EdgeInsets.all(16.0),
            child: widget.child,
          ),
          clipper: CircleClipper(),
        ),
      ),
    );
  }

  // @override
  // Widget build(BuildContext context) {
  //   return CustomPaint(painter: CirclePainter(_fraction));
  // }
}

class CirclePainter extends CustomPainter {
  final Color arcColor;
  final double arcWidth;
  final double arcLength;
  final trackPaint;
  final arcPaint;
  final bool show;
  final double percentage;
  double fraction;

  CirclePainter(this.percentage,
      {this.arcColor, this.arcWidth, this.arcLength, this.show, this.fraction})
      : trackPaint = Paint()
          ..color = Colors.black
          ..style = PaintingStyle.stroke
          ..strokeWidth = 25,
        arcPaint = Paint()
          ..color = arcColor ?? Colors.blue
          ..style = PaintingStyle.stroke
          ..strokeWidth = arcWidth ?? 20
          ..strokeCap = StrokeCap.round;

  @override
  void paint(Canvas canvas, Size size) {
    print("the pi value is $pi");
    final center = Offset(size.width / 2, size.height / 2);
    final radius = min(size.width, size.height) / 2;
    canvas.drawCircle(center, radius, trackPaint);
    canvas.drawArc(
        Rect.fromCircle(
          center: center,
          radius: radius,
        ),
        -pi / 2,
        2 * pi * fraction,
        false,
        arcPaint);
  }

  @override
  bool shouldRepaint(CirclePainter oldDelegate) =>
      oldDelegate.percentage != percentage;
}

class CircleClipper extends CustomClipper<Rect> {
  @override
  Rect getClip(Size size) {
    return Rect.fromCircle(
        center: Offset(size.width / 2, size.height / 2),
        radius: min(size.width, size.height) / 2);
  }

  @override
  bool shouldReclip(CustomClipper<Rect> oldClipper) => true;
}
