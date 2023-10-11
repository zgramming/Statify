import 'package:flutter/material.dart';

import '../../utils/constant.dart';

class NavigationDestinationItem extends StatelessWidget {
  const NavigationDestinationItem({
    Key? key,
    required this.prefixAsset,
    required this.selectedPrefixAsset,
    required this.label,
  }) : super(key: key);

  final String prefixAsset;
  final String selectedPrefixAsset;
  final String label;
  @override
  Widget build(BuildContext context) {
    return NavigationDestination(
      icon: Image.asset(
        "$kURLImageAsset/$prefixAsset",
        width: 24,
        height: 24,
      ),
      selectedIcon: Image.asset(
        "$kURLImageAsset/$selectedPrefixAsset",
        width: 24,
        height: 24,
      ),
      label: label,
    );
  }
}
