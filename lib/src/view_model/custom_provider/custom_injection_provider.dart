import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../model/model/machine/machine_model.dart';

/// Custom Provider ini berfungsi untuk langsung mengambil data dari provider yang sudah ada tanpa harus mempassing data dari parent ke child. Kasusnya :
/// 1. Component1 (Object User)
///   1.1 Component2
///     1.1.1 Component3
///       1.1.1.1. Component4 <= Component4 membutuhkan data dari Component1
///  Dengan asumsi Component4 membutuhkan data dari Component1, maka kita harus mempassing data dari Component1 ke Component2, Component2 ke Component3, dan Component3 ke Component4.
///  Dengan Custom Provider, kita bisa langsung mengambil data dari Component1 tanpa harus mempassing data dari parent ke child.
///  Dengan syarat provider diinisialisasi di atas component yang membutuhkan data tersebut.

class CustomInjectionProvider {
  static final machineById =
      StateProvider.autoDispose<MachineModel?>((ref) => null);
}
