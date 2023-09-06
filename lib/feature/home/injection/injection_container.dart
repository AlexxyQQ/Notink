import 'package:notink/feature/home/data/data_sources/local_data_sources/hive/note_hive_data_source.dart';
import 'package:notink/feature/home/data/data_sources/local_data_sources/note_local_data_source.dart';
import 'package:notink/feature/home/data/repository/note_query_repository.dart';
import 'package:notink/feature/home/domain/repository/note_query_repository.dart';
import 'package:notink/feature/home/domain/usecase/add_note_usecase.dart';
import 'package:notink/feature/home/domain/usecase/delete_notes_usecase.dart';
import 'package:notink/feature/home/domain/usecase/get_notes_by_id_usecase.dart';
import 'package:notink/feature/home/domain/usecase/get_users_notes_usecase.dart';
import 'package:notink/feature/home/domain/usecase/update_note_usecase.dart';
import 'package:notink/feature/home/presentaion/bloc/notes/local/local_note_bloc.dart';
import 'package:notink/injection/app_injection_container.dart';

class NoteInjectionContainer {
  void register() {
    get.registerLazySingleton(
      () => NoteHiveDataSource(),
    );

    get.registerLazySingleton(
      () => NoteLocalDataSource(
        noteHiveDataSource: get<NoteHiveDataSource>(),
      ),
    );

    get.registerLazySingleton<INoteQueryRepository>(
      () => NoteQueryRepositoryImpl(
        noteLocalDataSource: get<NoteLocalDataSource>(),
      ),
    );
    // USE CASES

    get.registerLazySingleton(
      () => AddNoteUseCase(
        repository: get<INoteQueryRepository>(),
      ),
    );
    get.registerLazySingleton(
      () => DeleteNoteUseCase(
        repository: get<INoteQueryRepository>(),
      ),
    );
    get.registerLazySingleton(
      () => GetAllNoteByIDUseCase(
        repository: get<INoteQueryRepository>(),
      ),
    );
    get.registerLazySingleton(
      () => UpdateNotesUseCase(
        repository: get<INoteQueryRepository>(),
      ),
    );
    get.registerLazySingleton(
      () => GetUsersNotesUseCase(
        repository: get<INoteQueryRepository>(),
      ),
    );
    // BLOC

    get.registerFactory(() => LocalNoteBloc(
          addNoteUseCase: get<AddNoteUseCase>(),
          updateNotesUseCase: get<UpdateNotesUseCase>(),
          deleteNoteUseCase: get<DeleteNoteUseCase>(),
          getUsersNotesUseCase: get<GetUsersNotesUseCase>(),
          getAllNoteByIDUseCase: get<GetAllNoteByIDUseCase>(),
        ));
  }
}
