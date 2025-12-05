import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:srt_app/features/auth/domain/usecases/get_user_info.dart';
import 'package:srt_app/features/auth/domain/usecases/update_user_profile.dart';
import 'package:srt_app/core/usecases/usecase.dart';
import 'user_info_event.dart';
import 'user_info_state.dart';

class UserInfoBloc extends Bloc<UserInfoEvent, UserInfoState> {
  final GetUserInfo getUserInfo;
  final UpdateUserProfile updateUserProfile;

  UserInfoBloc({
    required this.getUserInfo,
    required this.updateUserProfile,
  }) : super(UserInfoInitial()) {
    on<FetchUserInfo>(_onFetchUserInfo);
    on<UpdateUserProfileEvent>(_onUpdateUserProfile);
  }

  Future<void> _onFetchUserInfo(
    FetchUserInfo event,
    Emitter<UserInfoState> emit,
  ) async {
    emit(UserInfoLoading());

    final result = await getUserInfo(NoParams());

    result.fold(
      (failure) => emit(UserInfoError(failure)),
      (userInfo) => emit(UserInfoLoaded(userInfo)),
    );
  }

  Future<void> _onUpdateUserProfile(
    UpdateUserProfileEvent event,
    Emitter<UserInfoState> emit,
  ) async {
    emit(UserInfoLoading());

    final result = await updateUserProfile(event.params);

    result.fold(
      (failure) => emit(UserInfoError(failure)),
      (userInfo) => emit(UserInfoLoaded(userInfo)),
    );
  }
}
