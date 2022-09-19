class ConceptEntity {
  int? idConcept;
  int? idLesson;
  String? linkConcept;
  String? nameConcept;

  ConceptEntity(
      {this.idConcept, this.idLesson, this.linkConcept, this.nameConcept});

  factory ConceptEntity.fromJson(Map<String, dynamic> json) {
    return ConceptEntity(
      idConcept: json['idConcept'],
      idLesson: json['idLesson'],
      linkConcept: json['linkConcept'],
      nameConcept: json['nameConcept'],
    );
  }

  Map<String, dynamic> toJson(){
    Map<String,dynamic> json = {};
    json['idConcept'] = idConcept;
    json['idLesson'] = idLesson;
    json['linkConcept'] = linkConcept;
    json['nameConcept'] = nameConcept;
    return json;
  }
}
