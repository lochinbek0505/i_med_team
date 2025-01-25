class VerfyModel {
  String? email;
  num? code;

  VerfyModel({this.email, this.code});

  VerfyModel copyWith({String? email, num? code}) =>
      VerfyModel(email: email ?? this.email, code: code ?? this.code);

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map["email"] = email;
    map["code"] = code;
    return map;
  }

  VerfyModel.fromJson(dynamic json){
    email = json["email"];
    code = json["code"];
  }
}