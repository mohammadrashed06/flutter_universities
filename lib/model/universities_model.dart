import 'dart:convert';

//I can parse json data with Model classes. We will pass the json string to json.decode() method then from the model class we will parse it.
List<UniversitiesModel> universitiesFromJson(String str) => List<UniversitiesModel>.from(json.decode(str).map((x) => UniversitiesModel.fromJson(x)));

String universitiesToJson(List<UniversitiesModel> data) => json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class UniversitiesModel {
/*
{
  "country": "Jordan",
  "name": "Arab Academy for Banking and Financial Sciences",
  "domains": [
    "aabfs.org"
  ],
  "alpha_two_code": "JO",
  "state-province": null,
  "web_pages": [
    "http://www.aabfs.org/"
  ]
}
*/


  String? country;
  String? name;
  List<String?>? domains;
  String? alphaTwoCode;
  String? stateProvince;
  List<String?>? webPages;
  String? error;

  UniversitiesModel({
    this.country,
    this.name,
    this.domains,
    this.alphaTwoCode,
    this.stateProvince,
    this.webPages,
    this.error
  });
  UniversitiesModel.withError(String errorMessage) {
    error = errorMessage;
  }
  UniversitiesModel.fromJson(Map<String, dynamic> json) {
    country = json['country']?.toString();
    name = json['name']?.toString();
    if (json['domains'] != null) {
      final v = json['domains'];
      final arr0 = <String>[];
      v.forEach((v) {
        arr0.add(v.toString());
      });
      domains = arr0;
    }
    alphaTwoCode = json['alpha_two_code']?.toString();
    stateProvince = json['state-province']?.toString();
    if (json['web_pages'] != null) {
      final v = json['web_pages'];
      final arr0 = <String>[];
      v.forEach((v) {
        arr0.add(v.toString());
      });
      webPages = arr0;
    }
  }
  Map<String, dynamic> toJson() {
    final data = <String, dynamic>{};
    data['country'] = country;
    data['name'] = name;
    if (domains != null) {
      final v = domains;
      final arr0 = [];
      v!.forEach((v) {
        arr0.add(v);
      });
      data['domains'] = arr0;
    }
    data['alpha_two_code'] = alphaTwoCode;
    data['state-province'] = stateProvince;
    if (webPages != null) {
      final v = webPages;
      final arr0 = [];
      v!.forEach((v) {
        arr0.add(v);
      });
      data['web_pages'] = arr0;
    }
    return data;
  }
}