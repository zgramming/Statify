import 'package:flutter/material.dart';

import '../../utils/colors.dart';
import '../../utils/fonts.dart';
import 'custom_bottom_curve_path.dart';

class CustomAppbar extends StatelessWidget {
  const CustomAppbar({
    Key? key,
    this.title = '',
    this.withBackButton = false,
  }) : super(key: key);

  final String title;
  final bool withBackButton;

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        ClipPath(
          clipper: CustomBottomCurvePath(),
          child: Container(
            height: 120,
            width: double.infinity,
            decoration: const BoxDecoration(
              gradient: LinearGradient(
                colors: kGradientColor,
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
              ),
            ),
            alignment: Alignment.center,
            child: Text(
              title,
              style: headerFont.copyWith(
                color: Colors.white,
                fontSize: 22,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
        ),
        if (withBackButton)
          Positioned(
            top: 24,
            left: 16,
            child: IconButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              icon: const Icon(
                Icons.arrow_back,
                color: Colors.white,
              ),
            ),
          ),
      ],
    );
  }
}
