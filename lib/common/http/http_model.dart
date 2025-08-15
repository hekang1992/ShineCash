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
  String? cautiously;
  FairModel? fair;
  UserInfoModel? userInfo;
  List<CenturiesModel>? centuries;
  AllowModel? allow;
  PostedModel? posted;
  PostedModel? rule;
  EgyptianModel? egyptian;

  List<SorryModel>? sorry;

  ExpectModel({
    this.satisfactory,
    this.natural,
    this.emerging,
    this.cautiously,
    this.fair,
    this.userInfo,
    this.centuries,
    this.allow,
    this.posted,
    this.rule,
    this.egyptian,
    this.sorry,
  });

  factory ExpectModel.fromJson(Map<String, dynamic> json) {
    return ExpectModel(
      satisfactory: json['satisfactory'],
      natural: json['natural'],
      emerging: json['emerging'],
      cautiously: json['cautiously'],
      fair: FairModel.fromJson(json['fair'] ?? {}),
      userInfo: UserInfoModel.fromJson(json['userInfo'] ?? {}),
      centuries:
          (json['centuries'] as List?)
              ?.map((item) => CenturiesModel.fromJson(item ?? {}))
              .toList() ??
          [],
      allow: AllowModel.fromJson(json['allow'] ?? {}),
      posted: PostedModel.fromJson(json['posted'] ?? {}),
      rule: PostedModel.fromJson(json['rule'] ?? {}),
      egyptian: EgyptianModel.fromJson(json['egyptian'] ?? {}),
      sorry:
          (json['sorry'] as List?)
              ?.map((item) => SorryModel.fromJson(item ?? {}))
              .toList() ??
          [],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'satisfactory': satisfactory,
      'natural': natural,
      'emerging': emerging,
      'cautiously': cautiously,
      'fair': fair?.toJson(),
      'userInfo': userInfo?.toJson(),
      'centuries': centuries?.map((model) => model.toJson()).toList(),
      'allow': allow?.toJson(),
      'posted': posted?.toJson(),
      'rule': rule?.toJson(),
      'egyptian': egyptian?.toJson(),
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

class AllowModel {
  String? sitting;

  AllowModel({this.sitting});

  factory AllowModel.fromJson(Map<String, dynamic> json) {
    return AllowModel(sitting: json['sitting']);
  }

  Map<String, dynamic> toJson() {
    return {'sitting': sitting};
  }
}

class PostedModel {
  int? listening;
  String? cautiously;
  String? read;

  PostedModel({this.listening, this.cautiously, this.read});

  factory PostedModel.fromJson(Map<String, dynamic> json) {
    return PostedModel(
      listening: json['listening'],
      cautiously: json['cautiously'],
      read: json['read'],
    );
  }

  Map<String, dynamic> toJson() {
    return {'listening': listening, 'cautiously': cautiously, 'read': read};
  }
}

class EgyptianModel {
  String? glanced;
  String? humor;
  String? imaginary;
  int? wink;
  String? symbol;
  Considering? considering;

  EgyptianModel({
    this.glanced,
    this.humor,
    this.imaginary,
    this.wink,
    this.symbol,
    this.considering,
  });

  factory EgyptianModel.fromJson(Map<String, dynamic> json) {
    return EgyptianModel(
      glanced: json['glanced'],
      humor: json['humor'],
      imaginary: json['imaginary'],
      wink: json['wink'],
      symbol: json['symbol'],
      considering: Considering.fromJson(json['considering'] ?? {}),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'glanced': glanced,
      'humor': humor,
      'imaginary': imaginary,
      'wink': wink,
      'symbol': symbol,
      'considering': considering?.toJson(),
    };
  }
}

class Considering {
  LudicrousModel? ludicrous;
  LudicrousModel? mistress;

  Considering({this.ludicrous, this.mistress});

  factory Considering.fromJson(Map<String, dynamic> json) {
    return Considering(
      ludicrous: LudicrousModel.fromJson(json['ludicrous'] ?? {}),
      mistress: LudicrousModel.fromJson(json['mistress'] ?? {}),
    );
  }

  Map<String, dynamic> toJson() {
    return {'ludicrous': ludicrous?.toJson(), 'mistress': mistress?.toJson()};
  }
}

class LudicrousModel {
  String? acquainted;
  String? robes;

  LudicrousModel({this.acquainted, this.robes});

  factory LudicrousModel.fromJson(Map<String, dynamic> json) {
    return LudicrousModel(acquainted: json['acquainted'], robes: json['robes']);
  }

  Map<String, dynamic> toJson() {
    return {'acquainted': acquainted, 'robes': robes};
  }
}

class SorryModel {
  String? acquainted;
  String? gentlemen;
  int? listening; //0 1 是否完成
  String? sitting;
  String? unread;

  SorryModel({
    this.acquainted,
    this.gentlemen,
    this.listening,
    this.sitting,
    this.unread,
  });

  factory SorryModel.fromJson(Map<String, dynamic> json) {
    return SorryModel(
      acquainted: json['acquainted'],
      gentlemen: json['gentlemen'],
      listening: json['listening'],
      sitting: json['sitting'],
      unread: json['unread'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'acquainted': acquainted,
      'gentlemen': gentlemen,
      'listening': listening,
      'sitting': sitting,
      'unread': unread,
    };
  }
}
