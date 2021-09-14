class Customer {
  late int id;
  late String guid;
  late String title;
  late String type;
  late String customerType;
  late String firstName;
  late String lastName;
  late String businessName;
  late String primaryPhone;
  late String secondaryPhone;
  late String emailAddress;
  late String street;
  late String city;
  late String state;
  late String zip;

  Customer({
    required this.id,
    required this.guid,
    required this.title,
    required this.type,
    required this.customerType,
    required this.firstName,
    required this.lastName,
    required this.businessName,
    required this.primaryPhone,
    required this.secondaryPhone,
    required this.emailAddress,
    required this.street,
    required this.city,
    required this.state,
    required this.zip,
  });

  Customer.fromMap(Map<String, dynamic> map) {
    id = map['Id'] ?? -1;
    guid = map['CustomerId'] ?? "";
    title = map['Title'] ?? "";
    type = map['Type'] ?? "";
    customerType = map['CustomerType'] ?? "";
    firstName = map['FirstName'] ?? "";
    lastName = map['LastName'] ?? "";
    businessName = map['BusinessName'] ?? "";
    primaryPhone = map['PrimaryPhone'] ?? "";
    secondaryPhone = map['SecondaryPhone'] ?? "";
    emailAddress = map['EmailAddress'] ?? "";
    street = map['Street'] ?? "";
    city = map['City'] ?? "";
    state = map['State'] ?? "";
    zip = map['ZipCode'] ?? "";
  }
}
