import 'package:hive/hive.dart';

@HiveType(typeId: 2)
class Invoice extends HiveObject {
  @HiveField(0)
  String id;
  @HiveField(1)
  int createdAtMs;
  @HiveField(2)
  List<InvoiceItem> items;
  @HiveField(3)
  double total;

  Invoice({
    required this.id,
    required this.createdAtMs,
    required this.items,
    required this.total,
  });
}

@HiveType(typeId: 3)
class InvoiceItem {
  @HiveField(0)
  String productId;
  @HiveField(1)
  String name;
  @HiveField(2)
  String barcode;
  @HiveField(3)
  double qty;
  @HiveField(4)
  double price;

  InvoiceItem({
    required this.productId,
    required this.name,
    required this.barcode,
    required this.qty,
    required this.price,
  });
}

class InvoiceAdapter extends TypeAdapter<Invoice> {
  @override
  final int typeId = 2;

  @override
  Invoice read(BinaryReader reader) {
    final n = reader.readByte();
    final f = <int, dynamic>{};
    for (int i = 0; i < n; i++) {
      f[reader.readByte()] = reader.read();
    }
    return Invoice(
      id: f[0] as String,
      createdAtMs: f[1] as int,
      items: (f[2] as List).cast<InvoiceItem>(),
      total: f[3] as double,
    );
  }

  @override
  void write(BinaryWriter writer, Invoice obj) {
    writer
      ..writeByte(4)
      ..writeByte(0)
      ..write(obj.id)
      ..writeByte(1)
      ..write(obj.createdAtMs)
      ..writeByte(2)
      ..write(obj.items)
      ..writeByte(3)
      ..write(obj.total);
  }
}

class InvoiceItemAdapter extends TypeAdapter<InvoiceItem> {
  @override
  final int typeId = 3;

  @override
  InvoiceItem read(BinaryReader reader) {
    final n = reader.readByte();
    final f = <int, dynamic>{};
    for (int i = 0; i < n; i++) {
      f[reader.readByte()] = reader.read();
    }
    return InvoiceItem(
      productId: f[0] as String,
      name: f[1] as String,
      barcode: f[2] as String,
      qty: f[3] as double,
      price: f[4] as double,
    );
  }

  @override
  void write(BinaryWriter writer, InvoiceItem obj) {
    writer
      ..writeByte(5)
      ..writeByte(0)
      ..write(obj.productId)
      ..writeByte(1)
      ..write(obj.name)
      ..writeByte(2)
      ..write(obj.barcode)
      ..writeByte(3)
      ..write(obj.qty)
      ..writeByte(4)
      ..write(obj.price);
  }
}
