class ExerciseEntity {
  int? idExercise;
  int? idLesson;
  String? linkExercise;
  String? nameExercise;

  ExerciseEntity(
      {this.idExercise, this.idLesson, this.linkExercise, this.nameExercise});

  factory ExerciseEntity.fromJson(Map<String, dynamic> json) {
    return ExerciseEntity(
      idExercise: json['idExercise'],
      idLesson: json['idLesson'],
      linkExercise: json['linkExercise'],
      nameExercise: json['nameExercise'],
    );
  }

  Map<String, dynamic> toJson(){
    Map<String,dynamic> json = {};
    json['idExercise'] = idExercise;
    json['idLesson'] = idLesson;
    json['linkExercise'] = linkExercise;
    json['nameExercise'] = nameExercise;
    return json;
  }
}
