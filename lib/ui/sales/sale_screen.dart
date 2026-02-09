import 'package:flutter/material.dart';
import 'scanner_screen.dart';

class SaleScreen extends StatelessWidget {
  const SaleScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('New Sale')),
      body: Center(
        child: FilledButton.icon(
          onPressed: () => Navigator.push(
            context,
            MaterialPageRoute(builder: (_) => const ScannerScreen()),
          ),
          icon: const Icon(Icons.qr_code_scanner),
          label: const Text('Scan barcode'),
        ),
      ),
    );
  }
}
