// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'story.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class StoryAdapter extends TypeAdapter<Story> {
  @override
  final int typeId = 0;

  @override
  Story read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return Story(
      id: fields[0] as String?,
      deleted: fields[1] as bool?,
      enabled: fields[2] as bool?,
      updatedAt: fields[3] as String?,
      name: fields[4] as String?,
      categories: (fields[5] as List?)?.cast<Categories>(),
      rateMark: fields[6] as double?,
      status: fields[7] as String?,
      description: fields[8] as String?,
      translator: fields[9] as bool?,
      trend: fields[10] as bool?,
      author: fields[19] as Author?,
      followNum: fields[11] as int?,
      completed: fields[12] as bool?,
      showAds: fields[13] as int?,
      thumbnail: fields[14] as String?,
      totalOfMonth: fields[15] as int?,
      totalOfDay: fields[16] as int?,
      totalOfYear: fields[17] as int?,
      likeNum: fields[21] as int?,
      totalView: fields[18] as int?,
      chapterNum: fields[22] as int?,
      chapterEnableNum: fields[23] as int?,
      chapters: (fields[20] as List?)?.cast<Chapter>(),
    );
  }

  @override
  void write(BinaryWriter writer, Story obj) {
    writer
      ..writeByte(24)
      ..writeByte(0)
      ..write(obj.id)
      ..writeByte(1)
      ..write(obj.deleted)
      ..writeByte(2)
      ..write(obj.enabled)
      ..writeByte(3)
      ..write(obj.updatedAt)
      ..writeByte(4)
      ..write(obj.name)
      ..writeByte(5)
      ..write(obj.categories)
      ..writeByte(6)
      ..write(obj.rateMark)
      ..writeByte(7)
      ..write(obj.status)
      ..writeByte(8)
      ..write(obj.description)
      ..writeByte(9)
      ..write(obj.translator)
      ..writeByte(10)
      ..write(obj.trend)
      ..writeByte(11)
      ..write(obj.followNum)
      ..writeByte(12)
      ..write(obj.completed)
      ..writeByte(13)
      ..write(obj.showAds)
      ..writeByte(14)
      ..write(obj.thumbnail)
      ..writeByte(15)
      ..write(obj.totalOfMonth)
      ..writeByte(16)
      ..write(obj.totalOfDay)
      ..writeByte(17)
      ..write(obj.totalOfYear)
      ..writeByte(18)
      ..write(obj.totalView)
      ..writeByte(19)
      ..write(obj.author)
      ..writeByte(20)
      ..write(obj.chapters)
      ..writeByte(21)
      ..write(obj.likeNum)
      ..writeByte(22)
      ..write(obj.chapterNum)
      ..writeByte(23)
      ..write(obj.chapterEnableNum);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is StoryAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
