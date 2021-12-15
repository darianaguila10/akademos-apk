import 'dart:convert';

import 'package:sqflite/sqflite.dart';

List<Professor> professorFromJson(String str) =>
    List<Professor>.from(json.decode(str).map((x) => Professor.fromJson(x)));

String professorToJson(List<Professor> data) =>
    json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class Professor {
   static final String TABLE_NAME = "professor";
  String? professor;
  String? subject;
  String? speciality;
 
  Professor({
    this.professor,
    this.subject,
    this.speciality,
  });

  factory Professor.fromJson(Map<String, dynamic> json) => Professor(
        professor: json["professor"],
        subject: json["subject"],
        speciality: json["speciality"],
      );

  factory Professor.fromMap(Map<dynamic, dynamic> map) {
    return Professor(
      professor: map["professor"],
      subject: map["subject"],
      speciality: map["speciality"],
    );
  }
  createTable(Database db) async {
    await db.rawUpdate(
        "CREATE TABLE $TABLE_NAME (id integer primary key autoincrement, professor varchar(30),subject varchar(30),speciality varchar(30) )");
  }
  Map<String, dynamic> toJson() => {
        "professor": professor,
        "subject": subject,
        "speciality": speciality,
      };
      Map<String, dynamic> toMap() => {
        professor.toString(): subject.toString(),
        "speciality": speciality,
      };

  Map<String, dynamic> toMapDB() => {
        "professor": professor,
        "subject": subject,
        "speciality": speciality,
      };
}