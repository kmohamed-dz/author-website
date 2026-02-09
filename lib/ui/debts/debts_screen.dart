import 'package:flutter/material.dart';
import 'debtor_detail_screen.dart';
import 'debtor_form_screen.dart';

class DebtsScreen extends StatelessWidget {
  const DebtsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Debts')),
      body: ListView(
        children: [
          ListTile(
            title: const Text('No debtors yet'),
            onTap: () => Navigator.push(
              context,
              MaterialPageRoute(builder: (_) => const DebtorDetailScreen()),
            ),
          ),
        ],
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () => Navigator.push(
          context,
          MaterialPageRoute(builder: (_) => const DebtorFormScreen()),
        ),
        child: const Icon(Icons.person_add),
      ),
    );
  }
}
