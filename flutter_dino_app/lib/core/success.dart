class Success<T> {
  final T? data;

  final bool isSuccess;


  final String failureMessage;

  Success({
    required this.data,
  })  : isSuccess = true,
        failureMessage = '';

  Success._({
    required this.isSuccess,
    required this.failureMessage,
  }) : data = null;

  factory Success.fromFailure({String? failureMessage}) {
    return Success._(
      isSuccess: false,
      failureMessage: failureMessage ?? '',
    );
  }
}
