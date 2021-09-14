part of 'change_default_company_cubit.dart';

@immutable
abstract class ChangeDefaultCompanyState {}

class ChangeDefaultCompanyInitial extends ChangeDefaultCompanyState {}

class ChangeDefaultCompanyError extends ChangeDefaultCompanyState {
  final String error;

  ChangeDefaultCompanyError({required this.error});
}

class ChangeDefaultCompanyNetworking extends ChangeDefaultCompanyState {}

class ChangeDefaultCompanySuccess extends ChangeDefaultCompanyState {
  final bool data;

  ChangeDefaultCompanySuccess({required this.data});
}
