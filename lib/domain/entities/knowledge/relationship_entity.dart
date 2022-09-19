class RelationshipEntity {
  int? idRelationship;
  int? idLessonA;
  int? idLessonB;

  RelationshipEntity(
      {this.idRelationship, this.idLessonA , this.idLessonB });

  factory RelationshipEntity.fromJson(Map<String, dynamic> json) {
    return RelationshipEntity(
      idRelationship: json['idRelationship'],
      idLessonA: json['idLessonA'],
      idLessonB: json['idLessonB'],
    );
  }

  Map<String, dynamic> toJson(){
    Map<String,dynamic> json = {};
    json['idRelationship'] = idRelationship;
    json['idLessonA'] = idLessonA;
    json['idLessonB'] = idLessonB;
    return json;
  }
}
