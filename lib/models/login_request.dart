class LoginRequest {
  LoginRequest({
    required String phone,
    required String password,
  }) {
    _phone = phone;
    _password = password;
  }

  LoginRequest.fromJson(dynamic json) {
    _phone = json['phone'];
    _password = json['password'];
  }

  String? _phone;
  String? _password;

  LoginRequest copyWith({
    required String phone,
    required String password,
  }) =>
      LoginRequest(
        phone: phone ?? _phone!,
        password: password ?? _password!,
      );

  String get phone => _phone!;

  String get password => _password!;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['phone'] = _phone;
    map['password'] = _password;
    return map;
  }
}
