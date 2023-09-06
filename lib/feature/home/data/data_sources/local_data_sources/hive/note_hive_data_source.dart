import 'package:dartz/dartz.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:notink/config/constants/hive_tabel_constant.dart';
import 'package:notink/core/failure/error_handler.dart';
import 'package:notink/feature/auth/data/models/user_model.dart';
import 'package:notink/feature/home/data/data_sources/local_data_sources/hive/note_hive_model.dart';

class NoteHiveDataSource {
  Future<void> init() async {
    Hive.registerAdapter(NoteHiveModelAdapter());
  }

  Future<Either<AppErrorHandler, List<NoteHiveModel>>> addNote({
    required NoteHiveModel noteHiveModel,
  }) async {
    try {
      final box = await Hive.openBox<NoteHiveModel>(HiveTableConstant.noteBox);
      await box.put(
        noteHiveModel.id,
        noteHiveModel,
      );
      return Right(box.values.toList());
    } catch (e) {
      return Left(
        AppErrorHandler(
          message: e.toString(),
          status: false,
        ),
      );
    }
  }

  Future<Either<AppErrorHandler, List<NoteHiveModel>>> updateNote({
    required NoteHiveModel noteHiveModel,
  }) async {
    try {
      final box = await Hive.openBox<NoteHiveModel>(HiveTableConstant.noteBox);
      await box.put(noteHiveModel.id, noteHiveModel);
      return Right(box.values.toList());
    } catch (e) {
      return Left(
        AppErrorHandler(
          message: e.toString(),
          status: false,
        ),
      );
    }
  }

  Future<Either<AppErrorHandler, List<NoteHiveModel>>> deleteNote({
    required String id,
  }) async {
    try {
      final box = await Hive.openBox<NoteHiveModel>(HiveTableConstant.noteBox);
      await box.delete(id);
      return Right(box.values.toList());
    } catch (e) {
      return Left(
        AppErrorHandler(
          message: e.toString(),
          status: false,
        ),
      );
    }
  }

  Future<Either<AppErrorHandler, NoteHiveModel>> getNoteById({
    required String id,
  }) async {
    try {
      final box = await Hive.openBox<NoteHiveModel>(HiveTableConstant.noteBox);
      return Right(box.get(id)!);
    } catch (e) {
      return Left(
        AppErrorHandler(
          message: e.toString(),
          status: false,
        ),
      );
    }
  }

  Future<Either<AppErrorHandler, List<NoteHiveModel>>> getNotesOfUser({
    required UserModel user,
  }) async {
    try {
      final box = await Hive.openBox<NoteHiveModel>(HiveTableConstant.noteBox);
      final data = box.values
          .toList()
          .where(
            (element) => element.user == user.toMap(),
          )
          .toList();
      return Right(data);
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
