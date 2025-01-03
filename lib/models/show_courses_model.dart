class ShowCoursesModel {
  ShowCoursesModel({
      required String status,
    required String code,
    required Data data,}){
    _status = status;
    _code = code;
    _data = data;
}

  ShowCoursesModel.fromJson(dynamic json) {
    _status = json['status'];
    _code = json['code'];
    _data = json['data'] != null ? Data.fromJson(json['data']) : null;
  }
  String? _status;
  String? _code;
  Data? _data;
ShowCoursesModel copyWith({ required  String status,
  required String code,
  required  Data data,
}) => ShowCoursesModel(  status: status ?? _status!,
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

class Data {
  Data({
    required       num id,
    required String name,
    required    User user,
    required    Subject subject,
    required    String description,
    required    String image,
    required    num price,
    required    num percentage,
    required    num length,
    required    num countModules,
    required    num countLessons,
    required    num countStudents,
    required    num countQuizzes,
    required   List<Modules> modules,
    required   bool isOpen,
    required  String created,}){
    _id = id;
    _name = name;
    _user = user;
    _subject = subject;
    _description = description;
    _image = image;
    _price = price;
    _percentage = percentage;
    _length = length;
    _countModules = countModules;
    _countLessons = countLessons;
    _countStudents = countStudents;
    _countQuizzes = countQuizzes;
    _modules = modules;
    _isOpen = isOpen;
    _created = created;
}

  Data.fromJson(dynamic json) {
    _id = json['id'];
    _name = json['name'];
    _user = json['user'] != null ? User.fromJson(json['user']) : null;
    _subject = json['subject'] != null ? Subject.fromJson(json['subject']) : null;
    _description = json['description'];
    _image = json['image'];
    _price = json['price'];
    _percentage = json['percentage'];
    _length = json['length'];
    _countModules = json['count_modules'];
    _countLessons = json['count_lessons'];
    _countStudents = json['count_students'];
    _countQuizzes = json['count_quizzes'];
    if (json['modules'] != null) {
      _modules = [];
      json['modules'].forEach((v) {
        _modules!.add(Modules.fromJson(v));
      });
    }
    _isOpen = json['is_open'];
    _created = json['created'];
  }
  num? _id;
  String? _name;
  User? _user;
  Subject? _subject;
  String? _description;
  String? _image;
  num? _price;
  num? _percentage;
  num? _length;
  num? _countModules;
  num? _countLessons;
  num? _countStudents;
  num? _countQuizzes;
  List<Modules>? _modules;
  bool? _isOpen;
  String? _created;
Data copyWith({ required  num id,
  required  String name,
  required User user,
  required   Subject subject,
  required  String description,
  required  String image,
  required num price,
  required  num percentage,
  required  num length,
  required  num countModules,
  required  num countLessons,
  required  num countStudents,
  required  num countQuizzes,
  required  List<Modules> modules,
  required  bool isOpen,
  required  String created,
}) => Data(  id: id,
  name: name,
  user: user,
  subject: subject,
  description: description,
  image: image,
  price: price,
  percentage: percentage,
  length: length,
  countModules: countModules,
  countLessons: countLessons,
  countStudents: countStudents,
  countQuizzes: countQuizzes,
  modules: modules ,
  isOpen: isOpen ,
  created: created ,
);
  num get id => _id!;
  String get name => _name!;
  User get user => _user!;
  Subject get subject => _subject!;
  String get description => _description!;
  String get image => _image!;
  num get price => _price!;
  num get percentage => _percentage!;
  num get length => _length!;
  num get countModules => _countModules!;
  num get countLessons => _countLessons!;
  num get countStudents => _countStudents!;
  num get countQuizzes => _countQuizzes!;
  List<Modules> get modules => _modules!;
  bool get isOpen => _isOpen!;
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
    map['percentage'] = _percentage;
    map['length'] = _length;
    map['count_modules'] = _countModules;
    map['count_lessons'] = _countLessons;
    map['count_students'] = _countStudents;
    map['count_quizzes'] = _countQuizzes;
    if (_modules != null) {
      map['modules'] = _modules!.map((v) => v.toJson()).toList();
    }
    map['is_open'] = _isOpen;
    map['created'] = _created;
    return map;
  }

}

/// id : 1
/// name : "Kirish"
/// is_open : true
/// lessons : [{"id":1,"name":"Kirish","type":"quiz","duration":60,"is_open":true}]

class Modules {
  Modules({
    required  num id,
    required  String name,
    required   bool isOpen,
    required   List<Lessons> lessons,}){
    _id = id;
    _name = name;
    _isOpen = isOpen;
    _lessons = lessons;
}

  Modules.fromJson(dynamic json) {
    _id = json['id'];
    _name = json['name'];
    _isOpen = json['is_open'];
    if (json['lessons'] != null) {
      _lessons = [];
      json['lessons'].forEach((v) {
        _lessons!.add(Lessons.fromJson(v));
      });
    }
  }
  num? _id;
  String? _name;
  bool? _isOpen;
  List<Lessons>? _lessons;
Modules copyWith({required   num id,
  required  String name,
  required  bool isOpen,
  required List<Lessons> lessons,
}) => Modules(  id: id,
  name: name,
  isOpen: isOpen,
  lessons: lessons,
);
  num get id => _id!;
  String get name => _name!;
  bool get isOpen => _isOpen!;
  List<Lessons> get lessons => _lessons!;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['id'] = _id;
    map['name'] = _name;
    map['is_open'] = _isOpen;
    if (_lessons != null) {
      map['lessons'] = _lessons!.map((v) => v.toJson()).toList();
    }
    return map;
  }

}

