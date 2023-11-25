// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'most_popular_authors_entity.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class MostPopularAuthorsEntityAdapter
    extends TypeAdapter<MostPopularAuthorsEntity> {
  @override
  final int typeId = 1;

  @override
  MostPopularAuthorsEntity read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return MostPopularAuthorsEntity(
      authorId: fields[0] as int?,
      name: fields[1] as String?,
      url: fields[3] as String?,
      image: fields[2] as String?,
      popularBookTitle: fields[4] as String?,
      popularBookUrl: fields[5] as String?,
      numberPublishedBooks: fields[6] as int?,
    );
  }

  @override
  void write(BinaryWriter writer, MostPopularAuthorsEntity obj) {
    writer
      ..writeByte(7)
      ..writeByte(0)
      ..write(obj.authorId)
      ..writeByte(1)
      ..write(obj.name)
      ..writeByte(2)
      ..write(obj.image)
      ..writeByte(3)
      ..write(obj.url)
      ..writeByte(4)
      ..write(obj.popularBookTitle)
      ..writeByte(5)
      ..write(obj.popularBookUrl)
      ..writeByte(6)
      ..write(obj.numberPublishedBooks);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is MostPopularAuthorsEntityAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
