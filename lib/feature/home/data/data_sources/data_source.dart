import 'package:dartz/dartz.dart';
import 'package:notink/core/failure/error_handler.dart';
import 'package:notink/feature/auth/data/models/user_model.dart';
import 'package:notink/feature/home/data/models/note_model.dart';

abstract class INoteDataSource {
  Future<Either<AppErrorHandler, NoteModel>> getNoteById({required String id});
  Future<Either<AppErrorHandler, List<NoteModel>>> getNotesOfUser({
    required UserModel user,
  });
  Future<Either<AppErrorHandler, List<NoteModel>>> addNote({
    required NoteModel noteModel,
  });
  Future<Either<AppErrorHandler, List<NoteModel>>> updateNote({
    required NoteModel noteModel,
  });
  Future<Either<AppErrorHandler, List<NoteModel>>> deleteNote({
    required String id,
  });
}
