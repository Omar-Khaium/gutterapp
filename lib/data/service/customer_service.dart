import 'package:gutterapp/utils/api_constants.dart';
import 'package:gutterapp/utils/network_response.dart';
import 'package:http/http.dart';

class CustomerService {
  Future<NetworkResponse<String?>> getCustomers(String token, int pageNo) async {
    Map<String, String> headerParams = {"Authorization": token, "PageNo": "$pageNo", "PageSize": "20", "ResultType": "Customer"};

    Response response = await get(Uri.parse("${ApiUrl.base}${ApiEndpoints.customers}"), headers: headerParams);

    if (response.statusCode == 200) {
      return NetworkResponse(result: response.body, success: true);
    } else {
      return NetworkResponse(result: null, success: false, error: response.reasonPhrase);
    }
  }
}
