class User {
  // Personal information
  late int id;
  late String guid;
  late String firstName;
  late String lastName;
  late String profilePicture;
  late String email;
  late String username;
  late String password;
  late bool isRemembered;
  late bool isAuthenticated;

  // Company information
  late int companyID;
  late String companyGUID;
  late String companyName;
  late String companyEmail;
  late String companyLogo;
  late String companyPhone;
  late String companyFax;
  late String companyStreet;
  late String companyCity;
  late String companyState;
  late String companyZipCode;

  User({
    required this.id,
    required this.guid,
    required this.firstName,
    required this.lastName,
    required this.profilePicture,
    required this.username,
    required this.email,
    required this.password,
    required this.isRemembered,
    required this.isAuthenticated,
    required this.companyID,
    required this.companyGUID,
    required this.companyName,
    required this.companyEmail,
    required this.companyLogo,
    required this.companyPhone,
    required this.companyFax,
    required this.companyStreet,
    required this.companyCity,
    required this.companyState,
    required this.companyZipCode,
  });

  Map<String, dynamic> toMap() {
    return {
      'id': this.id,
      'guid': this.guid,
      'firstName': this.firstName,
      'lastName': this.lastName,
      'profilePicture': this.profilePicture,
      'username': this.username,
      'email': this.email,
      'password': this.password,
      'isRemembered': this.isRemembered,
      'isAuthenticated': this.isAuthenticated,
      'companyID': this.companyID,
      'companyGUID': this.companyGUID,
      'companyName': this.companyName,
      'companyEmail': this.companyEmail,
      'companyLogo': this.companyLogo,
      'companyPhone': this.companyPhone,
      'companyFax': this.companyFax,
      'companyStreet': this.companyStreet,
      'companyCity': this.companyCity,
      'companyState': this.companyState,
      'companyZipCode': this.companyZipCode,
    };
  }

  factory User.fromMap(Map<String, dynamic> map) {
    return User(
      id: map['id'] as int,
      guid: map['guid'] as String,
      firstName: map['firstName'] as String,
      lastName: map['lastName'] as String,
      profilePicture: map['profilePicture'] as String,
      username: map['username'] as String,
      email: map['email'] as String,
      password: map['password'] as String,
      isRemembered: map['isRemembered'] as bool,
      isAuthenticated: map['isAuthenticated'] as bool,
      companyID: map['companyID'] as int,
      companyGUID: map['companyGUID'] as String,
      companyName: map['companyName'] as String,
      companyEmail: map['companyEmail'] as String,
      companyLogo: map['companyLogo'] as String,
      companyPhone: map['companyPhone'] as String,
      companyFax: map['companyFax'] as String,
      companyStreet: map['companyStreet'] as String,
      companyCity: map['companyCity'] as String,
      companyState: map['companyState'] as String,
      companyZipCode: map['companyZipCode'] as String,
    );
  }
  factory User.fromJson(Map<String, dynamic> map) {
    return User(
      id: map['emp']['Id'] as int,
      guid: map['emp']['UserId'] as String,
      firstName: map['emp']['FirstName'] as String,
      lastName: map['emp']['LastName'] as String,
      profilePicture: map['emp']['ProfilePicture'] as String,
      username: map['emp']['UserName'] as String,
      email: map['emp']['Email'] as String,
      password: "",
      isRemembered: false,
      isAuthenticated: true,
      companyID: map['company']['Id'] as int,
      companyGUID: map['company']['CompanyId'] as String,
      companyName: map['company']['CompanyName'] as String,
      companyEmail: map['company']['EmailAdress'] as String,
      companyLogo: map['company']['CompanyLogo'] as String,
      companyPhone: map['company']['Phone'] as String,
      companyFax: map['company']['Fax'] as String,
      companyStreet: map['company']['Street'] as String,
      companyCity: map['company']['City'] as String,
      companyState: map['company']['State'] as String,
      companyZipCode: map['company']['ZipCode'] as String,
    );
  }
}
