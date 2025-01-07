class EndEnd {
  EndEnd({
    required String status,
    dynamic errors,
    dynamic data,
  }) {
    _status = status;
    _errors = errors;
    _data = data;
  }

  EndEnd.fromJson(dynamic json) {
    _status = json['status'];
    _errors = json['errors'];
    _data = json['data'];
  }

  String? _status;
  dynamic _errors;
  dynamic _data;

  EndEnd copyWith({
    required String status,
    dynamic errors,
    dynamic data,
  }) =>
      EndEnd(
        status: status ?? _status!,
        errors: errors ?? _errors,
        data: data ?? _data,
      );

  String get status => _status!;

  dynamic get errors => _errors;

  dynamic get data => _data;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['status'] = _status;
    map['errors'] = _errors;
    map['data'] = _data;
    return map;
  }
}
