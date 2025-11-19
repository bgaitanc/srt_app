import 'package:dartz/dartz.dart';
import '../errors/exceptions.dart';
import '../errors/failures.dart';

Future<Either<Failure, T>> safeCall<T>(Future<T> Function() call) async {
  try {
    return Right(await call());
  } on ServerException catch (e) {
    return Left(ServerFailure(e.message));
  } catch (_) {
    return Left(ServerFailure('Unexpected error'));
  }
}
