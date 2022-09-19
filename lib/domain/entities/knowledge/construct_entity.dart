class ConstructEntity {
  int? idConstruct;
  int? idLesson;
  String? linkConstruct;
  String? nameConstruct;

  ConstructEntity(
      {this.idConstruct, this.idLesson, this.linkConstruct, this.nameConstruct});

  factory ConstructEntity.fromJson(Map<String, dynamic> json) {
    return ConstructEntity(
      idConstruct: json['idConstruct'],
      idLesson: json['idLesson'],
      linkConstruct: json['linkConstruct'],
      nameConstruct: json['nameConstruct'],
    );
  }

  Map<String, dynamic> toJson(){
    Map<String,dynamic> json = {};
    json['idConstruct'] = idConstruct;
    json['idLesson'] = idLesson;
    json['linkConstruct'] = linkConstruct;
    json['nameConstruct'] = nameConstruct;
    return json;
  }
}
