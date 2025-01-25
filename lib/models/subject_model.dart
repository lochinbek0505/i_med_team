class Subject50 {
  num? id;
  String? name;
  String? image;
  num? courses;

  Subject50({this.id, this.name, this.image, this.courses});

  Subject50 copyWith({num? id, String? name, String? image, num? courses}) =>
      Subject50(id: id ?? this.id,
          name: name ?? this.name,
          image: image ?? this.image,
          courses: courses ?? this.courses);

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map["id"] = id;
    map["name"] = name;
    map["image"] = image;
    map["courses"] = courses;
    return map;
  }

  Subject50.fromJson(dynamic json){
    id = json["id"];
    name = json["name"];
    image = json["image"];
    courses = json["courses"];
  }
}

class SubjectModel {
  String? status;
  String? code;
  List<Subject50>? dataList;

  SubjectModel({this.status, this.code, this.dataList});

  SubjectModel copyWith({String? status, String? code, List<Subject50>? dataList}) =>
      SubjectModel(status: status ?? this.status,
          code: code ?? this.code,
          dataList: dataList ?? this.dataList);

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map["status"] = status;
    map["code"] = code;
    if (dataList != null) {
      map["data"] = dataList?.map((v) => v.toJson()).toList();
    }
    return map;
  }

  SubjectModel.fromJson(dynamic json){
    status = json["status"];
    code = json["code"];
    if (json["data"] != null) {
      dataList = [];
      json["data"].forEach((v) {
        dataList?.add(Subject50.fromJson(v));
      });
    }
  }
}