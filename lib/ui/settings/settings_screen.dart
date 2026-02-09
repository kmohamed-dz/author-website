import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../state/app_state.dart';

class SettingsScreen extends StatelessWidget {
  const SettingsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final state = context.watch<AppState>();

    return Scaffold(
      appBar: AppBar(title: const Text('Settings')),
      body: ListView(
        padding: const EdgeInsets.all(16),
        children: [
          SwitchListTile(
            title: const Text('Scan mode'),
            subtitle: const Text('Use barcode scanner in sales flow'),
            value: state.scanMode,
            onChanged: (value) => state.setScanMode(value),
          ),
        ],
      ),
    );
  }
}
