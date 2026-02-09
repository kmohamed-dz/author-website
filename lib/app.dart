import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'state/app_state.dart';
import 'theme.dart';
import 'ui/home_screen.dart';

class MusayyerApp extends StatelessWidget {
  const MusayyerApp({super.key});

  @override
  Widget build(BuildContext context) {
    return Consumer<AppState>(
      builder: (_, state, __) {
        return MaterialApp(
          debugShowCheckedModeBanner: false,
          title: 'Musayyer',
          theme: buildTheme(),
          home: const HomeScreen(),
        );
      },
    );
  }
}
