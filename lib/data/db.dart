import 'package:hive/hive.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:path_provider/path_provider.dart';

import '../models/product.dart';
import '../models/invoice.dart';
import '../models/debtor.dart';

class AppDb {
  static const productsBoxName = 'products';
  static const invoicesBoxName = 'invoices';
  static const debtorsBoxName = 'debtors';
  static const settingsBoxName = 'settings';

  static Future<void> init() async {
    final dir = await getApplicationDocumentsDirectory();
    await Hive.initFlutter(dir.path);

    Hive.registerAdapter(ProductAdapter());
    Hive.registerAdapter(InvoiceAdapter());
    Hive.registerAdapter(InvoiceItemAdapter());
    Hive.registerAdapter(DebtorAdapter());
    Hive.registerAdapter(DebtEntryAdapter());

    await Hive.openBox<Product>(productsBoxName);
    await Hive.openBox<Invoice>(invoicesBoxName);
    await Hive.openBox<Debtor>(debtorsBoxName);
    await Hive.openBox(settingsBoxName);
  }

  static Box<Product> products() => Hive.box<Product>(productsBoxName);
  static Box<Invoice> invoices() => Hive.box<Invoice>(invoicesBoxName);
  static Box<Debtor> debtors() => Hive.box<Debtor>(debtorsBoxName);
  static Box settings() => Hive.box(settingsBoxName);
}
