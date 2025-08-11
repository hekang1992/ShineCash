class BaseModel {
  String? beautiful;
  String? captive;
  ExpectModel? expect;

  BaseModel({
    required this.beautiful,
    required this.captive,
    required this.expect,
  });

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

  ExpectModel({
    required this.satisfactory,
    required this.natural,
    required this.emerging,
  });

  factory ExpectModel.fromJson(Map<String, dynamic> json) {
    return ExpectModel(
      satisfactory: json['satisfactory'],
      natural: json['natural'],
      emerging: json['emerging'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'satisfactory': satisfactory,
      'natural': natural,
      'emerging': emerging,
    };
  }
}
