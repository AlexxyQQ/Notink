import 'package:dartz/dartz.dart';
import 'package:notink/core/failure/error_handler.dart';
import 'package:notink/core/usecase/usecase.dart';
import 'package:notink/feature/home/domain/entities/note_entity.dart';
import 'package:notink/feature/home/domain/repository/note_query_repository.dart';

class UpdateNotesUseCase implements UseCase<List<NoteEntity>, NoteEntity> {
  final INoteQueryRepository repository;

  UpdateNotesUseCase({required this.repository});
  @override
  Future<Either<AppErrorHandler, List<NoteEntity>>> call(
      NoteEntity params) async {
    return await repository.updateNote(noteEntity: params);
  }
}
