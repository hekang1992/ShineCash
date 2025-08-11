class BaseModel {
  String? beautiful;
  String? captive;
  ExpectModel? expect;

  BaseModel({this.beautiful, this.captive, this.expect});

  factory BaseModel.fromJson(Map<String, dynamic> json) {
    return BaseModel(
      beautiful: json['beautiful'],
      captive: json['captive'],
      expect: ExpectModel.fromJson(json['expect'] ?? {}),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'beautiful': beautiful,
      'captive': captive,
      'expect': expect?.toJson(),
    };
  }
}

class ExpectModel {
  String? satisfactory;
  String? natural;
  String? emerging;
  FairModel? fair;

  ExpectModel({this.satisfactory, this.natural, this.emerging, this.fair});

  factory ExpectModel.fromJson(Map<String, dynamic> json) {
    return ExpectModel(
      satisfactory: json['satisfactory'],
      natural: json['natural'],
      emerging: json['emerging'],
      fair: FairModel.fromJson(json['fair'] ?? {}),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'satisfactory': satisfactory,
      'natural': natural,
      'emerging': emerging,
      'fair': fair?.toJson(),
    };
  }
}

class FairModel {
  String? answers;
  String? crumpled;
  String? dirty;
  String? taking;

  FairModel({this.answers, this.crumpled, this.dirty, this.taking});
  factory FairModel.fromJson(Map<String, dynamic> json) {
    return FairModel(
      answers: json['answers'],
      crumpled: json['crumpled'],
      dirty: json['dirty'],
      taking: json['taking'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'answers': answers,
      'crumpled': crumpled,
      'dirty': dirty,
      'taking': taking,
    };
  }
}
