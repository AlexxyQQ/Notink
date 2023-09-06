import 'package:dartz/dartz.dart';
import 'package:notink/core/failure/error_handler.dart';
import 'package:notink/core/usecase/usecase.dart';
import 'package:notink/feature/home/domain/entities/note_entity.dart';
import 'package:notink/feature/home/domain/repository/note_query_repository.dart';

class DeleteNoteUseCase implements UseCase<List<NoteEntity>, String> {
  final INoteQueryRepository repository;

  DeleteNoteUseCase({required this.repository});
  @override
  Future<Either<AppErrorHandler, List<NoteEntity>>> call(String params) async {
    return await repository.deleteNote(id: params);
  }
}
