part of 'companies_cubit.dart';

@immutable
abstract class CompaniesState {}

class CompaniesInitial extends CompaniesState {}

class CompaniesError extends CompaniesState {
  final String error;

  CompaniesError({required this.error});
}

class CompaniesNetworking extends CompaniesState {}

class CompaniesSuccess extends CompaniesState {
  final List<Company> data;

  CompaniesSuccess({required this.data});
}
