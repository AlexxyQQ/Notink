import 'package:notink/feature/auth/data/models/user_model.dart';
import 'package:notink/feature/home/data/data_sources/local_data_sources/hive/note_hive_model.dart';
import 'package:notink/feature/home/domain/entities/note_entity.dart';

class NoteModel extends NoteEntity {
  NoteModel({
    required String id,
    required String title,
    required Map<String, dynamic> document,
    required DateTime createdTime,
    required DateTime updatedTime,
    required Map<String, dynamic> properties,
    required UserModel user,
  }) : super(
          id: id,
          title: title,
          document: document,
          createdTime: createdTime,
          updatedTime: updatedTime,
          properties: properties,
          user: user,
        );

  factory NoteModel.fromMap(Map<String, dynamic> map) {
    return NoteModel(
      id: map['id'] as String,
      title: map['title'] as String,
      document: Map<String, dynamic>.from(
        (map['document'] as Map<String, dynamic>),
      ),
      createdTime: DateTime.fromMillisecondsSinceEpoch(
        map['createdTime'] as int,
      ),
      updatedTime: DateTime.fromMillisecondsSinceEpoch(
        map['updatedTime'] as int,
      ),
      properties: Map<String, dynamic>.from(
        (map['properties'] as Map<String, dynamic>),
      ),
      user: UserModel.fromMap(
        (map['user'] as Map<String, dynamic>),
      ),
    );
  }
  @override
  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'id': id,
      'title': title,
      'document': document,
      'createdTime': createdTime.millisecondsSinceEpoch,
      'updatedTime': updatedTime.millisecondsSinceEpoch,
      'properties': properties,
      'user': user.toMap(),
    };
  }

  NoteEntity toEntity(NoteModel model) {
    return NoteEntity(
      id: model.id,
      title: model.title,
      document: model.document,
      createdTime: model.createdTime,
      updatedTime: model.updatedTime,
      properties: model.properties,
      user: model.user,
    );
  }

  NoteHiveModel toHiveModel() {
    return NoteHiveModel(
      id: id,
      title: title,
      document: document,
      createdTime: createdTime,
      updatedTime: updatedTime,
      properties: properties,
      user: user.toMap(),
    );
  }

  factory NoteModel.fromEntity(NoteEntity entity) {
    return NoteModel(
      id: entity.id,
      title: entity.title,
      document: entity.document,
      createdTime: entity.createdTime,
      updatedTime: entity.updatedTime,
      properties: entity.properties,
      user: UserModel.fromEntity(entity.user),
    );
  }
}
