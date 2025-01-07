class EndModel {
  num? course;
  num? modul;
  num? lesson;

  EndModel({this.course, this.modul, this.lesson});

  EndModel copyWith({num? course, num? modul, num? lesson}) =>
      EndModel(course: course ?? this.course,
          modul: modul ?? this.modul,
          lesson: lesson ?? this.lesson);

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map["course"] = course;
    map["modul"] = modul;
    map["lesson"] = lesson;
    return map;
  }

  EndModel.fromJson(dynamic json){
    course = json["course"];
    modul = json["modul"];
    lesson = json["lesson"];
  }
}