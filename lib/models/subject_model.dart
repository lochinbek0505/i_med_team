class SubjectModel {
  SubjectModel({
    required String status,
    required String code,
    required List<Subject> data,
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
        _data!.add(Subject.fromJson(v));
      });
    }
  }

  String? _status;
  String? _code;
  List<Subject>? _data;

  SubjectModel copyWith({
    required String status,
    required String code,
    required List<Subject> data,
  }) =>
      SubjectModel(
        status: status ?? _status!,
        code: code ?? _code!,
        data: data ?? _data!,
      );

  String get status => _status!;

  String get code => _code!;

  List<Subject> get data => _data!;

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

class Subject {
  Subject({
    required num id,
    required String name,
  }) {
    _id = id;
    _name = name;
  }

  Subject.fromJson(dynamic json) {
    _id = json['id'];
    _name = json['name'];
  }

  num? _id;
  String? _name;

  Subject copyWith({
    required num id,
    required String name,
  }) =>
      Subject(
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
