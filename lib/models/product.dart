import 'package:hive/hive.dart';

part 'product.g.dart';

@HiveType(typeId: 1)
class Product extends HiveObject {
  @HiveField(0)
  String id;
  @HiveField(1)
  String name;
  @HiveField(2)
  String barcode;
  @HiveField(3)
  String unit; // "unit", "kg", ...
  @HiveField(4)
  double quantity;
  @HiveField(5)
  double purchasePrice;
  @HiveField(6)
  double salePrice;
  @HiveField(7)
  int createdAtMs;

  Product({
    required this.id,
    required this.name,
    required this.barcode,
    required this.unit,
    required this.quantity,
    required this.purchasePrice,
    required this.salePrice,
    required this.createdAtMs,
  });
}

/// Manual Hive adapter (no build_runner needed)
class ProductAdapter extends TypeAdapter<Product> {
  @override
  final int typeId = 1;

  @override
  Product read(BinaryReader reader) {
    final numFields = reader.readByte();
    final fields = <int, dynamic>{};
    for (int i = 0; i < numFields; i++) {
      fields[reader.readByte()] = reader.read();
    }
    return Product(
      id: fields[0] as String,
      name: fields[1] as String,
      barcode: fields[2] as String,
      unit: fields[3] as String,
      quantity: fields[4] as double,
      purchasePrice: fields[5] as double,
      salePrice: fields[6] as double,
      createdAtMs: fields[7] as int,
    );
  }

  @override
  void write(BinaryWriter writer, Product obj) {
    writer
      ..writeByte(8)
      ..writeByte(0)
      ..write(obj.id)
      ..writeByte(1)
      ..write(obj.name)
      ..writeByte(2)
      ..write(obj.barcode)
      ..writeByte(3)
      ..write(obj.unit)
      ..writeByte(4)
      ..write(obj.quantity)
      ..writeByte(5)
      ..write(obj.purchasePrice)
      ..writeByte(6)
      ..write(obj.salePrice)
      ..writeByte(7)
      ..write(obj.createdAtMs);
  }
}
