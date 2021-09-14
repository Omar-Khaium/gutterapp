import 'dart:convert';

import 'package:bloc/bloc.dart';
import 'package:gutterapp/data/service/login_service.dart';
import 'package:meta/meta.dart';

part 'login_state.dart';

class LoginCubit extends Cubit<LoginState> {
  late LoginService _service;

  LoginCubit() : super(LoginInitial()) {
    _service = LoginService();
  }

  void login(String username, String password) {
    emit(LoginNetworking());
    _service.login(username, password).then((response) {
      if (response.success) {
        final Map<String, dynamic> result = json.decode(response.result!);
        String token = "${result["token_type"]} ${result["access_token"]}";
        int expiresIn = (result["expires_in"] * 1000) + DateTime.now().millisecondsSinceEpoch;
        emit(LoginSuccess(token: token, expiresIn: expiresIn));
      } else {
        emit(LoginError(error: response.error ?? "Login failed"));
      }
    });
  }
}
