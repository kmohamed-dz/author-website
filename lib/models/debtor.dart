import 'package:hive/hive.dart';

@HiveType(typeId: 4)
class Debtor extends HiveObject {
  @HiveField(0)
  String id;
  @HiveField(1)
  String name;
  @HiveField(2)
  String phone;
  @HiveField(3)
  int createdAtMs;
  @HiveField(4)
  List<DebtEntry> entries;

  Debtor({
    required this.id,
    required this.name,
    required this.phone,
    required this.createdAtMs,
    required this.entries,
  });

  double get totalDebt => entries
      .where((e) => e.type == DebtEntryType.debt)
      .fold(0.0, (a, e) => a + e.amount);

  double get totalPaid => entries
      .where((e) => e.type == DebtEntryType.payment)
      .fold(0.0, (a, e) => a + e.amount);

  double get remaining => totalDebt - totalPaid;
}

enum DebtEntryType { debt, payment }

@HiveType(typeId: 5)
class DebtEntry {
  @HiveField(0)
  int typeIndex; // 0 debt, 1 payment
  @HiveField(1)
  double amount;
  @HiveField(2)
  int atMs;
  @HiveField(3)
  String note;

  DebtEntry({
    required this.typeIndex,
    required this.amount,
    required this.atMs,
    required this.note,
  });

  DebtEntryType get type => DebtEntryType.values[typeIndex];
}

class DebtorAdapter extends TypeAdapter<Debtor> {
  @override
  final int typeId = 4;

  @override
  Debtor read(BinaryReader reader) {
    final n = reader.readByte();
    final f = <int, dynamic>{};
    for (int i = 0; i < n; i++) {
      f[reader.readByte()] = reader.read();
    }
    return Debtor(
      id: f[0] as String,
      name: f[1] as String,
      phone: f[2] as String,
      createdAtMs: f[3] as int,
      entries: (f[4] as List).cast<DebtEntry>(),
    );
  }

  @override
  void write(BinaryWriter writer, Debtor obj) {
    writer
      ..writeByte(5)
      ..writeByte(0)
      ..write(obj.id)
      ..writeByte(1)
      ..write(obj.name)
      ..writeByte(2)
      ..write(obj.phone)
      ..writeByte(3)
      ..write(obj.createdAtMs)
      ..writeByte(4)
      ..write(obj.entries);
  }
}

class DebtEntryAdapter extends TypeAdapter<DebtEntry> {
  @override
  final int typeId = 5;

  @override
  DebtEntry read(BinaryReader reader) {
    final n = reader.readByte();
    final f = <int, dynamic>{};
    for (int i = 0; i < n; i++) {
      f[reader.readByte()] = reader.read();
    }
    return DebtEntry(
      typeIndex: f[0] as int,
      amount: f[1] as double,
      atMs: f[2] as int,
      note: f[3] as String,
    );
  }

  @override
  void write(BinaryWriter writer, DebtEntry obj) {
    writer
      ..writeByte(4)
      ..writeByte(0)
      ..write(obj.typeIndex)
      ..writeByte(1)
      ..write(obj.amount)
      ..writeByte(2)
      ..write(obj.atMs)
      ..writeByte(3)
      ..write(obj.note);
  }
}
