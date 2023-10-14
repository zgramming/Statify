import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'src/injection.dart';
import 'src/model/database/database.dart';

import 'src/app.dart';

// factory AuthenticationResponseModel.fromJson(Map<String, dynamic> json) =>
//     _$AuthenticationResponseModelFromJson(json);

// /// Connect the generated [_$AuthenticationResponseModelToJson] function to the `toJson` method.
// Map<String, dynamic> toJson() => _$AuthenticationResponseModelToJson(this);

// dart run build_runner watch --delete-conflicting-outputs

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();

  runApp(
    ProviderScope(
      overrides: [
        databaseProvider.overrideWithValue(MyDatabase()),
      ],
      child: const MyApp(),
    ),
  );
}
