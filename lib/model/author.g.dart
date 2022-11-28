// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'author.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class AuthorAdapter extends TypeAdapter<Author> {
  @override
  final int typeId = 3;

  @override
  Author read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return Author(
      id: fields[0] as String?,
      deleted: fields[1] as bool?,
      enabled: fields[2] as bool?,
      createdAt: fields[3] as String?,
      updatedAt: fields[4] as String?,
      birthDate: fields[5] as String?,
      fullName: fields[6] as String?,
      tagName: fields[7] as String?,
      password: fields[8] as String?,
      phoneNumber: fields[9] as String?,
      username: fields[10] as String?,
      gender: fields[11] as bool?,
      avatarUrl: fields[12] as String?,
      coverImage: fields[13] as String?,
      point: fields[14] as int?,
      vip: fields[15] as bool?,
    );
  }

  @override
  void write(BinaryWriter writer, Author obj) {
    writer
      ..writeByte(16)
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
      ..write(obj.birthDate)
      ..writeByte(6)
      ..write(obj.fullName)
      ..writeByte(7)
      ..write(obj.tagName)
      ..writeByte(8)
      ..write(obj.password)
      ..writeByte(9)
      ..write(obj.phoneNumber)
      ..writeByte(10)
      ..write(obj.username)
      ..writeByte(11)
      ..write(obj.gender)
      ..writeByte(12)
      ..write(obj.avatarUrl)
      ..writeByte(13)
      ..write(obj.coverImage)
      ..writeByte(14)
      ..write(obj.point)
      ..writeByte(15)
      ..write(obj.vip);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is AuthorAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
