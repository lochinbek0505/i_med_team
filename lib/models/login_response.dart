class LoginResponse {
  LoginResponse({
    required String status,
    required String code,
    required Data data,
  }) {
    _status = status;
    _code = code;
    _data = data;
  }

  LoginResponse.fromJson(dynamic json) {
    _status = json['status'];
    _code = json['code'];
    _data = json['data'] != null ? Data.fromJson(json['data']) : null;
  }

  String? _status;
  String? _code;
  Data? _data;

  LoginResponse copyWith({
    required String status,
    required String code,
    required Data data,
  }) =>
      LoginResponse(
        status: status ?? _status!,
        code: code ?? _code!,
        data: data ?? _data!,
      );

  String get status => _status!;

  String get code => _code!;

  Data get data => _data!;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['status'] = _status;
    map['code'] = _code;
    if (_data != null) {
      map['data'] = _data!.toJson();
    }
    return map;
  }
}

/// token : "64f196d2c536e80a190c959ce7016916f12412d7"

class Data {
  Data({
    required String token,
  }) {
    _token = token;
  }

  Data.fromJson(dynamic json) {
    _token = json['token'];
  }

  String? _token;

  Data copyWith({
    required String token,
  }) =>
      Data(
        token: token ?? _token!,
      );

  String get token => _token!;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['token'] = _token;
    return map;
  }
}
