class Answers {
  String? value1;
  String? value2;
  bool? isCorrect;

  Answers({this.value1, this.value2, this.isCorrect});

  Answers copyWith({String? value1, String? value2, bool? isCorrect}) =>
      Answers(
          value1: value1 ?? this.value1,
          value2: value2 ?? this.value2,
          isCorrect: isCorrect ?? this.isCorrect);

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map["value_1"] = value1;
    map["value_2"] = value2;
    map["is_correct"] = isCorrect;
    return map;
  }

  Answers.fromJson(dynamic json) {
    value1 = json["value_1"];
    value2 = json["value_2"];
    isCorrect = json["is_correct"];
  }
}

class Questions {
  String? question;
  String? type;
  List<Answers>? answersList;

  Questions({this.question, this.type, this.answersList});

  Questions copyWith(
          {String? question, String? type, List<Answers>? answersList}) =>
      Questions(
          question: question ?? this.question,
          type: type ?? this.type,
          answersList: answersList ?? this.answersList);

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map["question"] = question;
    map["type"] = type;
    if (answersList != null) {
      map["answers"] = answersList?.map((v) => v.toJson()).toList();
    }
    return map;
  }

  Questions.fromJson(dynamic json) {
    question = json["question"];
    type = json["type"];
    if (json["answers"] != null) {
      answersList = [];
      json["answers"].forEach((v) {
        answersList?.add(Answers.fromJson(v));
      });
    }
  }
}

class Quiz {
  num? id;
  String? name;
  List<Questions>? questionsList;

  Quiz({this.id, this.name, this.questionsList});

  Quiz copyWith({num? id, String? name, List<Questions>? questionsList}) =>
      Quiz(
          id: id ?? this.id,
          name: name ?? this.name,
          questionsList: questionsList ?? this.questionsList);

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map["id"] = id;
    map["name"] = name;
    if (questionsList != null) {
      map["questions"] = questionsList?.map((v) => v.toJson()).toList();
    }
    return map;
  }

  Quiz.fromJson(dynamic json) {
    id = json["id"];
    name = json["name"];
    if (json["questions"] != null) {
      questionsList = [];
      json["questions"].forEach((v) {
        questionsList?.add(Questions.fromJson(v));
      });
    }
  }
}

class Previous {
  num? id;
  String? name;
  String? type;
  num? duration;
  bool? isOpen;

  Previous({this.id, this.name, this.type, this.duration, this.isOpen});

  Previous copyWith(
          {num? id, String? name, String? type, num? duration, bool? isOpen}) =>
      Previous(
          id: id ?? this.id,
          name: name ?? this.name,
          type: type ?? this.type,
          duration: duration ?? this.duration,
          isOpen: isOpen ?? this.isOpen);

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map["id"] = id;
    map["name"] = name;
    map["type"] = type;
    map["duration"] = duration;
    map["is_open"] = isOpen;
    return map;
  }

  Previous.fromJson(dynamic json) {
    id = json["id"];
    name = json["name"];
    type = json["type"];
    duration = json["duration"];
    isOpen = json["is_open"];
  }
}

class Data {
  num? id;
  String? name;
  String? type;
  dynamic video;
  num? duration;
  dynamic resource;
  Quiz? quiz;
  Previous? previous;
  dynamic next;
  bool? isOpen;
  String? created;

  Data(
      {this.id,
      this.name,
      this.type,
      this.video,
      this.duration,
      this.resource,
      this.quiz,
      this.previous,
      this.next,
      this.isOpen,
      this.created});

  Data copyWith(
          {num? id,
          String? name,
          String? type,
          dynamic video,
          num? duration,
          dynamic resource,
          Quiz? quiz,
          Previous? previous,
          dynamic next,
          bool? isOpen,
          String? created}) =>
      Data(
          id: id ?? this.id,
          name: name ?? this.name,
          type: type ?? this.type,
          video: video ?? this.video,
          duration: duration ?? this.duration,
          resource: resource ?? this.resource,
          quiz: quiz ?? this.quiz,
          previous: previous ?? this.previous,
          next: next ?? this.next,
          isOpen: isOpen ?? this.isOpen,
          created: created ?? this.created);

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map["id"] = id;
    map["name"] = name;
    map["type"] = type;
    map["video"] = video;
    map["duration"] = duration;
    map["resource"] = resource;
    if (quiz != null) {
      map["quiz"] = quiz?.toJson();
    }
    if (previous != null) {
      map["previous"] = previous?.toJson();
    }
    map["next"] = next;
    map["is_open"] = isOpen;
    map["created"] = created;
    return map;
  }

  Data.fromJson(dynamic json) {
    id = json["id"];
    name = json["name"];
    type = json["type"];
    video = json["video"];
    duration = json["duration"];
    resource = json["resource"];
    quiz = json["quiz"] != null ? Quiz.fromJson(json["quiz"]) : null;
    previous =
        json["previous"] != null ? Previous.fromJson(json["previous"]) : null;
    next = json["next"];
    isOpen = json["is_open"];
    created = json["created"];
  }
}

class QuizModel {
  String? status;
  String? code;
  Data? data;

  QuizModel({this.status, this.code, this.data});

  QuizModel copyWith({String? status, String? code, Data? data}) => QuizModel(
      status: status ?? this.status,
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

  QuizModel.fromJson(dynamic json) {
    status = json["status"];
    code = json["code"];
    data = json["data"] != null ? Data.fromJson(json["data"]) : null;
  }
}
