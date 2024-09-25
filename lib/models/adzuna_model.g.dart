// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'adzuna_model.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class AdzunaModelAdapter extends TypeAdapter<AdzunaModel> {
  @override
  final int typeId = 0;

  @override
  AdzunaModel read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return AdzunaModel(
      mean: fields[0] as double,
      results: (fields[1] as List).cast<Results>(),
      count: fields[2] as int,
    );
  }

  @override
  void write(BinaryWriter writer, AdzunaModel obj) {
    writer
      ..writeByte(3)
      ..writeByte(0)
      ..write(obj.mean)
      ..writeByte(1)
      ..write(obj.results)
      ..writeByte(2)
      ..write(obj.count);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is AdzunaModelAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}

class ResultsAdapter extends TypeAdapter<Results> {
  @override
  final int typeId = 1;

  @override
  Results read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return Results(
      category: fields[0] as Category,
      id: fields[1] as String,
      location: fields[2] as Location,
      longitude: fields[3] as double?,
      company: fields[4] as Company,
      redirectUrl: fields[5] as String,
      latitude: fields[6] as double?,
      salaryMin: fields[7] as double,
      description: fields[8] as String,
      adref: fields[9] as String,
      salaryMax: fields[10] as double,
      title: fields[11] as String,
      created: fields[12] as String,
      salaryIsPredicted: fields[13] as String,
      contractTime: fields[14] as String?,
      contractType: fields[15] as String?,
    );
  }

  @override
  void write(BinaryWriter writer, Results obj) {
    writer
      ..writeByte(16)
      ..writeByte(0)
      ..write(obj.category)
      ..writeByte(1)
      ..write(obj.id)
      ..writeByte(2)
      ..write(obj.location)
      ..writeByte(3)
      ..write(obj.longitude)
      ..writeByte(4)
      ..write(obj.company)
      ..writeByte(5)
      ..write(obj.redirectUrl)
      ..writeByte(6)
      ..write(obj.latitude)
      ..writeByte(7)
      ..write(obj.salaryMin)
      ..writeByte(8)
      ..write(obj.description)
      ..writeByte(9)
      ..write(obj.adref)
      ..writeByte(10)
      ..write(obj.salaryMax)
      ..writeByte(11)
      ..write(obj.title)
      ..writeByte(12)
      ..write(obj.created)
      ..writeByte(13)
      ..write(obj.salaryIsPredicted)
      ..writeByte(14)
      ..write(obj.contractTime)
      ..writeByte(15)
      ..write(obj.contractType);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is ResultsAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}

class CategoryAdapter extends TypeAdapter<Category> {
  @override
  final int typeId = 2;

  @override
  Category read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return Category(
      tag: fields[0] as String,
      label: fields[1] as String,
    );
  }

  @override
  void write(BinaryWriter writer, Category obj) {
    writer
      ..writeByte(2)
      ..writeByte(0)
      ..write(obj.tag)
      ..writeByte(1)
      ..write(obj.label);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is CategoryAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}

class LocationAdapter extends TypeAdapter<Location> {
  @override
  final int typeId = 3;

  @override
  Location read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return Location(
      area: (fields[0] as List).cast<String>(),
      displayName: fields[1] as String,
    );
  }

  @override
  void write(BinaryWriter writer, Location obj) {
    writer
      ..writeByte(2)
      ..writeByte(0)
      ..write(obj.area)
      ..writeByte(1)
      ..write(obj.displayName);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is LocationAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}

class CompanyAdapter extends TypeAdapter<Company> {
  @override
  final int typeId = 4;

  @override
  Company read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return Company(
      displayName: fields[0] as String,
    );
  }

  @override
  void write(BinaryWriter writer, Company obj) {
    writer
      ..writeByte(1)
      ..writeByte(0)
      ..write(obj.displayName);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is CompanyAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
