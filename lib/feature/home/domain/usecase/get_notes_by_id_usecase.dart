import 'package:dartz/dartz.dart';
import 'package:notink/core/failure/error_handler.dart';
import 'package:notink/core/usecase/usecase.dart';
import 'package:notink/feature/home/domain/entities/note_entity.dart';
import 'package:notink/feature/home/domain/repository/note_query_repository.dart';

class GetAllNoteByIDUseCase implements UseCase<NoteEntity, String> {
  final INoteQueryRepository repository;

  GetAllNoteByIDUseCase({required this.repository});
  @override
  Future<Either<AppErrorHandler, NoteEntity>> call(String params) async {
    return await repository.getNoteById(id: params);
  }
}
