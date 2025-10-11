// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'main_category_entity.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class CategoryEntityAdapter extends TypeAdapter<CategoryEntity> {
  @override
  final int typeId = 0;

  @override
  CategoryEntity read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return CategoryEntity(
      categoryId: fields[0] as int,
      categoryName: fields[1] as String,
      categoryImage: fields[2] as String,
      categoryLevel: fields[3] as int,
      categoryParentId: fields[4] as int,
      categoryType: fields[5] as int,
    );
  }

  @override
  void write(BinaryWriter writer, CategoryEntity obj) {
    writer
      ..writeByte(6)
      ..writeByte(0)
      ..write(obj.categoryId)
      ..writeByte(1)
      ..write(obj.categoryName)
      ..writeByte(2)
      ..write(obj.categoryImage)
      ..writeByte(3)
      ..write(obj.categoryLevel)
      ..writeByte(4)
      ..write(obj.categoryParentId)
      ..writeByte(5)
      ..write(obj.categoryType);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is CategoryEntityAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
