import 'dart:convert';

import 'package:bloc/bloc.dart';
import 'package:gutterapp/data/model/customer.dart';
import 'package:gutterapp/data/repository/customer_repository.dart';
import 'package:meta/meta.dart';

part 'customers_state.dart';

class CustomersCubit extends Cubit<CustomersState> {
  late CustomerRepository _repo;

  int pageNo = 1;
  int totalSize = -1;
  List<Customer> customers = [];

  CustomersCubit() : super(CustomersInitial()) {
    _repo = CustomerRepository();
  }

  void refresh(String token) {
    pageNo = 1;
    customers = [];
    emit(CustomersNetworking(data: customers, isFirstPage: true));
    _repo.getCustomers(token, pageNo).then((response) {
      if (response.success) {
        final Map<String, dynamic> result = json.decode(response.result!);

        totalSize = result['data']['TotalCustomerCount']['Counter'];
        final List<Map<String, dynamic>> customersMap = List<Map<String, dynamic>>.from(result['data']['CustomerList']);

        List<Customer> customerList = [];
        customerList = List.generate(customersMap.length, (index) {
          return Customer.fromMap(customersMap[index]);
        });

        customers.addAll(customerList);

        emit(CustomersSuccess(data: customers));
      } else {
        emit(CustomersError(error: response.error ?? "Customers fetch error"));
      }
    });
  }

  void paginate(String token) {
    if (customers.length == totalSize) return;
    pageNo += 1;
    emit(CustomersNetworking(data: customers));
    _repo.getCustomers(token, pageNo).then((response) {
      if (response.success) {
        final Map<String, dynamic> result = json.decode(response.result!);

        totalSize = result['data']['TotalCustomerCount']['Counter'];
        final List<Map<String, dynamic>> customersMap = List<Map<String, dynamic>>.from(result['data']['CustomerList']);

        List<Customer> customerList = [];
        customerList = List.generate(customersMap.length, (index) {
          return Customer.fromMap(customersMap[index]);
        });

        customers.addAll(customerList);

        emit(CustomersSuccess(data: customers));
      } else {
        emit(CustomersError(error: response.error ?? "Customers fetch error"));
      }
    });
  }
}
