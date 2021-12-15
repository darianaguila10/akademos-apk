import 'dart:async';

import 'package:ak_mined/api_services/api_manager.dart';
import 'package:ak_mined/database/database.dart';
import 'package:ak_mined/modules/student/models/student_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';

class StudentDataService extends ChangeNotifier {
  DatabaseHelper databaseHelper = DatabaseHelper();

  final secureStorage = FlutterSecureStorage();
  Map<String, dynamic> studentData = {};
  bool isLoading = true;

  StudentDataService() {
    this.loadStudentData();
  }

  //load data
  Future<bool> loadStudentData() async {
    studentData = {};

    showloading();

    //carga de la api
    Student? resp = await loadStudentDataAPI();

    //si todo bien convierte a mapa y actualiza en la bd
    if (resp != null) {
      studentData = resp.toMap();
      saveStudentDataDB(resp);

      hideLoading();
    }
    //si da error, carga de la base de datos
    else {
      Student? respDB = await databaseHelper.getStudentData();
      if (respDB != null) {
        studentData = respDB.toMap();
        hideLoading();
      }
    }
    return true;
  }

//load of API
  Future<Student?> loadStudentDataAPI() async {
    Student? student;
    /*    this.isLoading = true;
    notifyListeners(); */

    final resp = await APIManager().get(path: 'fuc/person_details/');

    if (resp != null && resp.statusCode == 200) {
      student = studentFromJson(resp.body);
      /*   this.isLoading = false;
      notifyListeners(); */
      print('decodedResp: ${resp.body}.');
    } else {
      print('Request failed with status: $resp.');
    }

    /*    this.isLoading = false;
    notifyListeners(); */
    return student;
  }

  Future<void> saveStudentDataDB(Student student) async {
     await databaseHelper.deleteEducationalCenter();
    await  databaseHelper.insertStudent(student);
  }


  hideLoading() {
    this.isLoading = false;
    notifyListeners();
  }

  void showloading() {
    this.isLoading = true;
    notifyListeners();
  }
}
