import 'package:flutter/material.dart';

class DebtorDetailScreen extends StatelessWidget {
  const DebtorDetailScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      appBar: AppBar(title: Text('Debtor Detail')),
      body: Center(child: Text('Debtor history will be here.')),
    );
  }
}
