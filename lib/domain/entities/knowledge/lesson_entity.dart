class LessonEntity {
  int? idLesson;
  String? keyLesson;
  String? nameLesson;

  LessonEntity(
      {this.idLesson, this.keyLesson, this.nameLesson});

  factory LessonEntity.fromJson(Map<String, dynamic> json) {
    return LessonEntity(
      idLesson: json['idLesson'],
      keyLesson: json['keyLesson'],
      nameLesson: json['nameLesson'],
    );
  }

  Map<String, dynamic> toJson(){
    Map<String,dynamic> json = {};
    json['idLesson'] = idLesson;
    json['keyLesson'] = keyLesson;
    json['nameLesson'] = nameLesson;
    return json;
  }
}
