import 'package:flutter/material.dart';

class CustomBottomCurvePath extends CustomClipper<Path> {
  @override
  Path getClip(Size size) {
    final path = Path();
    final height = size.height;
    final width = size.width;

    final verticalHeight = height / 2.5;

    path.lineTo(0, height - verticalHeight);
    path.quadraticBezierTo(width / 2, height, width, height - verticalHeight);
    path.lineTo(width, 0);
    path.close();

    return path;
  }

  @override
  bool shouldReclip(CustomClipper<Path> oldClipper) => false;
}
