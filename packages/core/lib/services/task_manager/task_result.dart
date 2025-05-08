class TaskResult<T, E> {
  final T? value;
  final E? error;
  final StackTrace? stackTrace;

  const TaskResult({this.value, this.error, this.stackTrace});

  dynamic get valueOrError => value ?? error;

  @override
  String toString() => valueOrError.toString();
}
