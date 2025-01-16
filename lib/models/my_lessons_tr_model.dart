import 'package:i_med_team/models/show_courses_model.dart';

class MyLessonsTrModel{

    Lessons5? lesson;
    int? id;
    bool? isOpened;

    @override
  String toString() {
    return 'MyLessonsTrModel{lesson: $lesson, id: $id, isOpened: $isOpened}';
  }

  MyLessonsTrModel(this.lesson, this.id, this.isOpened);

}