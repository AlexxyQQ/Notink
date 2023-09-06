import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:notink/feature/home/domain/usecase/add_note_usecase.dart';
import 'package:notink/feature/home/domain/usecase/delete_notes_usecase.dart';
import 'package:notink/feature/home/domain/usecase/get_notes_by_id_usecase.dart';
import 'package:notink/feature/home/domain/usecase/get_users_notes_usecase.dart';
import 'package:notink/feature/home/domain/usecase/update_note_usecase.dart';
import 'package:notink/feature/home/presentaion/bloc/notes/local/local_note_event.dart';
import 'package:notink/feature/home/presentaion/bloc/notes/local/local_note_state.dart';

class LocalNoteBloc extends Bloc<LocalNoteEvent, LocalNoteState> {
  final AddNoteUseCase addNoteUseCase;
  final UpdateNotesUseCase updateNotesUseCase;
  final DeleteNoteUseCase deleteNoteUseCase;
  final GetUsersNotesUseCase getUsersNotesUseCase;
  final GetAllNoteByIDUseCase getAllNoteByIDUseCase;

  LocalNoteBloc({
    required this.addNoteUseCase,
    required this.updateNotesUseCase,
    required this.deleteNoteUseCase,
    required this.getUsersNotesUseCase,
    required this.getAllNoteByIDUseCase,
  }) : super(const LocalNoteInitial()) {
    on<LocalNoteAddedEvent>(addNote);
    on<LocalNoteUpdateEvent>(updateNote);
    on<LocalNoteDeleteEvent>(deleteNote);
    on<LocalNoteOpenedEvent>(openeNote);
    on<LocalGetNotesEvent>(getNotes);
  }

  Future<void> addNote(
      LocalNoteAddedEvent event, Emitter<LocalNoteState> emit) async {
    emit(const LocalNoteLoading());

    final data = await addNoteUseCase.call(event.noteEntity);

    data.fold(
      (error) => emit(LocalNoteError(error: error)),
      (notes) => emit(LocalAddNote(usersNote: notes)),
    );
  }

  Future<void> updateNote(
      LocalNoteUpdateEvent event, Emitter<LocalNoteState> emit) async {
    emit(const LocalNoteLoading());

    final data = await updateNotesUseCase.call(event.noteEntity);

    data.fold(
      (error) => emit(LocalNoteError(error: error)),
      (notes) => emit(LocalUpdateNotes(usersNote: notes)),
    );
  }

  Future<void> deleteNote(
      LocalNoteDeleteEvent event, Emitter<LocalNoteState> emit) async {
    emit(const LocalNoteLoading());

    final data = await deleteNoteUseCase.call(event.noteEntity.id);

    data.fold(
      (error) => emit(LocalNoteError(error: error)),
      (notes) => emit(LocalDeleteNote(
        usersNote: notes,
      )),
    );
  }

  Future<void> openeNote(
      LocalNoteOpenedEvent event, Emitter<LocalNoteState> emit) async {
    emit(const LocalNoteLoading());

    emit(LocalOpenedNote(
      openedNote: event.noteEntity,
    ));
  }

  Future<void> getNotes(
      LocalGetNotesEvent event, Emitter<LocalNoteState> emit) async {
    emit(const LocalNoteLoading());

    final data = await getUsersNotesUseCase.call(event.userEntity);

    data.fold(
      (error) => emit(LocalNoteError(error: error)),
      (notes) => emit(LocalUpdateNotes(usersNote: notes)),
    );
  }
}
