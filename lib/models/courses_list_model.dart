class CoursesListModel {
  CoursesListModel({
    required String status,
    required String code,
    required List<Data> data,
  }) {
    _status = status;
    _code = code;
    _data = data;
  }

  CoursesListModel.fromJson(dynamic json) {
    _status = json['status'];
    _code = json['code'];
    if (json['data'] != null) {
      _data = [];
      json['data'].forEach((v) {
        _data!.add(Data.fromJson(v));
      });
    }
  }

  String? _status;
  String? _code;
  List<Data>? _data;

  CoursesListModel copyWith({
    required String status,
    required String code,
    required List<Data> data,
  }) =>
      CoursesListModel(
        status: status ?? _status!,
        code: code ?? _code!,
        data: data ?? _data!,
      );

  String get status => _status!;

  String get code => _code!;

  List<Data> get data => _data!;

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
/// name : "6-sinf"
/// user : {"first_name":"","last_name":""}
/// subject : {"name":"Matematika"}
/// description : "Test matematika"
/// image : "/media/images/courses/ali.jpg"
/// price : 60
/// count_students : 0
/// created : "25-12-2024 20:12:44"

class Data {
  Data({
    required num id,
    required String name,
    required User user,
    required Subject subject,
    required String description,
    required String image,
    required num price,
    required num countStudents,
    required String created,
  }) {
    _id = id;
    _name = name;
    _user = user;
    _subject = subject;
    _description = description;
    _image = image;
    _price = price;
    _countStudents = countStudents;
    _created = created;
  }

  Data.fromJson(dynamic json) {
    _id = json['id'];
    _name = json['name'];
    _user = json['user'] != null ? User.fromJson(json['user']) : null;
    _subject =
        json['subject'] != null ? Subject.fromJson(json['subject']) : null;
    _description = json['description'];
    _image = json['image'];
    _price = json['price'];
    _countStudents = json['count_students'];
    _created = json['created'];
  }

  num? _id;
  String? _name;
  User? _user;
  Subject? _subject;
  String? _description;
  String? _image;
  num? _price;
  num? _countStudents;
  String? _created;

  Data copyWith({
    required num id,
    required String name,
    required User user,
    required Subject subject,
    required String description,
    required String image,
    required num price,
    required num countStudents,
    required String created,
  }) =>
      Data(
        id: id ?? _id!,
        name: name ?? _name!,
        user: user ?? _user!,
        subject: subject ?? _subject!,
        description: description ?? _description!,
        image: image ?? _image!,
        price: price ?? _price!,
        countStudents: countStudents ?? _countStudents!,
        created: created ?? _created!,
      );

  num get id => _id!;

  String get name => _name!;

  User get user => _user!;

  Subject get subject => _subject!;

  String get description => _description!;

  String get image => _image!;

  num get price => _price!;

  num get countStudents => _countStudents!;

  String get created => _created!;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['id'] = _id;
    map['name'] = _name;
    if (_user != null) {
      map['user'] = _user!.toJson();
    }
    if (_subject != null) {
      map['subject'] = _subject!.toJson();
    }
    map['description'] = _description;
    map['image'] = _image;
    map['price'] = _price;
    map['count_students'] = _countStudents;
    map['created'] = _created;
    return map;
  }
}

/// name : "Matematika"

class Subject {
  Subject({
    required String name,
  }) {
    _name = name;
  }

  Subject.fromJson(dynamic json) {
    _name = json['name'];
  }

  String? _name;

  Subject copyWith({
    required String name,
  }) =>
      Subject(
        name: name ?? _name!,
      );

  String get name => _name!;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['name'] = _name;
    return map;
  }
}

/// first_name : ""
/// last_name : ""

class User {
  User({
    required String firstName,
    required String lastName,
  }) {
    _firstName = firstName;
    _lastName = lastName;
  }

  User.fromJson(dynamic json) {
    _firstName = json['first_name'];
    _lastName = json['last_name'];
  }

  String? _firstName;
  String? _lastName;

  User copyWith({
    required String firstName,
    required String lastName,
  }) =>
      User(
        firstName: firstName ?? _firstName!,
        lastName: lastName ?? _lastName!,
      );

  String get firstName => _firstName!;

  String get lastName => _lastName!;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['first_name'] = _firstName;
    map['last_name'] = _lastName;
    return map;
  }
}
