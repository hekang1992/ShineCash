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
  UserInfoModel? userInfo;
  List<CenturiesModel>? centuries;

  ExpectModel({
    this.satisfactory,
    this.natural,
    this.emerging,
    this.fair,
    this.userInfo,
    this.centuries,
  });

  factory ExpectModel.fromJson(Map<String, dynamic> json) {
    return ExpectModel(
      satisfactory: json['satisfactory'],
      natural: json['natural'],
      emerging: json['emerging'],
      fair: FairModel.fromJson(json['fair'] ?? {}),
      userInfo: UserInfoModel.fromJson(json['userInfo'] ?? {}),
      centuries:
          (json['centuries'] as List?)
              ?.map((item) => CenturiesModel.fromJson(item ?? {}))
              .toList() ??
          [],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'satisfactory': satisfactory,
      'natural': natural,
      'emerging': emerging,
      'fair': fair?.toJson(),
      'userInfo': userInfo?.toJson(),
      'centuries': centuries?.map((model) => model.toJson()).toList(),
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

class UserInfoModel {
  String? userphone;
  UserInfoModel({this.userphone});

  factory UserInfoModel.fromJson(Map<String, dynamic> json) {
    return UserInfoModel(userphone: json['userphone']);
  }

  Map<String, dynamic> toJson() {
    return {'userphone': userphone};
  }
}

class CenturiesModel {
  String? acquainted;
  String? cautiously;
  String? finished;
  String? many;
  List<DiedModel>? died;
  CenturiesModel({
    this.acquainted,
    this.cautiously,
    this.finished,
    this.many,
    this.died,
  });

  factory CenturiesModel.fromJson(Map<String, dynamic> json) {
    return CenturiesModel(
      acquainted: json['acquainted'],
      cautiously: json['cautiously'],
      finished: json['finished'],
      many: json['many'],
      died:
          (json['died'] as List?)
              ?.map((item) => DiedModel.fromJson(item ?? {}))
              .toList() ??
          [],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'acquainted': acquainted,
      'cautiously': cautiously,
      'finished': finished,
      'many': many,
      'died': died?.map((model) => model.toJson()).toList(),
    };
  }
}

class DiedModel {
  String? alienated;
  String? appeal;
  String? correspondent;
  String? condition;
  int? hasten;
  String? imaginary;
  String? love;
  String? reduced;
  String? seminary;
  String? threeDes;

  DiedModel({
    this.alienated,
    this.appeal,
    this.correspondent,
    this.condition,
    this.hasten,
    this.imaginary,
    this.love,
    this.reduced,
    this.seminary,
    this.threeDes,
  });

  factory DiedModel.fromJson(Map<String, dynamic> json) {
    return DiedModel(
      alienated: json['alienated'],
      appeal: json['appeal'],
      correspondent: json['correspondent'],
      condition: json['condition'],
      hasten: json['hasten'],
      imaginary: json['imaginary'],
      love: json['love'],
      reduced: json['reduced'],
      seminary: json['seminary'],
      threeDes: json['threeDes'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'alienated': alienated,
      'appeal': appeal,
      'correspondent': correspondent,
      'condition': condition,
      'hasten': hasten,
      'imaginary': imaginary,
      'love': love,
      'reduced': reduced,
      'seminary': seminary,
      'threeDes': threeDes,
    };
  }
}
