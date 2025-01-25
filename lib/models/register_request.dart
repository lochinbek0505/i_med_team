class RegisterRequest {
  String? _phone;
  String? _firstName;
  String? _lastName;
  String? _middleName;
  String? _city;
  String? _town;
  String? _password;
  String? _professional;

  RegisterRequest({
    required String phone,
    required String firstName,
    required String lastName,
    required String middleName,
    required String city,
    required String town,
    required String password,
      required String professional}) {
    _phone = phone;
    _firstName = firstName;
    _lastName = lastName;
    _middleName = middleName;
    _city = city;
    _town = town;
    _password = password;
    _professional = password;
  }

  RegisterRequest.fromJson(dynamic json) {
    _phone = json['email'];
    _firstName = json['first_name'];
    _lastName = json['last_name'];
    _middleName = json['middle_name'];
    _city = json['city'];
    _town = json['town'];
    _password = json['password'];
    _professional = json['profession'];
  }

  RegisterRequest copyWith({
    required String phone,
    required String firstName,
    required String lastName,
    required String middleName,
    required String city,
    required String town,
    required String password,
    required String professional,
  }) =>
      RegisterRequest(
        phone: phone ?? _phone!,
        firstName: firstName ?? _firstName!,
        lastName: lastName ?? _lastName!,
        middleName: middleName ?? _middleName!,
        city: city ?? _city!,
        town: town ?? _town!,
        password: password ?? _password!,
        professional: professional ?? _professional!,
      );

  String get phone => _phone!;

  String get firstName => _firstName!;

  String get lastName => _lastName!;

  String get middleName => _middleName!;

  String get city => _city!;

  String get town => _town!;

  String get password => _password!;

  String get professional => _professional!;
  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['email'] = _phone;
    map['first_name'] = _firstName;
    map['last_name'] = _lastName;
    map['middle_name'] = _middleName;
    map['city'] = _city;
    map['town'] = _town;
    map['password'] = _password;
    map['profession'] = _professional;
    return map;
  }
}
