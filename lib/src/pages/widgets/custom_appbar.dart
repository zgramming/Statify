// ignore_for_file: public_member_api_docs, sort_constructors_first
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
    return ClipPath(
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
        child: Stack(
          clipBehavior: Clip.none,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  title,
                  style: headerFont.copyWith(
                    color: Colors.white,
                    fontSize: 22,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ],
            ),
            if (withBackButton)
              Positioned(
                left: 0,
                bottom: 0,
                child: IconButton(
                  onPressed: () => Navigator.of(context).pop(),
                  icon: const Icon(
                    Icons.arrow_back,
                    color: Colors.white,
                  ),
                ),
              ),
          ],
        ),
      ),
    );
  }
}
