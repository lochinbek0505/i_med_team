class Course {
  num? id;
  String? name;

  Course({this.id, this.name});

  Course copyWith({num? id, String? name}) =>
      Course(id: id ?? this.id, name: name ?? this.name);

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map["id"] = id;
    map["name"] = name;
    return map;
  }

  Course.fromJson(dynamic json){
    id = json["id"];
    name = json["name"];
  }
}

class Module {
  num? id;
  String? name;

  Module({this.id, this.name});

  Module copyWith({num? id, String? name}) =>
      Module(id: id ?? this.id, name: name ?? this.name);

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map["id"] = id;
    map["name"] = name;
    return map;
  }

  Module.fromJson(dynamic json){
    id = json["id"];
    name = json["name"];
  }
}

class Lesson {
  num? id;
  String? name;

  Lesson({this.id, this.name});

  Lesson copyWith({num? id, String? name}) =>
      Lesson(id: id ?? this.id, name: name ?? this.name);

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map["id"] = id;
    map["name"] = name;
    return map;
  }

  Lesson.fromJson(dynamic json){
    id = json["id"];
    name = json["name"];
  }
}

class Rating {
  Course? course;
  Module? module;
  Lesson? lesson;
  num? score;
  num? percent;
  String? created;

  Rating(
      {this.course, this.module, this.lesson, this.score, this.percent, this.created});

  Rating copyWith(
      {Course? course, Module? module, Lesson? lesson, num? score, num? percent, String? created}) =>
      Rating(course: course ?? this.course,
          module: module ?? this.module,
          lesson: lesson ?? this.lesson,
          score: score ?? this.score,
          percent: percent ?? this.percent,
          created: created ?? this.created);

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    if (course != null) {
      map["course"] = course?.toJson();
    }
    if (module != null) {
      map["module"] = module?.toJson();
    }
    if (lesson != null) {
      map["lesson"] = lesson?.toJson();
    }
    map["score"] = score;
    map["percent"] = percent;
    map["created"] = created;
    return map;
  }

  Rating.fromJson(dynamic json){
    course = json["course"] != null ? Course.fromJson(json["course"]) : null;
    module = json["module"] != null ? Module.fromJson(json["module"]) : null;
    lesson = json["lesson"] != null ? Lesson.fromJson(json["lesson"]) : null;
    score = json["score"];
    percent = json["percent"];
    created = json["created"];
  }
}

class Data {
  String? phone;
  String? firstName;
  String? lastName;
  String? middleName;
  num? duration;
  String? city;
  String? town;
  String? image;
  List<Rating>? ratingList;

  Data(
      {this.phone, this.firstName, this.lastName, this.middleName, this.duration, this.city, this.town, this.image, this.ratingList});

  Data copyWith(
      {String? phone, String? firstName, String? lastName, String? middleName, num? duration, String? city, String? town, String? image, List<
          Rating>? ratingList}) =>
      Data(phone: phone ?? this.phone,
          firstName: firstName ?? this.firstName,
          lastName: lastName ?? this.lastName,
          middleName: middleName ?? this.middleName,
          duration: duration ?? this.duration,
          city: city ?? this.city,
          town: town ?? this.town,
          image: image ?? this.image,
          ratingList: ratingList ?? this.ratingList);

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map["phone"] = phone;
    map["first_name"] = firstName;
    map["last_name"] = lastName;
    map["middle_name"] = middleName;
    map["duration"] = duration;
    map["city"] = city;
    map["town"] = town;
    map["image"] = image;
    if (ratingList != null) {
      map["rating"] = ratingList?.map((v) => v.toJson()).toList();
    }
    return map;
  }

  Data.fromJson(dynamic json){
    phone = json["phone"];
    firstName = json["first_name"];
    lastName = json["last_name"];
    middleName = json["middle_name"];
    duration = json["duration"];
    city = json["city"];
    town = json["town"];
    image = json["image"];
    if (json["rating"] != null) {
      ratingList = [];
      json["rating"].forEach((v) {
        ratingList?.add(Rating.fromJson(v));
      });
    }
  }
}

class ProfileModel {
  String? status;
  String? code;
  Data? data;

  ProfileModel({this.status, this.code, this.data});

  ProfileModel copyWith({String? status, String? code, Data? data}) =>
      ProfileModel(status: status ?? this.status,
          code: code ?? this.code,
          data: data ?? this.data);

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map["status"] = status;
    map["code"] = code;
    if (data != null) {
      map["data"] = data?.toJson();
    }
    return map;
  }

  ProfileModel.fromJson(dynamic json){
    status = json["status"];
    code = json["code"];
    data = json["data"] != null ? Data.fromJson(json["data"]) : null;
  }
}