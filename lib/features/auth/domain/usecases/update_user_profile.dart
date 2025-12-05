import 'package:dartz/dartz.dart';
import '../../../../core/errors/failures.dart';
import '../../../../core/usecases/usecase.dart';
import '../entities/user_info.dart';
import '../repositories/auth_repository.dart';
import 'update_profile_params.dart';

class UpdateUserProfile implements UseCase<Either<Failure, UserInfo>, UpdateProfileParams> {
  final AuthRepository repository;

  UpdateUserProfile(this.repository);

  @override
  Future<Either<Failure, UserInfo>> call(UpdateProfileParams params) async {
    return await repository.updateUserProfile(params);
  }
}
