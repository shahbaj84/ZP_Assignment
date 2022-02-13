class Country{
  String? code;
  String? name;
  String? nativeValue;
  String? phone;
  Continent? continent;
  String? currency;
  List<Languages>? languages;
  String? emoji;
  String? emojiU;

  Country({
    this.code,
    this.name,
    this.nativeValue,
    this.phone,
    this.continent,
    this.currency,
    this.languages,
    this.emoji,
    this.emojiU
    }
  );

  Country.fromJson(Map<String, dynamic> json) {
    code = json['code'];
    name = json['name'];
    nativeValue = json['native'];
    phone = json['phone'];
   continent = json['continent'] != null
        ? Continent.fromJson(json['continent'])
        : null;
    currency = json['currency'];
    if (json['languages'] != null) {
      languages = <Languages>[];
      json['languages'].forEach((v) {
        languages!.add(Languages.fromJson(v));
      });
    }
    emoji = json['emoji'];
    emojiU = json['emojiU'];
  }

  Map<String, dynamic> toJson() {
    Map<String, dynamic> data = <String, dynamic>{};
    data['code'] = code;
    data['name'] = name;
    data['native'] = nativeValue;
    data['phone'] = phone;
    if (continent != null) {
      data['continent'] = continent!.toJson();
    }
    data['currency'] = currency;
    if (languages != null) {
      data['languages'] = languages!.map((v) => v.toJson()).toList();
    }
    data['emoji'] = emoji;
    data['emojiU'] = emojiU;
    return data;
  }
}

class Continent {
  String? code;
  String? name;

  Continent({this.code, this.name});

  factory Continent.fromJson(Map<String, dynamic> json) {
    return Continent(
    code : json['code'],
    name : json['name']);
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['code'] = code;
    data['name'] = name;
    return data;
  }
}

class Languages {
  String? code;
  String? name;
  String? nativeValue;
  bool? rtl;

  Languages({this.code,this.name, this.nativeValue,this.rtl});

  factory Languages.fromJson(Map<String, dynamic> json) {
    return Languages(code : json['code'],
    name : json['name'],
    nativeValue : json['native'],
    rtl : json['rtl']);
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['code'] = code;
    data['name'] = name;
    data['native'] = nativeValue;
    data['rtl'] = rtl;
    return data;
  }
}