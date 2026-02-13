import 'package:flutter/material.dart';
import 'package:uuid/uuid.dart';
import '../data/db.dart';
import '../models/product.dart';
import '../models/invoice.dart';
import '../models/debtor.dart';

class AppState extends ChangeNotifier {
  final _uuid = const Uuid();

  bool scanMode = true; // scan vs manual

  List<Product> products = [];
  List<Invoice> invoices = [];
  List<Debtor> debtors = [];

  Future<void> load() async {
    scanMode = (AppDb.settings().get('scanMode') as bool?) ?? true;

    products = AppDb.products().values.toList()
      ..sort((a, b) => b.createdAtMs.compareTo(a.createdAtMs));
    invoices = AppDb.invoices().values.toList()
      ..sort((a, b) => b.createdAtMs.compareTo(a.createdAtMs));
    debtors = AppDb.debtors().values.toList()
      ..sort((a, b) => b.createdAtMs.compareTo(a.createdAtMs));
    notifyListeners();
  }

  Future<void> setScanMode(bool v) async {
    scanMode = v;
    await AppDb.settings().put('scanMode', v);
    notifyListeners();
  }

  // PRODUCTS
  Future<void> upsertProduct(Product p) async {
    await AppDb.products().put(p.id, p);
    await load();
  }

  Future<void> deleteProduct(String id) async {
    await AppDb.products().delete(id);
    await load();
  }

  Product? findProductByBarcode(String barcode) {
    try {
      return products.firstWhere((p) => p.barcode.trim() == barcode.trim());
    } catch (_) {
      return null;
    }
  }

  String newId() => _uuid.v4();

  // SALES / INVOICES
  Future<void> createInvoice(List<InvoiceItem> items) async {
    final total = items.fold(0.0, (a, it) => a + it.qty * it.price);
    final invoice = Invoice(
      id: _uuid.v4(),
      createdAtMs: DateTime.now().millisecondsSinceEpoch,
      items: items,
      total: total,
    );

    // decrease stock
    for (final it in items) {
      final p = AppDb.products().get(it.productId);
      if (p != null) {
        p.quantity = (p.quantity - it.qty);
        if (p.quantity < 0) p.quantity = 0;
        await p.save();
      }
    }

    await AppDb.invoices().put(invoice.id, invoice);
    await load();
  }

  // DEBTS
  Future<void> addDebtor({required String name, required String phone}) async {
    final d = Debtor(
      id: _uuid.v4(),
      name: name.trim(),
      phone: phone.trim(),
      createdAtMs: DateTime.now().millisecondsSinceEpoch,
      entries: [],
    );
    await AppDb.debtors().put(d.id, d);
    await load();
  }

  Future<void> addDebtEntry({
    required String debtorId,
    required DebtEntryType type,
    required double amount,
    String note = '',
  }) async {
    final d = AppDb.debtors().get(debtorId);
    if (d == null) return;

    d.entries.add(DebtEntry(
      typeIndex: type.index,
      amount: amount,
      atMs: DateTime.now().millisecondsSinceEpoch,
      note: note,
    ));
    await d.save();
    await load();
  }
}
