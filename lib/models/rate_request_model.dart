class RateRequestModel {
  num? course;
  String? type;

  RateRequestModel({this.course, this.type});

  RateRequestModel copyWith({num? course, String? type}) =>
      RateRequestModel(course: course ?? this.course, type: type ?? this.type);

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map["course"] = course;
    return map;
  }

  RateRequestModel.fromJson(dynamic json){
    course = json["course"];
    type = json["type"];
  }
}