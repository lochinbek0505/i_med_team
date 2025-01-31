class User {
  String? firstName;
  String? lastName;
  String? image;

  User({this.firstName, this.lastName, this.image});

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map["first_name"] = firstName;
    map["last_name"] = lastName;
    map["image"] = image;
    return map;
  }

  User.fromJson(dynamic json){
    firstName = json["first_name"];
    lastName = json["last_name"];
    image = json["image"];
  }
}

class Subject {
  num? id;
  String? name;
  String? image;
  num? courses;

  Subject({this.id, this.name, this.image, this.courses});

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map["id"] = id;
    map["name"] = name;
    map["image"] = image;
    map["courses"] = courses;
    return map;
  }

  Subject.fromJson(dynamic json){
    id = json["id"];
    name = json["name"];
    image = json["image"];
    courses = json["courses"];
  }
}

class Data {
  num? id;
  String? name;
  User? user;
  Subject? subject;
  String? description;
  String? image;
  num? price;
  num? percentage;
  num? length;
  num? countModules;
  num? countLessons;
  num? countStudents;
  bool? isOpen;
  String? rest;
  String? created;

  Data(
      {this.id, this.name, this.user, this.subject, this.description, this.image, this.price, this.percentage, this.length, this.countModules, this.countLessons, this.countStudents, this.isOpen, this.rest, this.created});

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map["id"] = id;
    map["name"] = name;
    if (user != null) {
      map["user"] = user?.toJson();
    }
    if (subject != null) {
      map["subject"] = subject?.toJson();
    }
    map["description"] = description;
    map["image"] = image;
    map["price"] = price;
    map["percentage"] = percentage;
    map["length"] = length;
    map["count_modules"] = countModules;
    map["count_lessons"] = countLessons;
    map["count_students"] = countStudents;
    map["is_open"] = isOpen;
    map["rest"] = rest;
    map["created"] = created;
    return map;
  }

  Data.fromJson(dynamic json){
    id = json["id"];
    name = json["name"];
    user = json["user"] != null ? User.fromJson(json["user"]) : null;
    subject =
    json["subject"] != null ? Subject.fromJson(json["subject"]) : null;
    description = json["description"];
    image = json["image"];
    price = json["price"];
    percentage = json["percentage"];
    length = json["length"];
    countModules = json["count_modules"];
    countLessons = json["count_lessons"];
    countStudents = json["count_students"];
    isOpen = json["is_open"];
    rest = json["rest"];
    created = json["created"];
  }
}

class MyCoursesModel {
  String? status;
  String? code;
  List<Data>? dataList;

  MyCoursesModel({this.status, this.code, this.dataList});

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map["status"] = status;
    map["code"] = code;
    if (dataList != null) {
      map["data"] = dataList?.map((v) => v.toJson()).toList();
    }
    return map;
  }

  MyCoursesModel.fromJson(dynamic json){
    status = json["status"];
    code = json["code"];
    if (json["data"] != null) {
      dataList = [];
      json["data"].forEach((v) {
        dataList?.add(Data.fromJson(v));
      });
    }
  }
}