import 'package:equatable/equatable.dart';
import '../../../auth/domain/usecases/update_profile_params.dart';

abstract class UserInfoEvent extends Equatable {
  const UserInfoEvent();

  @override
  List<Object> get props => [];
}

class FetchUserInfo extends UserInfoEvent {
  const FetchUserInfo();
}

class UpdateUserProfileEvent extends UserInfoEvent {
  final UpdateProfileParams params;

  const UpdateUserProfileEvent(this.params);

  @override
  List<Object> get props => [params];
}
