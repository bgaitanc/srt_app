import 'package:equatable/equatable.dart';
import '../../domain/entities/user_info.dart';
import '../../../../core/errors/failures.dart';

abstract class UserInfoState extends Equatable {
  const UserInfoState();

  @override
  List<Object> get props => [];
}

class UserInfoInitial extends UserInfoState {}

class UserInfoLoading extends UserInfoState {}

class UserInfoLoaded extends UserInfoState {
  final UserInfo userInfo;

  const UserInfoLoaded(this.userInfo);

  @override
  List<Object> get props => [userInfo];
}

class UserInfoError extends UserInfoState {
  final Failure failure;

  const UserInfoError(this.failure);

  @override
  List<Object> get props => [failure];
}
