import 'package:dartz/dartz.dart';
import '../../../../core/usecases/usecase.dart';
import '../../../../core/errors/failures.dart';
import '../entities/user_info.dart';
import '../repositories/auth_repository.dart';

class GetUserInfo implements UseCase<Either<Failure, UserInfo>, NoParams> {
  final AuthRepository repository;

  GetUserInfo(this.repository);

  @override
  Future<Either<Failure, UserInfo>> call(NoParams params) async {
    return await repository.getUserInfo();
  }
}
