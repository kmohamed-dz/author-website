import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../state/app_state.dart';
import 'inventory/inventory_screen.dart';
import 'sales/sale_screen.dart';
import 'invoices/invoices_screen.dart';
import 'debts/debts_screen.dart';
import 'settings/settings_screen.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final state = context.watch<AppState>();

    Widget tile(String title, IconData icon, VoidCallback onTap) {
      return Card(
        child: InkWell(
          borderRadius: BorderRadius.circular(18),
          onTap: onTap,
          child: Padding(
            padding: const EdgeInsets.all(18),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Icon(icon, size: 44),
                const SizedBox(height: 10),
                Text(title,
                    style: const TextStyle(
                        fontSize: 18, fontWeight: FontWeight.w700)),
              ],
            ),
          ),
        ),
      );
    }

    return Scaffold(
      appBar: AppBar(
        title: const Text('Musayyer'),
        actions: [
          IconButton(
            icon: const Icon(Icons.settings),
            onPressed: () => Navigator.push(
              context,
              MaterialPageRoute(builder: (_) => const SettingsScreen()),
            ),
          ),
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(14),
        child: Column(
          children: [
            Card(
              child: ListTile(
                title: const Text('This week summary'),
                subtitle: Text(
                  'Invoices: ${state.invoices.length} • Products: ${state.products.length} • Debtors: ${state.debtors.length}',
                ),
              ),
            ),
            const SizedBox(height: 12),
            Expanded(
              child: GridView.count(
                crossAxisCount: 2,
                childAspectRatio: 1.1,
                mainAxisSpacing: 12,
                crossAxisSpacing: 12,
                children: [
                  tile('Inventory', Icons.inventory_2, () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (_) => const InventoryScreen()),
                    );
                  }),
                  tile('New Sale', Icons.point_of_sale, () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (_) => const SaleScreen()),
                    );
                  }),
                  tile('Invoices', Icons.receipt_long, () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (_) => const InvoicesScreen()),
                    );
                  }),
                  tile('Debts', Icons.people_alt, () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (_) => const DebtsScreen()),
                    );
                  }),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
