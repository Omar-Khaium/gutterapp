import 'dart:convert';

import 'package:bloc/bloc.dart';
import 'package:gutterapp/data/model/user.dart';
import 'package:gutterapp/data/service/login_service.dart';
import 'package:meta/meta.dart';

part 'profile_state.dart';

class ProfileCubit extends Cubit<ProfileState> {
  late LoginService _service;

  ProfileCubit() : super(ProfileInitial()) {
    _service = LoginService();
  }

  void profile(String token, String username) {
    emit(ProfileNetworking());
    _service.profile(token, username).then((response) {
      if (response.success) {
        final Map<String, dynamic> result = json.decode(response.result!);
        final User user = User.fromJson(result);
        emit(ProfileSuccess(data: user));
      } else {
        emit(ProfileError(error: response.error ?? "Profile fetch error"));
      }
    });
  }
}
