import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'data/db.dart';
import 'state/app_state.dart';
import 'app.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await AppDb.init();
  final appState = AppState();
  await appState.load();
  runApp(
    ChangeNotifierProvider.value(
      value: appState,
      child: const MusayyerApp(),
    ),
  );
}
