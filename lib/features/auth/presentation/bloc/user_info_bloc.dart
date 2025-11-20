import 'package:flutter_bloc/flutter_bloc.dart';
import '../../domain/usecases/get_user_info.dart';
import '../../../../core/usecases/usecase.dart';
import 'user_info_event.dart';
import 'user_info_state.dart';

class UserInfoBloc extends Bloc<UserInfoEvent, UserInfoState> {
  final GetUserInfo getUserInfo;

  UserInfoBloc({required this.getUserInfo}) : super(UserInfoInitial()) {
    on<FetchUserInfo>(_onFetchUserInfo);
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
}
