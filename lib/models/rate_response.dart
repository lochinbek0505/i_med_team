class User {
  String? firstName;
  String? lastName;
  String? middleName;
  String? city;
  String? town;
  dynamic image;

  User(
      {this.firstName,
      this.lastName,
      this.middleName,
      this.city,
      this.town,
      this.image});

  User copyWith(
          {String? firstName,
          String? lastName,
          String? middleName,
          String? city,
          String? town,
          dynamic image}) =>
      User(
          firstName: firstName ?? this.firstName,
          lastName: lastName ?? this.lastName,
          middleName: middleName ?? this.middleName,
          city: city ?? this.city,
          town: town ?? this.town,
          image: image ?? this.image);

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map["first_name"] = firstName;
    map["last_name"] = lastName;
    map["middle_name"] = middleName;
    map["city"] = city;
    map["town"] = town;
    map["image"] = image;
    return map;
  }

  User.fromJson(dynamic json) {
    firstName = json["first_name"];
    lastName = json["last_name"];
    middleName = json["middle_name"];
    city = json["city"];
    town = json["town"];
    image = json["image"];
  }
}

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

  Course.fromJson(dynamic json) {
    id = json["id"];
    name = json["name"];
  }
}

class Ratings {
  User? user;
  Course? course;
  num? score;

  Ratings({this.user, this.course, this.score});

  Ratings copyWith({User? user, Course? course, num? score}) => Ratings(
      user: user ?? this.user,
      course: course ?? this.course,
      score: score ?? this.score);

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    if (user != null) {
      map["user"] = user?.toJson();
    }
    if (course != null) {
      map["course"] = course?.toJson();
    }
    map["score"] = score;
    return map;
  }

  Ratings.fromJson(dynamic json) {
    user = json["user"] != null ? User.fromJson(json["user"]) : null;
    course = json["course"] != null ? Course.fromJson(json["course"]) : null;
    score = json["score"];
  }
}

class Data {
  List<Ratings>? ratingsList;

  Data({this.ratingsList});

  Data copyWith({List<Ratings>? ratingsList}) =>
      Data(ratingsList: ratingsList ?? this.ratingsList);

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    if (ratingsList != null) {
      map["ratings"] = ratingsList?.map((v) => v.toJson()).toList();
    }
    return map;
  }

  Data.fromJson(dynamic json) {
    if (json["ratings"] != null) {
      ratingsList = [];
      json["ratings"].forEach((v) {
        ratingsList?.add(Ratings.fromJson(v));
      });
    }
  }
}

class RateResponse {
  String? status;
  var errors;
  Data? data;

  RateResponse({this.status, this.errors, this.data});

  RateResponse copyWith({String? status, dynamic errors, Data? data}) =>
      RateResponse(
          status: status ?? this.status,
          errors: errors ?? this.errors,
          data: data ?? this.data);

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map["status"] = status;
    if (errors != null) {
      map["errors"] = errors?.toJson();
    }
    if (data != null) {
      map["data"] = data?.toJson();
    }
    return map;
  }

  RateResponse.fromJson(dynamic json) {
    status = json["status"];
    errors = json["errors"] != null ? json["errors"] : null;
    data = json["data"] != null ? Data.fromJson(json["data"]) : null;
  }
}
