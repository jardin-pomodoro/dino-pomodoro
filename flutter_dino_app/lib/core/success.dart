class Success<T> {
  final T? data;

  final bool isSuccess;

  final bool isFailure;

  final String failureMessage;

  Success({
    required this.data,
  })  : isSuccess = true,
        isFailure = false,
        failureMessage = '';

  Success._({
    required this.isSuccess,
    required this.isFailure,
    required this.failureMessage,
  }) : data = null;

  factory Success.fromFailure({String? failureMessage}) {
    return Success._(
        isSuccess: false,
        isFailure: true,
        failureMessage: failureMessage ?? '');
  }
}
