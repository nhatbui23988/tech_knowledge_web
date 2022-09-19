class OperatorEntity {
  int? idOperator;
  int? idLesson;
  String? linkOperator;
  String? nameOperator;

  OperatorEntity(
      {this.idOperator, this.idLesson, this.linkOperator, this.nameOperator});

  factory OperatorEntity.fromJson(Map<String, dynamic> json) {
    return OperatorEntity(
      idOperator: json['idOperator'],
      idLesson: json['idLesson'],
      linkOperator: json['linkOperator'],
      nameOperator: json['nameOperator'],
    );
  }

  Map<String, dynamic> toJson(){
    Map<String,dynamic> json = {};
    json['idOperator'] = idOperator;
    json['idLesson'] = idLesson;
    json['linkOperator'] = linkOperator;
    json['nameOperator'] = nameOperator;
    return json;
  }
}
