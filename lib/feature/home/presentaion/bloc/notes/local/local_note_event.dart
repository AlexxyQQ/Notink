import 'package:notink/feature/auth/domain/entities/user_entity.dart';
import 'package:notink/feature/home/domain/entities/note_entity.dart';

abstract class LocalNoteEvent {
  const LocalNoteEvent();
}

class LocalNoteInitialEvent extends LocalNoteEvent {
  const LocalNoteInitialEvent();
}

class LocalNoteOpenedEvent extends LocalNoteEvent {
  final NoteEntity noteEntity;

  const LocalNoteOpenedEvent({
    required this.noteEntity,
  });
}

class LocalNoteUpdateEvent extends LocalNoteEvent {
  final NoteEntity noteEntity;

  const LocalNoteUpdateEvent({
    required this.noteEntity,
  });
}

class LocalNoteDeleteEvent extends LocalNoteEvent {
  final NoteEntity noteEntity;

  const LocalNoteDeleteEvent({
    required this.noteEntity,
  });
}

class LocalNoteAddedEvent extends LocalNoteEvent {
  final NoteEntity noteEntity;

  const LocalNoteAddedEvent({
    required this.noteEntity,
  });
}

class LocalGetNotesEvent extends LocalNoteEvent {
  final UserEntity userEntity;
  const LocalGetNotesEvent({
    required this.userEntity,
  });
}
