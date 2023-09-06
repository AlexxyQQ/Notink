import 'package:notink/core/failure/error_handler.dart';

abstract class DataState<T> {
  final T? data;
  final AppErrorHandler? error;

  const DataState({this.data, this.error});
}

class DataSuccess<T> extends DataState<T> {
  const DataSuccess(T data) : super(data: data);
}

class DataFailed<T> extends DataState<T> {
  const DataFailed(AppErrorHandler error) : super(error: error);
}
