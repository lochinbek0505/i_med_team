class Data785 {
  String? name;
  String? phone;
  String? telegram;

  Data785({this.name, this.phone, this.telegram});

  Data785 copyWith({String? name, String? phone, String? telegram}) =>
      Data785(name: name ?? this.name,
          phone: phone ?? this.phone,
          telegram: telegram ?? this.telegram);

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map["name"] = name;
    map["phone"] = phone;
    map["telegram"] = telegram;
    return map;
  }

  Data785.fromJson(dynamic json){
    name = json["name"];
    phone = json["phone"];
    telegram = json["telegram"];
  }
}

class ContactModel {
  String? status;
  String? code;
  Data785? data;

  ContactModel({this.status, this.code, this.data});

  ContactModel copyWith({String? status, String? code, Data785? data}) =>
      ContactModel(status: status ?? this.status,
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

  ContactModel.fromJson(dynamic json){
    status = json["status"];
    code = json["code"];
    data = json["data"] != null ? Data785.fromJson(json["data"]) : null;
  }
}