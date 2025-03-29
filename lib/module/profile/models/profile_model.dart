class ProfileModel {
  String id;
  String username;
  String password;

  String pincode;
  String address;
  String city;
  String state;
  String country;

  String bankAccountNumber;
  String accountHolderName;
  String ifscCode;

  ProfileModel({
    required this.id,
    required this.username,
    required this.password,
    required this.pincode,
    required this.address,
    required this.city,
    required this.state,
    required this.country,
    required this.bankAccountNumber,
    required this.accountHolderName,
    required this.ifscCode,
  });
  ProfileModel.empty()
      : id = '',
        username = '',
        password = '',
        pincode = '',
        address = '',
        city = '',
        state = '',
        country = '',
        bankAccountNumber = '',
        accountHolderName = '',
        ifscCode = '';
}
