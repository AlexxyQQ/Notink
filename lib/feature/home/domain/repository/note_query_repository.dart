import 'package:dartz/dartz.dart';
import 'package:notink/core/failure/error_handler.dart';
import 'package:notink/feature/auth/domain/entities/user_entity.dart';
import 'package:notink/feature/home/domain/entities/note_entity.dart';

abstract class INoteQueryRepository {
  Future<Either<AppErrorHandler, NoteEntity>> getNoteById({required String id});
  Future<Either<AppErrorHandler, List<NoteEntity>>> getNotesOfUser({
    required UserEntity user,
  });
  Future<Either<AppErrorHandler, List<NoteEntity>>> addNote({
    required NoteEntity noteEntity,
  });
  Future<Either<AppErrorHandler, List<NoteEntity>>> updateNote({
    required NoteEntity noteEntity,
  });
  Future<Either<AppErrorHandler, List<NoteEntity>>> deleteNote({
    required String id,
  });
}
