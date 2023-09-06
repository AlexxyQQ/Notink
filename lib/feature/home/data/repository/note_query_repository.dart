import 'package:dartz/dartz.dart';
import 'package:notink/core/failure/error_handler.dart';
import 'package:notink/feature/auth/data/models/user_model.dart';
import 'package:notink/feature/auth/domain/entities/user_entity.dart';
import 'package:notink/feature/home/data/data_sources/local_data_sources/note_local_data_source.dart';
import 'package:notink/feature/home/data/models/note_model.dart';
import 'package:notink/feature/home/domain/entities/note_entity.dart';
import 'package:notink/feature/home/domain/repository/note_query_repository.dart';

class NoteQueryRepositoryImpl implements INoteQueryRepository {
  final NoteLocalDataSource noteLocalDataSource;

  NoteQueryRepositoryImpl({
    required this.noteLocalDataSource,
  });

  @override
  Future<Either<AppErrorHandler, List<NoteEntity>>> addNote(
      {required NoteEntity noteEntity}) async {
    return await noteLocalDataSource.addNote(
      noteModel: NoteModel.fromEntity(noteEntity),
    );
  }

  @override
  Future<Either<AppErrorHandler, List<NoteEntity>>> deleteNote(
      {required String id}) async {
    final data = await noteLocalDataSource.deleteNote(
      id: id,
    );

    return data.fold(
        (l) => Left(l), (r) => Right(r.map((e) => e.toEntity(e)).toList()));
  }

  @override
  Future<Either<AppErrorHandler, NoteEntity>> getNoteById(
      {required String id}) async {
    final data = await noteLocalDataSource.getNoteById(id: id);

    return data.fold(
      (l) {
        return Left(l);
      },
      (r) {
        return Right(r.toEntity(r));
      },
    );
  }

  @override
  Future<Either<AppErrorHandler, List<NoteEntity>>> getNotesOfUser(
      {required UserEntity user}) async {
    final data = await noteLocalDataSource.getNotesOfUser(
      user: UserModel.fromEntity(user),
    );

    return data.fold(
      (l) {
        return Left(l);
      },
      (r) {
        return Right(r.map((e) => e.toEntity(e)).toList());
      },
    );
  }

  @override
  Future<Either<AppErrorHandler, List<NoteEntity>>> updateNote({
    required NoteEntity noteEntity,
  }) async {
    final data = await noteLocalDataSource.updateNote(
      noteModel: NoteModel.fromEntity(noteEntity),
    );

    return data.fold(
      (l) {
        return Left(l);
      },
      (r) {
        return Right(r.map((e) => e.toEntity(e)).toList());
      },
    );
  }
}
