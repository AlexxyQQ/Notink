import 'dart:convert';

import 'package:flutter/foundation.dart';
import 'package:notink/feature/auth/data/models/user_model.dart';
import 'package:notink/feature/auth/domain/entities/user_entity.dart';

class NoteEntity {
  final String id;
  final String title;
  final Map<String, dynamic> document;
  final DateTime createdTime;
  final DateTime updatedTime;
  final Map<String, dynamic> properties;
  final UserEntity user;
  NoteEntity({
    required this.id,
    required this.title,
    required this.document,
    required this.createdTime,
    required this.updatedTime,
    required this.properties,
    required this.user,
  });

  NoteEntity.empty()
      : id = '',
        title = '',
        document = {},
        createdTime = DateTime.now(),
        updatedTime = DateTime.now(),
        user = UserEntity.empty(),
        properties = {};

  NoteEntity copyWith({
    String? id,
    String? title,
    Map<String, dynamic>? document,
    DateTime? createdTime,
    DateTime? updatedTime,
    Map<String, dynamic>? properties,
    UserEntity? user,
  }) {
    return NoteEntity(
      id: id ?? this.id,
      title: title ?? this.title,
      document: document ?? this.document,
      createdTime: createdTime ?? this.createdTime,
      updatedTime: updatedTime ?? this.updatedTime,
      properties: properties ?? this.properties,
      user: user ?? this.user,
    );
  }

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

  factory NoteEntity.fromMap(Map<String, dynamic> map) {
    return NoteEntity(
      id: map['id'] as String,
      title: map['title'] as String,
      document: Map<String, dynamic>.from(
        (map['document'] as Map<String, dynamic>),
      ),
      createdTime:
          DateTime.fromMillisecondsSinceEpoch(map['createdTime'] as int),
      updatedTime:
          DateTime.fromMillisecondsSinceEpoch(map['updatedTime'] as int),
      properties: Map<String, dynamic>.from(
        (map['properties'] as Map<String, dynamic>),
      ),
      user: UserModel.fromJson(
        (map['user'] as Map<String, dynamic>),
      ),
    );
  }

  String toJson() => json.encode(toMap());

  factory NoteEntity.fromJson(String source) =>
      NoteEntity.fromMap(json.decode(source) as Map<String, dynamic>);

  @override
  String toString() {
    return 'NoteEntity(id: $id, title: $title, document: $document, createdTime: $createdTime, updatedTime: $updatedTime, properties: $properties)';
  }

  @override
  bool operator ==(covariant NoteEntity other) {
    if (identical(this, other)) return true;

    return other.id == id &&
        other.title == title &&
        other.document == document &&
        other.createdTime == createdTime &&
        other.updatedTime == updatedTime &&
        mapEquals(other.properties, properties);
  }

  @override
  int get hashCode {
    return id.hashCode ^
        title.hashCode ^
        document.hashCode ^
        createdTime.hashCode ^
        updatedTime.hashCode ^
        properties.hashCode;
  }
}
