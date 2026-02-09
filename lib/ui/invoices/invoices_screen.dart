import 'package:flutter/material.dart';
import 'invoice_detail_screen.dart';

class InvoicesScreen extends StatelessWidget {
  const InvoicesScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Invoices')),
      body: ListView(
        children: [
          ListTile(
            title: const Text('Today\'s invoices'),
            subtitle: const Text('No invoices yet'),
            onTap: () => Navigator.push(
              context,
              MaterialPageRoute(builder: (_) => const InvoiceDetailScreen()),
            ),
          ),
        ],
      ),
    );
  }
}
