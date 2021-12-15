import 'dart:async';

import 'package:ak_mined/api_services/api_manager.dart';
import 'package:ak_mined/database/database.dart';
import 'package:ak_mined/modules/student/models/educational_center_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';

class EducationalCenterService extends ChangeNotifier {
  final secureStorage = FlutterSecureStorage();
  List educationalCenterList = [];
  DatabaseHelper databaseHelper = DatabaseHelper();
  bool isLoading = true;

  EducationalCenterService() {
    this.loadEducationalCenterData();
  }

  //load data
  Future<bool> loadEducationalCenterData() async {
     educationalCenterList = [];

    showloading();

    //carga de la api
    List<EducationalCenter>? resp = await loadEducationalCenterDataAPI();

    //si todo bien convierte a mapa y actualiza en la bd
    if (resp != null) {
      resp.forEach((element) {
        educationalCenterList.add(element.toMap());
      });
     
      saveEducationalCenterDataDB(resp);

      hideLoading();
    }
    //si da error, carga de la base de datos
    else {
      List<EducationalCenter>? respDB =
          await databaseHelper.getEducationalCenterData();
      if (respDB != null) {
        respDB.forEach((element) {
          educationalCenterList.add(element.toMap());
        });
        hideLoading();
      }
    }
    return true;
  }

//load of API
  Future<List<EducationalCenter>?> loadEducationalCenterDataAPI() async {
    List<EducationalCenter>? educationalCenter;

    final resp = await APIManager().get(path: 'fuc/center_details/');

    if (resp != null && resp.statusCode == 200) {
      print('decodedResp: ${resp.body}.');
      educationalCenter = educationalCenterFromJson(resp.body);
    } else {
      print('Request failed with status: ${resp}.');
    }
    return educationalCenter;
  }

  Future<void> saveEducationalCenterDataDB(List<EducationalCenter> resp) async {
    await databaseHelper.deleteEducationalCenter();
    resp.forEach((e) async {
      await databaseHelper.insertEducationalCenters(e);
    });
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
