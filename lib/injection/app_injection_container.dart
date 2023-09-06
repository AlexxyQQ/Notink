// import 'package:get_it/get_it.dart';

import 'package:get_it/get_it.dart';
import 'package:notink/core/network/api/api.dart';
import 'package:notink/core/network/hive/hive_queries.dart';
import 'package:notink/feature/auth/injection/injection_container.dart';
// import 'package:notink/feature/home/injection/injection_container.dart';

final get = GetIt.instance;

void setupDependencyInjection() {
  // ? AnotherInjectionContainer().register();
  AuthInjectionContainer().register();
  // NoteInjectionContainer().register();

  /// Example of [AnotherInjectionContainer] flunction
  ///
  /// class AnotherInjectionContainer {
  ///   var get = GetIt.instance;
  ///
  ///   void register() {
  ///     get.registerLazySingleton(
  ///       () => SomeClass(
  ///         someparamater: get<SomeAnotherClass>(),
  ///       ),
  ///     );
  ///   }
  /// }

  /// `GetIt.instance.registerLazySingleton(() => SomeClass());` is registering a lazy singleton
  /// instance of the `SomeClass` class in the dependency injection container provided by the `GetIt`
  /// package.
  // ? GetIt.instance.registerLazySingleton(() => SomeClass());

  get.registerLazySingleton(() => Api());
  get.registerLazySingleton(() => HiveQueries());
}
