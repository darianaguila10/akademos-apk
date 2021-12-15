import 'dart:convert';

import 'package:sqflite/sqflite.dart';

List<EducationalCenter> educationalCenterFromJson(String str) => List<EducationalCenter>.from(json.decode(str).map((x) => EducationalCenter.fromJson(x)));

String educationalCenterToJson(List<EducationalCenter> data) => json.encode(List<dynamic>.from(data.map((x) => x.toJson())));


class EducationalCenter {
  static final String TABLE_NAME = "educational_center";
  String? name;
  String? educationalCenterType;
  String? organism;
  int? phone;
  String? address;
  String? municipality;
  String? province;
  String? director;
  String? subdirector;
  String? secretary;

  EducationalCenter({
    this.name,
    this.educationalCenterType,
    this.organism,
    this.phone,
    this.address,
    this.municipality,
    this.province,
    this.director,
    this.subdirector,
    this.secretary,
  });

  factory EducationalCenter.fromMap(Map<dynamic, dynamic> map) {
    return EducationalCenter(
        name: map["name"],
        educationalCenterType: map["educational_center_type"],
        organism: map["organism"],
        phone: map["phone"],
        address: map["address"],
        municipality: map["municipality"],
        province: map["province"],
        director: map["director"].isEmpty ? '' : map["director"],
        subdirector: map["subdirector"].isEmpty ? '' : map["subdirector"],
        secretary: map["secretary"].isEmpty ? '' : map["secretary"]);
  }
  factory EducationalCenter.fromJson(Map<String, dynamic> json) =>
      EducationalCenter(
        name: json["name"],
        educationalCenterType: json["educational_center_type"],
        organism: json["organism"],
        phone: json["phone"],
        address: json["address"],
        municipality: json["municipality"],
        province: json["province"],
        director: json["director"].isEmpty ? '' : json["director"],
        subdirector: json["subdirector"].isEmpty ? '' : json["subdirector"],
        secretary: json["secretary"].isEmpty ? '' : json["secretary"],
      );

  createTable(Database db) async {
    await db.rawUpdate("CREATE TABLE $TABLE_NAME("
        "id integer primary key autoincrement,"
        "name varchar(30),"
        "educational_center_type varchar(30),"
        "organism varchar(30),"
        "phone varchar(30),"
        "address varchar(30),"
        "municipality varchar(30),"
        "province varchar(30),"
        "director varchar(30),"
        "subdirector varchar(30),"
        "secretary varchar(30));");
  }

  Map<String, dynamic> toJson() => {
        "name": name,
        "educational_center_type": educationalCenterType,
        "organism": organism,
        "phone": phone,
        "address": address,
        "municipality": municipality,
        "province": province,
        "director": director,
        "subdirector": subdirector,
        "secretary": secretary,
      };

  List<Map> toMap() => [
        {
          'Nombre': name,
          'Tipo de centro': educationalCenterType,
          'Organismo formador': organism,
          'Teléfonos': phone ?? 23,
          'Dirección postal': address,
          'Provinvia': province,
          'Municipio': municipality
        },
        {
          'Director(a)': director,
          'Subdirector(a)': subdirector,
          'Secretario(a) docente': secretary
        },
      ];

  Map<String, dynamic> toMapDB() => {
        "name": name,
        "educational_center_type": educationalCenterType,
        "organism": organism,
        "phone": phone,
        "address": address,
        "municipality": municipality,
        "province": province,
        "director": director,
        "subdirector": subdirector,
        "secretary": secretary,
      };
}
