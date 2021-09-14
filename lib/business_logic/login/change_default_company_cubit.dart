import 'dart:convert';

import 'package:bloc/bloc.dart';
import 'package:gutterapp/data/service/login_service.dart';
import 'package:meta/meta.dart';

part 'change_default_company_state.dart';

class ChangeDefaultCompanyCubit extends Cubit<ChangeDefaultCompanyState> {
  late LoginService _service;

  ChangeDefaultCompanyCubit() : super(ChangeDefaultCompanyInitial()) {
    _service = LoginService();
  }

  void change(String token, String guid) {
    emit(ChangeDefaultCompanyNetworking());
    _service.changeDefaultCompanies(token, guid).then((response) {
      if (response.success) {
        final Map<String, dynamic> result = json.decode(response.result!);
        if (result["result"] as bool) {
          emit(ChangeDefaultCompanySuccess(data: true));
        } else {
          emit(ChangeDefaultCompanyError(error: response.error ?? "Default company changing failed"));
        }
      } else {
        emit(ChangeDefaultCompanyError(error: response.error ?? "Default company changing failed"));
      }
    });
  }
}
