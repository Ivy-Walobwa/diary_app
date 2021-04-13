import 'package:flutter/material.dart';

class CircularContainer extends StatelessWidget {
  final int colorCode;

  CircularContainer({@required this.colorCode});

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 72,
      width: 72,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.all(
          Radius.circular(50),
        ),
        color: Color(colorCode),
      ),
    );
  }
}
