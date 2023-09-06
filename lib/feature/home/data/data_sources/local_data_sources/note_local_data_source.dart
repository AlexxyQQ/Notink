import 'package:dartz/dartz.dart';
import 'package:notink/core/failure/error_handler.dart';
import 'package:notink/feature/auth/data/models/user_model.dart';
import 'package:notink/feature/home/data/data_sources/data_source.dart';
import 'package:notink/feature/home/data/data_sources/local_data_sources/hive/note_hive_data_source.dart';
import 'package:notink/feature/home/data/models/note_model.dart';
import 'package:notink/feature/home/domain/entities/note_entity.dart';

class NoteLocalDataSource implements INoteDataSource {
  final NoteHiveDataSource noteHiveDataSource;

  NoteLocalDataSource({
    required this.noteHiveDataSource,
  });

  @override
  Future<Either<AppErrorHandler, List<NoteModel>>> addNote(
      {required NoteModel noteModel}) async {
    try {
      final data = await noteHiveDataSource.addNote(
        noteHiveModel: noteModel.toHiveModel(),
      );

      return data.fold(
        (l) {
          return Left(l);
        },
        (r) {
          return Right(
            r
                .map(
                  (e) => e.toModel(e),
                )
                .toList(),
          );
        },
      );
    } catch (e) {
      return Left(
        AppErrorHandler(
          message: e.toString(),
          status: false,
        ),
      );
    }
  }

  @override
  Future<Either<AppErrorHandler, List<NoteModel>>> deleteNote(
      {required String id}) async {
    try {
      final data = await noteHiveDataSource.deleteNote(id: id);

      return data.fold(
        (l) {
          return Left(l);
        },
        (r) {
          return Right(
            r
                .map(
                  (e) => e.toModel(e),
                )
                .toList(),
          );
        },
      );
    } catch (e) {
      return Left(
        AppErrorHandler(
          message: e.toString(),
          status: false,
        ),
      );
    }
  }

  @override
  Future<Either<AppErrorHandler, NoteModel>> getNoteById(
      {required String id}) async {
    try {
      final data = await noteHiveDataSource.getNoteById(id: id);

      return data.fold(
        (l) {
          return Left(l);
        },
        (r) {
          return Right(r.toModel(r));
        },
      );
    } catch (e) {
      return Left(
        AppErrorHandler(
          message: e.toString(),
          status: false,
        ),
      );
    }
  }

  @override
  Future<Either<AppErrorHandler, List<NoteModel>>> getNotesOfUser(
      {required UserModel user}) async {
    try {
      final data = await noteHiveDataSource.getNotesOfUser(user: user);

      return data.fold(
        (l) {
          return Left(l);
        },
        (r) {
          return Right(
            r
                .map(
                  (e) => e.toModel(e),
                )
                .toList(),
          );
        },
      );
    } catch (e) {
      return Left(
        AppErrorHandler(
          message: e.toString(),
          status: false,
        ),
      );
    }
  }

  @override
  Future<Either<AppErrorHandler, List<NoteModel>>> updateNote(
      {required NoteModel noteModel}) async {
    try {
      final data = await noteHiveDataSource.updateNote(
          noteHiveModel: noteModel.toHiveModel());

      return data.fold(
        (l) {
          return Left(l);
        },
        (r) {
          return Right(
            r
                .map(
                  (e) => e.toModel(e),
                )
                .toList(),
          );
        },
      );
    } catch (e) {
      return Left(
        AppErrorHandler(
          message: e.toString(),
          status: false,
        ),
      );
    }
  }
}
