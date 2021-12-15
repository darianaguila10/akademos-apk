import 'dart:async';

import 'package:ak_mined/api_services/api_manager.dart';
import 'package:ak_mined/database/database.dart';
import 'package:ak_mined/modules/student/models/professor_models.dart';
import 'package:flutter/material.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import "package:collection/collection.dart";

class ProfessorService extends ChangeNotifier {
  final secureStorage = FlutterSecureStorage();
  Map professorList = {};
  DatabaseHelper databaseHelper = DatabaseHelper();
  bool isLoading = true;

  ProfessorService() {
    this.loadProfessorData();
  }

  //load data
  Future<bool> loadProfessorData() async {
    professorList = {};

    showloading();

    //carga de la api
    List<Professor>? resp = await loadProfessorDataAPI();

    //si todo bien convierte a mapa y actualiza en la bd
    if (resp != null) {
      professorList = groupBy(resp, (Professor obj) => obj.speciality);
      saveProfessorDataDB(resp);

      hideLoading();
    }

    //si da error, carga de la base de datos
    else {
      List<Professor> respDB = await databaseHelper.getProfessorData();
      if (respDB.length > 0) {
        professorList = groupBy(respDB, (Professor obj) => obj.speciality);
        hideLoading();
      }
    }

    return true;
  }

//load of API
  Future<List<Professor>?> loadProfessorDataAPI() async {
    List<Professor>? professor;

    final resp = await APIManager().get(path: 'fuc/professors_by_student/');

    if (resp != null && resp.statusCode == 200) {
      print('decodedResp: ${resp.body}.');
      professor = professorFromJson(resp.body);
    } else {
      print('Request failed with status: $resp.');
    }

    return professor;
  }

  saveProfessorDataDB(List<Professor> resp) async {
    await databaseHelper.deleteProfessor();
    resp.forEach((element) async {
      await databaseHelper.insertProfessorData(element);
    });
    print(resp);
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
