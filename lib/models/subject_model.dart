class SubjectModel {
  SubjectModel({
    required String status,
    required String code,
    required List<Subject50> data,
  }) {
    _status = status;
    _code = code;
    _data = data;
  }

  SubjectModel.fromJson(dynamic json) {
    _status = json['status'];
    _code = json['code'];
    if (json['data'] != null) {
      _data = [];
      json['data'].forEach((v) {
        _data!.add(Subject50.fromJson(v));
      });
    }
  }

  String? _status;
  String? _code;
  List<Subject50>? _data;

  SubjectModel copyWith({
    required String status,
    required String code,
    required List<Subject50> data,
  }) =>
      SubjectModel(
        status: status ?? _status!,
        code: code ?? _code!,
        data: data ?? _data!,
      );

  String get status => _status!;

  String get code => _code!;

  List<Subject50> get data => _data!;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['status'] = _status;
    map['code'] = _code;
    if (_data != null) {
      map['data'] = _data!.map((v) => v.toJson()).toList();
    }
    return map;
  }
}

/// id : 1
/// name : "Sotsologiya"

class Subject50 {
  Subject50({
    required num id,
    required String name,
  }) {
    _id = id;
    _name = name;
  }

  Subject50.fromJson(dynamic json) {
    _id = json['id'];
    _name = json['name'];
  }

  num? _id;
  String? _name;

  Subject50 copyWith({
    required num id,
    required String name,
  }) =>
      Subject50(
        id: id ?? _id!,
        name: name ?? _name!,
      );

  num get id => _id!;

  String get name => _name!;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['id'] = _id;
    map['name'] = _name;
    return map;
  }
}
