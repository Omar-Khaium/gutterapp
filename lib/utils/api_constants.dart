class ApiUrl {
  static final String base = "http://api.gutterapp.com/api/";
  static final String token = "http://api.gutterapp.com/";
  static final String zipLookup = "http://zipcodelookup.rmrcloud.com/1.0/GetCityZipCodeLookupList";
}

class ApiEndpoints {
  // Login
  static final String token = "token";
  static final String profile = "GetUserByUserName";
  static final String companies = "GetOrganizationList";
  static final String changeDefaultCompany = "ChangeDefaultCompany";
  //----------------------------------------------------------------

  static final String saveCustomer = "SaveCustomer";
  static final String equipmentsByKey = "GetEquipmentListByKey";
  static final String saveEstimate = "CreateEstimate";
  static final String uploadImage = "UploadImageFile";
  static final String estimateById = "GetEstimateById";
  static final String lookupByKey = "GetLookupbyKey";
  static final String inspectionByCustomerId = "GetCustomerInspectionByCustomerId";
  static final String saveInspection = "SaveCustomerInspection";
  static final String saveRecommendedLevel = "RecommendedLevel";
  static final String forgetPassword = "ForgetPassword";
  static final String changePassword = "ChangePassword";
  static final String customers = "GetAllCustomer";
  static final String deleteCustomer = "DeleteCustomer";
  static final String customerById = "GetCustomerByIdWithEstimateList";
  static final String uploadCustomerImage = "CustomerImageUpload";
  static final String duplicateEstimate = "EstimateDuplicate";
  static final String deleteEstimate = "DeleteEstimate";
  static final String generateEstimate = "GenerateEstimate";
  static final String sendEmail = "SendEmailEstimate";
  static final String search = "GlobalSearchCustomerAndLead";
}

class LookupKey {}
