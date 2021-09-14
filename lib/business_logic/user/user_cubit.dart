import 'package:bloc/bloc.dart';
import 'package:hydrated_bloc/hydrated_bloc.dart';

import '../../data/model/user.dart';

part 'user_state.dart';

class UserCubit extends Cubit<UserState> with HydratedMixin {
  UserCubit() : super(UserState());

  @override
  UserState? fromJson(Map<String, dynamic> map) {
    return UserState.fromMap(map);
  }

  @override
  Map<String, dynamic>? toJson(UserState state) {
    return state.toMap();
  }

  void saveLoginInformation(String token, int expiresIn) {
    emit(UserState(token: token, expiresIn: expiresIn, user: state.user));
  }

  void saveProfileInformation(User user) {
    emit(UserState(token: state.token, expiresIn: state.expiresIn, user: user));
  }

  void logout() {
    final User user = state.user!;
    user.isAuthenticated = false;
    emit(UserState(token: state.token, expiresIn: state.expiresIn, user: user));
  }
}
