import 'package:dartz/dartz.dart';
import 'package:notink/core/failure/error_handler.dart';
import 'package:notink/core/usecase/usecase.dart';
import 'package:notink/feature/auth/domain/entities/user_entity.dart';
import 'package:notink/feature/home/domain/entities/note_entity.dart';
import 'package:notink/feature/home/domain/repository/note_query_repository.dart';

class GetUsersNotesUseCase implements UseCase<List<NoteEntity>, UserEntity> {
  final INoteQueryRepository repository;

  GetUsersNotesUseCase({required this.repository});
  @override
  Future<Either<AppErrorHandler, List<NoteEntity>>> call(
      UserEntity params) async {
    return await repository.getNotesOfUser(user: params);
  }
}
