import 'package:hive_flutter/hive_flutter.dart';
import 'package:notink/config/constants/hive_tabel_constant.dart';
import 'package:notink/feature/auth/data/models/user_model.dart';
import 'package:notink/feature/home/data/models/note_model.dart';
import 'package:notink/feature/home/domain/entities/note_entity.dart';
import 'package:uuid/uuid.dart';

part 'note_hive_model.g.dart';

@HiveType(typeId: HiveTableConstant.noteTableID)
class NoteHiveModel extends HiveObject {
  NoteHiveModel(
      {required this.id,
      required this.title,
      required this.document,
      required this.createdTime,
      required this.updatedTime,
      required this.properties,
      required this.user});

  @HiveField(0)
  final String id;

  @HiveField(1)
  String title;

  @HiveField(2)
  Map<String, dynamic> document;

  @HiveField(3)
  DateTime createdTime;

  @HiveField(4)
  DateTime updatedTime;

  @HiveField(5)
  Map<String, dynamic> properties;

  @HiveField(6)
  Map<String, dynamic> user;

  factory NoteHiveModel.create({
    required String? title,
    required Map<String, dynamic>? document,
    DateTime? createdAtTime,
    DateTime? createdAtDate,
    Map<String, dynamic>? properties,
  }) =>
      NoteHiveModel(
        id: const Uuid().v1(),
        title: title ?? "",
        document: document ?? {},
        createdTime: createdAtTime ?? DateTime.now(),
        updatedTime: createdAtDate ?? DateTime.now(),
        properties: properties ?? {},
        user: UserModel.empty().toMap(),
      );

  factory NoteHiveModel.fromMap(Map<String, dynamic> map) {
    return NoteHiveModel(
      id: map['id'] as String,
      title: map['title'] as String,
      document: Map<String, dynamic>.from(
        (map['document'] as Map<String, dynamic>),
      ),
      createdTime: DateTime.fromMillisecondsSinceEpoch(
        map['createdAtTime'] as int,
      ),
      updatedTime: DateTime.fromMillisecondsSinceEpoch(
        map['createdAtDate'] as int,
      ),
      properties: Map<String, dynamic>.from(
        (map['properties'] as Map<String, dynamic>),
      ),
      user: UserModel.fromJson(
        (map['user'] as Map<String, dynamic>),
      ).toMap(),
    );
  }

  NoteEntity toEntity(NoteHiveModel model) {
    return NoteEntity(
      id: model.id,
      title: model.title,
      document: model.document,
      createdTime: model.createdTime,
      updatedTime: model.updatedTime,
      properties: model.properties,
      user: UserModel.fromMap(model.user),
    );
  }

  NoteHiveModel fromEntity(NoteEntity entity) {
    return NoteHiveModel(
      id: entity.id,
      title: entity.title,
      document: entity.document,
      createdTime: entity.createdTime,
      updatedTime: entity.updatedTime,
      properties: entity.properties,
      user: entity.user.toMap(),
    );
  }

  NoteModel toModel(NoteHiveModel model) {
    return NoteModel(
      id: model.id,
      title: model.title,
      document: model.document,
      createdTime: model.createdTime,
      updatedTime: model.updatedTime,
      properties: model.properties,
      user: UserModel.fromMap(model.user),
    );
  }

  NoteHiveModel fromModel(NoteModel model) {
    return NoteHiveModel(
      id: model.id,
      title: model.title,
      document: model.document,
      createdTime: model.createdTime,
      updatedTime: model.updatedTime,
      properties: model.properties,
      user: model.user.toMap(),
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'id': id,
      'title': title,
      'document': document,
      'createdAtTime': createdTime.millisecondsSinceEpoch,
      'createdAtDate': updatedTime.millisecondsSinceEpoch,
      'properties': properties,
    };
  }

  NoteHiveModel copyWith({
    String? id,
    String? title,
    Map<String, dynamic>? document,
    DateTime? createdTime,
    DateTime? updatedTime,
    Map<String, dynamic>? properties,
    Map<String, dynamic>? user,
  }) {
    return NoteHiveModel(
      id: id ?? this.id,
      title: title ?? this.title,
      document: document ?? this.document,
      createdTime: createdTime ?? this.createdTime,
      updatedTime: updatedTime ?? this.updatedTime,
      properties: properties ?? this.properties,
      user: user ?? this.user,
    );
  }

  @override
  String toString() {
    return 'NoteHiveModel(id: $id, title: $title, document: $document, createdTime: $createdTime, updatedTime: $updatedTime, properties: $properties, user: $user)';
  }
}
