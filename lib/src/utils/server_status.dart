enum ResponseStatus {
  logicError('Logic error'),
  serverError('Server error'),
  noMoreData('No more data'),
  ok('OK');

  final String message;

  const ResponseStatus(this.message);

  @override
  String toString() => message;
}
