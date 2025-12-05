import 'package:dartz/dartz.dart';
import '../../../../core/errors/failures.dart';
import '../entities/user.dart';
import '../entities/user_info.dart';
import '../usecases/register_params.dart';
import '../usecases/update_profile_params.dart';

abstract class AuthRepository {
  Future<Either<Failure, User>> login(String email, String password);

  Future<Either<Failure, User>> register(RegisterParams params);

  Future<Either<Failure, UserInfo>> getUserInfo();

  Future<Either<Failure, UserInfo>> updateUserProfile(UpdateProfileParams params);
}
