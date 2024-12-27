class RegisterResponse{


  String? _status;
  String? _code;
  dynamic _data;

  RegisterResponse({
      required String status,
      required String code,
      required dynamic data,}){
    _status = status!;
    _code = code!;
    _data = data!;
}

  RegisterResponse.fromJson(dynamic json) {
    _status = json['status'];
    _code = json['code'];
    _data = json['data'];
  }
RegisterResponse copyWith({  String? status,
  String? code,
  dynamic data,
}) => RegisterResponse(  status: status ?? _status!,
  code: code ?? _code!,
  data: data ?? _data,
);
  String get status => _status!;
  String get code => _code!;
  dynamic get data => _data;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['status'] = _status;
    map['code'] = _code;
    map['data'] = _data;
    return map;
  }

  @override
  String toString() {
    return 'RegisterResponse{_status: $_status, _code: $_code, _data: $_data}';
  }
}