class LessonEntity {
  int? idLesson;
  String? keyLesson;
  String? nameLesson;
  List? data;

  LessonEntity({this.idLesson, this.keyLesson, this.nameLesson, this.data});

  factory LessonEntity.fromJson(Map<String, dynamic> json) {
    return LessonEntity(
      idLesson: json['idLesson'],
      keyLesson: json['keyLesson'],
      nameLesson: json['nameLesson'],
      data: json['data'] as List?,
    );
  }

  Map<String, dynamic> toJson() {
    Map<String, dynamic> json = {};
    json['idLesson'] = idLesson;
    json['keyLesson'] = keyLesson;
    json['nameLesson'] = nameLesson;
    json['data'] = data;
    return json;
  }
}
