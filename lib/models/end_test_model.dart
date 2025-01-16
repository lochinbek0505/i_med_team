class EndTestModel {
  num? course;
  num? module;
  num? lesson;
  num? percent;
  num? score;

  EndTestModel(
      {this.course, this.module, this.lesson, this.percent, this.score});

  EndTestModel copyWith(
      {num? course, num? module, num? lesson, num? percent, num? score}) =>
      EndTestModel(course: course ?? this.course,
          module: module ?? this.module,
          lesson: lesson ?? this.lesson,
          percent: percent ?? this.percent,
          score: score ?? this.score);

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map["course"] = course;
    map["module"] = module;
    map["lesson"] = lesson;
    map["percent"] = percent;
    map["score"] = score;
    return map;
  }

  EndTestModel.fromJson(dynamic json){
    course = json["course"];
    module = json["module"];
    lesson = json["lesson"];
    percent = json["percent"];
    score = json["score"];
  }

  @override
  String toString() {
    return 'EndTestModel{course: $course, module: $module, lesson: $lesson, percent: $percent, score: $score}';
  }
}