// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'detail_chapter.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class ChapterAdapter extends TypeAdapter<Chapter> {
  @override
  final int typeId = 2;

  @override
  Chapter read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return Chapter(
      id: fields[0] as String?,
      deleted: fields[1] as bool?,
      enabled: fields[2] as bool?,
      createdAt: fields[3] as String?,
      updatedAt: fields[4] as dynamic,
      createdBy: fields[5] as dynamic,
      updatedBy: fields[6] as dynamic,
      name: fields[7] as String?,
      content: fields[8] as String?,
      showAds: fields[9] as dynamic,
      isNew: fields[10] as dynamic,
      price: fields[11] as double?,
      totalView: fields[12] as int?,
      bookId: fields[13] as String?,
    );
  }

  @override
  void write(BinaryWriter writer, Chapter obj) {
    writer
      ..writeByte(14)
      ..writeByte(0)
      ..write(obj.id)
      ..writeByte(1)
      ..write(obj.deleted)
      ..writeByte(2)
      ..write(obj.enabled)
      ..writeByte(3)
      ..write(obj.createdAt)
      ..writeByte(4)
      ..write(obj.updatedAt)
      ..writeByte(5)
      ..write(obj.createdBy)
      ..writeByte(6)
      ..write(obj.updatedBy)
      ..writeByte(7)
      ..write(obj.name)
      ..writeByte(8)
      ..write(obj.content)
      ..writeByte(9)
      ..write(obj.showAds)
      ..writeByte(10)
      ..write(obj.isNew)
      ..writeByte(11)
      ..write(obj.price)
      ..writeByte(12)
      ..write(obj.totalView)
      ..writeByte(13)
      ..write(obj.bookId);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is ChapterAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
