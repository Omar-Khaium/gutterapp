part of 'customers_cubit.dart';

@immutable
abstract class CustomersState {}

class CustomersInitial extends CustomersState {}

class CustomersError extends CustomersState {
  final String error;

  CustomersError({required this.error});
}

class CustomersNetworking extends CustomersState {
  final List<Customer> data;
  final bool isFirstPage;

  CustomersNetworking({required this.data, this.isFirstPage = false});
}

class CustomersSuccess extends CustomersState {
  final List<Customer> data;

  CustomersSuccess({required this.data});
}
