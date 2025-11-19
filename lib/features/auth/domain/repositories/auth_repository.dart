import 'package:dartz/dartz.dart';
import '../../../../core/errors/failures.dart';
import '../entities/user.dart';
import '../usecases/register_params.dart';

abstract class AuthRepository {
  Future<Either<Failure, User>> login(String email, String password);

  Future<Either<Failure, User>> register(RegisterParams params);
}
