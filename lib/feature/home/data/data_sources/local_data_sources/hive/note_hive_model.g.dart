// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'note_hive_model.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class NoteHiveModelAdapter extends TypeAdapter<NoteHiveModel> {
  @override
  final int typeId = 0;

  @override
  NoteHiveModel read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return NoteHiveModel(
      id: fields[0] as String,
      title: fields[1] as String,
      document: fields[2] as Map<String, dynamic>,
      createdTime: fields[3] as DateTime,
      updatedTime: fields[4] as DateTime,
      properties: (fields[5] as Map).cast<String, dynamic>(),
      user: (fields[6] as Map).cast<String, dynamic>(),
    );
  }

  @override
  void write(BinaryWriter writer, NoteHiveModel obj) {
    writer
      ..writeByte(7)
      ..writeByte(0)
      ..write(obj.id)
      ..writeByte(1)
      ..write(obj.title)
      ..writeByte(2)
      ..write(obj.document)
      ..writeByte(3)
      ..write(obj.createdTime)
      ..writeByte(4)
      ..write(obj.updatedTime)
      ..writeByte(5)
      ..write(obj.properties)
      ..writeByte(6)
      ..write(obj.user);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is NoteHiveModelAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
