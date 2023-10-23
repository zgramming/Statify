import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../utils/enum.dart';

class CustomStateProvider {
  static final currentMenuLDA =
      StateProvider<MenuLDAEnum>((ref) => MenuLDAEnum.home);
}
