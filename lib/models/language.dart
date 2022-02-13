class Languages {
  String? code;
  String? name;
  String? nativeValue;
  bool? rtl;

  Languages({this.code, this.name, this.nativeValue, this.rtl});

  Languages.fromJson(Map<String, dynamic> json) {
    code = json['code'];
    name = json['name'];
    nativeValue = json['native'];
    rtl = json['rtl'];
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