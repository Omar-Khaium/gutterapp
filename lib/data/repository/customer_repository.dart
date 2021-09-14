import 'package:gutterapp/data/service/customer_service.dart';
import 'package:gutterapp/utils/network_response.dart';

class CustomerRepository {
  late CustomerService _service;

  CustomerRepository() {
    _service = CustomerService();
  }

  Future<NetworkResponse<String?>> getCustomers(String token, int pageNo) async {
    return await _service.getCustomers(token, pageNo);
  }
}
