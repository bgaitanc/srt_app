import 'package:dartz/dartz.dart';
import '../../../../core/errors/failures.dart';
import '../../domain/entities/user.dart';
import '../../domain/entities/user_info.dart';
import '../../domain/repositories/auth_repository.dart';
import '../datasource/auth_remote_data_source.dart';
import '../../../../core/utils/safe_call.dart';
import '../../domain/usecases/register_params.dart';

class AuthRepositoryImpl implements AuthRepository {
  final AuthRemoteDataSource remote;

  AuthRepositoryImpl(this.remote);

  @override
  Future<Either<Failure, User>> login(String email, String password) {
    return safeCall(() => remote.login(email, password));
  }

  @override
  Future<Either<Failure, User>> register(RegisterParams params) {
    return safeCall(() => remote.register(params));
  }

  @override
  Future<Either<Failure, UserInfo>> getUserInfo() {
    return safeCall(() => remote.getUserInfo());
  }
}
