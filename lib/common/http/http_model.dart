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
  int? driving;
  String? kiss;
  String? waive;

  // 新增的属性
  List<String>? address;
  List<String>? communicate;

  List<FavorModel>? favor;

  List<TemporaryModel>? temporary;

  List<OilyModel>? oily;

  AfterModel? after;

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
    this.address,
    this.communicate,
    this.favor,
    this.temporary,
    this.oily,
    this.driving,
    this.kiss,
    this.after,
    this.waive,
  });

  factory ExpectModel.fromJson(Map<String, dynamic> json) {
    return ExpectModel(
      satisfactory: json['satisfactory'],
      natural: json['natural'],
      emerging: json['emerging'],
      cautiously: json['cautiously'],
      driving: json['driving'],
      kiss: json['kiss'],
      waive: json['waive'],
      fair: FairModel.fromJson(json['fair'] ?? {}),
      after: AfterModel.fromJson(json['after'] ?? {}),
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
      // 新增属性的 JSON 解析
      address: (json['address'] as List?)
          ?.map((item) => item as String)
          .toList(),
      communicate: (json['communicate'] as List?)
          ?.map((item) => item as String)
          .toList(),
      favor:
          (json['favor'] as List?)
              ?.map((item) => FavorModel.fromJson(item ?? {}))
              .toList() ??
          [],
      temporary:
          (json['temporary'] as List?)
              ?.map((item) => TemporaryModel.fromJson(item ?? {}))
              .toList() ??
          [],
      oily:
          (json['oily'] as List?)
              ?.map((item) => OilyModel.fromJson(item ?? {}))
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
      'after': after?.toJson(),
      'userInfo': userInfo?.toJson(),
      'centuries': centuries?.map((model) => model.toJson()).toList(),
      'allow': allow?.toJson(),
      'posted': posted?.toJson(),
      'rule': rule?.toJson(),
      'egyptian': egyptian?.toJson(),
      'sorry': sorry?.map((model) => model.toJson()).toList(),
      // 新增属性的 JSON 序列化
      'address': address,
      'communicate': communicate,
      'driving': driving,
      'kiss': kiss,
      'waive': waive,
      'favor': favor?.map((model) => model.toJson()).toList(),
      'temporary': temporary?.map((model) => model.toJson()).toList(),
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
  String? cautiously; //url
  String? finished;
  String? many;
  List<DiedModel>? died;
  String? pens;
  List<CenturiesModel>? centuries;
  String? imaginary;
  String? correspondent;
  String? appeal;
  String? perceived;
  List<ContainedModel>? contained;
  String? ends;
  String? throne;
  CenturiesModel({
    this.acquainted,
    this.cautiously,
    this.finished,
    this.many,
    this.died,
    this.pens,
    this.centuries,
    this.imaginary,
    this.correspondent,
    this.appeal,
    this.perceived,
    this.contained,
    this.ends,
    this.throne,
  });

  factory CenturiesModel.fromJson(Map<String, dynamic> json) {
    return CenturiesModel(
      acquainted: json['acquainted'],
      cautiously: json['cautiously'],
      finished: json['finished'],
      many: json['many'],
      imaginary: json['imaginary'],
      correspondent: json['correspondent'],
      appeal: json['appeal'],
      perceived: json['perceived'],
      ends: json['ends'],
      throne: json['throne'],
      died:
          (json['died'] as List?)
              ?.map((item) => DiedModel.fromJson(item ?? {}))
              .toList() ??
          [],
      pens: json['pens'],
      centuries:
          (json['centuries'] as List?)
              ?.map((item) => CenturiesModel.fromJson(item ?? {}))
              .toList() ??
          [],
      contained:
          (json['contained'] as List?)
              ?.map((item) => ContainedModel.fromJson(item ?? {}))
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
      'pens': pens,
      'correspondent': correspondent,
      'imaginary': imaginary,
      'appeal': appeal,
      'perceived': perceived,
      'ends': ends,
      'throne': throne,
      'died': died?.map((model) => model.toJson()).toList(),
      'centuries': centuries?.map((model) => model.toJson()).toList(),
      'contained': contained?.map((model) => model.toJson()).toList(),
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
  String? throne;
  String? cautiously;
  String? disappointment;

  List<String>? teacher;

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
    this.throne,
    this.cautiously,
    this.disappointment,
    this.teacher,
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
      throne: json['throne'],
      cautiously: json['cautiously'],
      disappointment: json['disappointment'],
      teacher: (json['teacher'] as List?)
          ?.map((item) => item as String)
          .toList(),
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
      'throne': throne,
      'cautiously': cautiously,
      'disappointment': disappointment,
      'teacher': teacher,
    };
  }
}

class AllowModel {
  String? sitting;
  String? cautiously;

  AllowModel({this.sitting, this.cautiously});

  factory AllowModel.fromJson(Map<String, dynamic> json) {
    return AllowModel(sitting: json['sitting'], cautiously: json['cautiously']);
  }

  Map<String, dynamic> toJson() {
    return {'sitting': sitting, 'cautiously': cautiously};
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
  String? styled;
  String? having;
  int? proud;
  String? correspondent;

  EgyptianModel({
    this.glanced,
    this.humor,
    this.imaginary,
    this.wink,
    this.symbol,
    this.considering,
    this.styled,
    this.having,
    this.proud,
    this.correspondent,
  });

  factory EgyptianModel.fromJson(Map<String, dynamic> json) {
    return EgyptianModel(
      glanced: json['glanced'],
      humor: json['humor'],
      imaginary: json['imaginary'],
      wink: json['wink'],
      symbol: json['symbol'],
      styled: json['styled'],
      having: json['having'],
      proud: json['proud'],
      correspondent: json['correspondent'],
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
      'styled': styled,
      'having': having,
      'proud': proud,
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
  String? cautiously;

  SorryModel({
    this.acquainted,
    this.gentlemen,
    this.listening,
    this.sitting,
    this.unread,
    this.cautiously,
  });

  factory SorryModel.fromJson(Map<String, dynamic> json) {
    return SorryModel(
      acquainted: json['acquainted'],
      gentlemen: json['gentlemen'],
      listening: json['listening'],
      sitting: json['sitting'],
      unread: json['unread'],
      cautiously: json['cautiously'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'acquainted': acquainted,
      'gentlemen': gentlemen,
      'listening': listening,
      'sitting': sitting,
      'unread': unread,
      'cautiously': cautiously,
    };
  }
}

class FavorModel {
  String? beautiful;
  String? even;
  String? remain;

  FavorModel({this.beautiful, this.even, this.remain});

  factory FavorModel.fromJson(Map<String, dynamic> json) {
    return FavorModel(
      beautiful: json['beautiful'],
      even: json['even'],
      remain: json['remain'],
    );
  }

  Map<String, dynamic> toJson() {
    return {'beautiful': beautiful, 'even': even, 'remain': remain};
  }
}

class TemporaryModel {
  String? acquainted;
  String? beautiful; //key
  String? conversation;
  int? regrets; //keybordtype 1num 0default
  String? angrily;
  String? necessity;
  List<SincerelyModel>? sincerely;
  int? selectIndex;
  String? selectStr;

  TemporaryModel({
    this.acquainted,
    this.beautiful,
    this.conversation,
    this.regrets,
    this.angrily,
    this.necessity,
    this.sincerely,
    this.selectIndex,
    this.selectStr,
  });

  factory TemporaryModel.fromJson(Map<String, dynamic> json) {
    return TemporaryModel(
      acquainted: json['acquainted'],
      beautiful: json['beautiful'],
      conversation: json['conversation'],
      regrets: json['regrets'],
      angrily: json['angrily'],
      necessity: json['necessity'],
      selectStr: json['selectStr'],
      sincerely: (json['sincerely'] as List?)
          ?.map((item) => SincerelyModel.fromJson(item ?? {}))
          .toList(),
      selectIndex: json['selectIndex'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'acquainted': acquainted,
      'beautiful': beautiful,
      'conversation': conversation,
      'regrets': regrets,
      'angrily': angrily,
      'necessity': necessity,
      'sincerely': sincerely?.map((model) => model.toJson()).toList(),
      'selectIndex': selectIndex,
      'selectStr': selectStr,
    };
  }
}

class SincerelyModel {
  String? pens;
  int? many;

  SincerelyModel({this.pens, this.many});

  factory SincerelyModel.fromJson(Map<String, dynamic> json) {
    return SincerelyModel(pens: json['pens'], many: json['many']);
  }

  Map<String, dynamic> toJson() {
    return {'pens': pens, 'many': many};
  }
}

class OilyModel {
  String? acquainted;
  String? discovery;
  String? diseases;
  String? mental;
  String? pens;
  String? perceive;
  String? sane;
  String? skilled;
  String? relationStr;
  List<Sincerely1Model>? sincerely;

  int? selectIndex;

  OilyModel({
    this.acquainted,
    this.discovery, //关系
    this.diseases,
    this.mental,
    this.pens, //名字
    this.perceive,
    this.sane, //电话
    this.skilled,
    this.sincerely,
    this.selectIndex,
    this.relationStr,
  });

  factory OilyModel.fromJson(Map<String, dynamic> json) {
    return OilyModel(
      acquainted: json['acquainted'],
      discovery: json['discovery'],
      diseases: json['diseases'],
      mental: json['mental'],
      pens: json['pens'],
      perceive: json['perceive'],
      sane: json['sane'],
      skilled: json['skilled'],
      selectIndex: json['selectIndex'],
      relationStr: json['relationStr'],
      sincerely:
          (json['sincerely'] as List?)
              ?.map((item) => Sincerely1Model.fromJson(item ?? {}))
              .toList() ??
          [],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'acquainted': acquainted,
      'discovery': discovery,
      'diseases': diseases,
      'mental': mental,
      'pens': pens,
      'perceive': perceive,
      'sane': sane,
      'skilled': skilled,
      'selectIndex': selectIndex,
      'relationStr': relationStr,
      'sincerely': sincerely?.map((model) => model.toJson()).toList(),
    };
  }
}

class Sincerely1Model {
  String? many;
  String? pens;

  Sincerely1Model({this.many, this.pens});

  factory Sincerely1Model.fromJson(Map<String, dynamic> json) {
    return Sincerely1Model(many: json['many'], pens: json['pens']);
  }

  Map<String, dynamic> toJson() {
    return {'many': many, 'pens': pens};
  }
}

class ContainedModel {
  String? acquainted;
  String? significant;

  ContainedModel({this.acquainted, this.significant});

  factory ContainedModel.fromJson(Map<String, dynamic> json) {
    return ContainedModel(
      acquainted: json['acquainted'],
      significant: json['significant'],
    );
  }

  Map<String, dynamic> toJson() {
    return {'acquainted': acquainted, 'significant': significant};
  }
}

class AfterModel {
  String? acquainted;
  String? waive;

  AfterModel({this.acquainted, this.waive});

  factory AfterModel.fromJson(Map<String, dynamic> json) {
    return AfterModel(acquainted: json['acquainted'], waive: json['waive']);
  }

  Map<String, dynamic> toJson() {
    return {'acquainted': acquainted, 'waive': waive};
  }
}
