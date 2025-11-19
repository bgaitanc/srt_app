import 'package:dartz/dartz.dart';
import '../../../../core/errors/failures.dart';
import '../entities/user.dart';
import '../repositories/auth_repository.dart';
import 'register_params.dart';

class RegisterUser {
  final AuthRepository repository;

  RegisterUser(this.repository);

  Future<Either<Failure, User>> call(RegisterParams params) async {
    return await repository.register(params);
  }
}
