import 'package:flutter/material.dart';

import '../../utils/fonts.dart';

class CircleIndexNumber extends StatelessWidget {
  const CircleIndexNumber({
    super.key,
    required this.radius,
    required this.index,
  });

  final double radius;
  final int index;

  @override
  Widget build(BuildContext context) {
    return CircleAvatar(
      radius: radius,
      backgroundColor: Colors.orange,
      child: Stack(
        children: [
          Align(
            alignment: Alignment.center,
            child: Icon(
              Icons.star_border_outlined,
              color: Colors.white,
              size: radius * 1.5,
            ),
          ),
          Align(
            alignment: Alignment.center,
            child: Text(
              "${index + 1}",
              style: headerFont.copyWith(
                color: Colors.white,
                fontSize: 12.0,
                fontWeight: FontWeight.bold,
              ),
            ),
          )
        ],
      ),
    );
  }
}
