import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';

class CarouselWithIndicator extends StatefulWidget {
  final List<Widget> child;

  const CarouselWithIndicator({Key key, this.child}) : super(key: key);
  @override
  _CarouselWithIndicatorState createState() => _CarouselWithIndicatorState();
}

class _CarouselWithIndicatorState extends State<CarouselWithIndicator> {
  int _current = 0;

  @override
  Widget build(BuildContext context) {
    return Stack(children: [
      CarouselSlider(
        items: widget.child,
        autoPlay: true,
        aspectRatio: 2.0,
        onPageChanged: (index) {
          setState(() {
            _current = index;
          });
        },
        pauseAutoPlayOnTouch: Duration(milliseconds: 500),
        enlargeCenterPage: true,
        enableInfiniteScroll: true,
        autoPlayCurve: Curves.decelerate,
        viewportFraction: 0.8,
        reverse: false,
      ),
      Positioned(
        left: 0.0,
        right: 0.0,
        bottom: 0.0,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: widget.child
              .asMap()
              .map((i, element) {
                return MapEntry(
                  i,
                  Container(
                    width: 8.0,
                    height: 8.0,
                    margin:
                        EdgeInsets.symmetric(vertical: 10.0, horizontal: 2.0),
                    decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        color: _current == i
                            ? Color.fromRGBO(0, 0, 0, 0.9)
                            : Color.fromRGBO(0, 0, 0, 0.4)),
                  ),
                );
              })
              .values
              .toList(),
        ),
      ),
    ]);
  }
}
