import 'dart:convert';

import 'package:bloc/bloc.dart';
import 'package:gutterapp/data/model/company.dart';
import 'package:gutterapp/data/service/login_service.dart';
import 'package:meta/meta.dart';

part 'companies_state.dart';

class CompaniesCubit extends Cubit<CompaniesState> {
  late LoginService _service;

  CompaniesCubit() : super(CompaniesInitial()) {
    _service = LoginService();
  }

  void find(String token) {
    emit(CompaniesNetworking());
    _service.findCompanies(token).then((response) {
      if (response.success) {
        final Map<String, dynamic> result = json.decode(response.result!);
        List<Company> companies = [];
        final List<Map<String, dynamic>> companiesMap = List<Map<String, dynamic>>.from(result["orglist"]);
        companies = List.generate(companiesMap.length, (index) {
          return Company.fromMap(companiesMap[index]);
        });
        emit(CompaniesSuccess(data: companies));
      } else {
        emit(CompaniesError(error: response.error ?? "Companies fetch error"));
      }
    });
  }
}
