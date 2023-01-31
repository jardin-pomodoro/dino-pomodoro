import 'package:dartz/dartz.dart';
import 'failure.dart';

abstract class BaseUseCase<T> {
  const BaseUseCase();
}

abstract class UseCase<T, P> extends BaseUseCase<T> {
  const UseCase() : super();

  Future<Either<Failure, T>> call(P params);
}

abstract class NoParamsUseCase<T> extends BaseUseCase<T> {
  const NoParamsUseCase() : super();

  Future<T> call();
}

abstract class BasicUseCase<T, P> extends BaseUseCase<T> {
  const BasicUseCase() : super();

  Future<T> call(P params);
}
