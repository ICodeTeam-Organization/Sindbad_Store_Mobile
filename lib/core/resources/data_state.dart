abstract class DataState<T> {
  final T? data;
  final String? message;
  DataState({this.data, this.message});
}

class DataSuccess<T> extends DataState<T> {
  DataSuccess(T? data) : super(data: data);
}

class DataFailed<T> extends DataState<T> {
  final T? error;

  DataFailed(this.error) : super(message: error.toString());
}
