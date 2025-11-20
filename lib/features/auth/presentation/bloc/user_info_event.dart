import 'package:equatable/equatable.dart';

abstract class UserInfoEvent extends Equatable {
  const UserInfoEvent();

  @override
  List<Object> get props => [];
}

class FetchUserInfo extends UserInfoEvent {
  const FetchUserInfo();
}
