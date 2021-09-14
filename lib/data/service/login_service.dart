import 'package:gutterapp/utils/api_constants.dart';
import 'package:gutterapp/utils/network_response.dart';
import 'package:http/http.dart';

class LoginService {
  Future<NetworkResponse<String?>> login(String username, String password) async {
    Map<String, String> bodyParams = {
      "username": username,
      "password": password,
      "grant_type": "password",
    };

    Response response = await post(Uri.parse("${ApiUrl.token}${ApiEndpoints.token}"), body: bodyParams);

    if (response.statusCode == 200) {
      return NetworkResponse(result: response.body, success: true);
    } else {
      return NetworkResponse(result: null, success: false, error: response.reasonPhrase);
    }
  }

  Future<NetworkResponse<String?>> profile(String token, String username) async {
    Map<String, String> headerParams = {
      "Authorization": token,
      "username": username,
    };

    Response response = await get(Uri.parse("${ApiUrl.base}${ApiEndpoints.profile}"), headers: headerParams);

    if (response.statusCode == 200) {
      return NetworkResponse(result: response.body, success: true);
    } else {
      return NetworkResponse(result: null, success: false, error: response.reasonPhrase);
    }
  }

  Future<NetworkResponse<String?>> findCompanies(String token) async {
    Map<String, String> headerParams = {
      "Authorization": token,
    };

    Response response = await get(Uri.parse("${ApiUrl.base}${ApiEndpoints.companies}"), headers: headerParams);

    if (response.statusCode == 200) {
      return NetworkResponse(result: response.body, success: true);
    } else {
      return NetworkResponse(result: null, success: false, error: response.reasonPhrase);
    }
  }

  Future<NetworkResponse<String?>> changeDefaultCompanies(String token, String guid) async {
    Map<String, String> headerParams = {
      "Authorization": token,
      "CompanyId": guid,
    };

    Response response = await post(Uri.parse("${ApiUrl.base}${ApiEndpoints.changeDefaultCompany}"), headers: headerParams);

    if (response.statusCode == 200) {
      return NetworkResponse(result: response.body, success: true);
    } else {
      return NetworkResponse(result: null, success: false, error: response.reasonPhrase);
    }
  }
}