/// id : 1
/// name : "Kirish"
/// type : "quiz"
/// duration : 60
/// is_open : true

class Lessons {
  Lessons({
    required  num id,
    required   String name,
    required   String type,
    required   num duration,
    required   bool isOpen,}){
    _id = id;
    _name = name;
    _type = type;
    _duration = duration;
    _isOpen = isOpen;
}

  Lessons.fromJson(dynamic json) {
    _id = json['id'];
    _name = json['name'];
    _type = json['type'];
    _duration = json['duration'];
    _isOpen = json['is_open'];
  }
  num? _id;
  String? _name;
  String? _type;
  num? _duration;
  bool? _isOpen;
Lessons copyWith({required   num id,
  required String name,
  required  String type,
  required num duration,
  required   bool isOpen,
}) => Lessons(  id: id,
  name: name,
  type: type,
  duration: duration,
  isOpen: isOpen,
);
  num get id => _id!;
  String get name => _name!;
  String get type => _type!;
  num get duration => _duration!;
  bool get isOpen => _isOpen!;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['id'] = _id;
    map['name'] = _name;
    map['type'] = _type;
    map['duration'] = _duration;
    map['is_open'] = _isOpen;
    return map;
  }

}

/// id : 1
/// name : "Sotsologiya"

class Subject {
  Subject({
    required num id,
    required  String name,}){
    _id = id;
    _name = name;
}

  Subject.fromJson(dynamic json) {
    _id = json['id'];
    _name = json['name'];
  }
  num? _id;
  String? _name;
Subject copyWith({required   num id,
  required String name,
}) => Subject(  id: id,
  name: name,
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

class User {
  User({
    required       String firstName,
    required  String lastName,
    required  dynamic image,}){
    _firstName = firstName;
    _lastName = lastName;
    _image = image;
}

  User.fromJson(dynamic json) {
    _firstName = json['first_name'];
    _lastName = json['last_name'];
    _image = json['image'];
  }
  String? _firstName;
  String? _lastName;
  dynamic? _image;
User copyWith({  required String firstName,
  required String lastName,
  required  dynamic image,
}) => User(  firstName: firstName,
  lastName: lastName,
  image: image ?? _image,
);
  String get firstName => _firstName!;
  String get lastName => _lastName!;
  dynamic get image => _image;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['first_name'] = _firstName;
    map['last_name'] = _lastName;
    map['image'] = _image;
    return map;
  }

}