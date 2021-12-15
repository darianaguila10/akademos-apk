import 'dart:convert';

import 'package:sqflite/sqflite.dart';

Student studentFromJson(String str) => Student.fromJson(json.decode(str));

String studentToJson(Student data) => json.encode(data.toJson());

class Student {
  static final String TABLE_NAME = "student";
  String? names;
  String? fullName;
  String? lastNames;
  String? gender;
  String? ci;
  String? address;

  Student({
    this.names,
    this.fullName,
    this.lastNames,
    this.gender,
    this.ci,
    this.address,
  });

  factory Student.fromMap(Map<dynamic, dynamic> map) {
    return Student(
     
      names: map["names"],
      fullName: map["full_name"],
      lastNames: map["last_names"],
      gender: map["gender"],
      ci: map['ci'],
      address: map['address'],
    );
  }

  factory Student.fromJson(Map<String, dynamic> json) => Student(
        names: json["names"],
        fullName: json["full_name"],
        lastNames: json["last_names"],
        gender: json["gender"],
        ci: json["ci"],
        
        address: json["address"],
      );

  
  createTable(Database db) async {
    await db.rawUpdate(
        "CREATE TABLE ${TABLE_NAME}(id integer primary key autoincrement, names varchar(30),full_name varchar(30),last_names varchar(30) ,gender varchar(30),ci varchar(30),address varchar(30))");
  }

 

  Map<String, dynamic> toJson() => {
        "names": names,
        "full_name": fullName,
        "last_names": lastNames,
        "gender": gender,
        "ci": ci,
        "address": address,
      };

  Map<String, dynamic> toMap() => {
        "Nombre(s)": names,
        "Apellidos": lastNames,
        "Sexo": gender,
        /* "Teléfonos": gender, */
        "Carné de identidad": ci,
        "Dirección": address,
      };

  Map<String, dynamic> toMapDB() => {
        "names": names,
        "full_name": fullName,
        "last_names": lastNames,
        "gender": gender,
        "ci": ci,
        "address": address,
      };
}
