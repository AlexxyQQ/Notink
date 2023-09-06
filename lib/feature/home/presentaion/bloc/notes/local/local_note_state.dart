import 'package:equatable/equatable.dart';
import 'package:notink/core/failure/error_handler.dart';
import 'package:notink/feature/home/domain/entities/note_entity.dart';

abstract class LocalNoteState extends Equatable {
  final AppErrorHandler? error;
  final List<NoteEntity>? usersNote;
  final NoteEntity? openedNote;

  const LocalNoteState({
    this.error,
    this.usersNote,
    this.openedNote,
  });

  @override
  List<Object?> get props => [
        error,
        usersNote,
        openedNote,
      ];
}

class LocalNoteInitial extends LocalNoteState {
  const LocalNoteInitial()
      : super(
          usersNote: const [],
          error: null,
          openedNote: null,
        );
}

class LocalNoteLoading extends LocalNoteState {
  const LocalNoteLoading();
}

class LocalOpenedNote extends LocalNoteState {
  const LocalOpenedNote({
    required NoteEntity openedNote,
  }) : super(
          openedNote: openedNote,
        );
}

class LocalNoteError extends LocalNoteState {
  const LocalNoteError({
    required AppErrorHandler error,
  }) : super(
          error: error,
        );
}

class LocalUpdateNotes extends LocalNoteState {
  const LocalUpdateNotes({
    required List<NoteEntity> usersNote,
  }) : super(
          usersNote: usersNote,
        );
}

class LocalDeleteNote extends LocalNoteState {
  const LocalDeleteNote({
    required List<NoteEntity> usersNote,
  }) : super(
          usersNote: usersNote,
        );
}

class LocalAddNote extends LocalNoteState {
  const LocalAddNote({
    required List<NoteEntity> usersNote,
  }) : super(
          usersNote: usersNote,
        );
}
