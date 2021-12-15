import 'dart:async';

import 'package:ak_mined/api_services/api_manager.dart';
import 'package:ak_mined/database/database.dart';
import 'package:ak_mined/environments/environment.dart';
import 'package:flutter/material.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';

class AuthService extends ChangeNotifier {
  Envirotnments envirotnments = Envirotnments();
  final secureStorage = FlutterSecureStorage();
  DatabaseHelper databaseHelper = DatabaseHelper();
  bool isLoggedIn = false;
  APIManager apiManager = APIManager();

  Future<String?> login(String ci, String tomo, String folio) async {
    final resp = await apiManager.login(ci, tomo, folio);
    if (resp == null) isLoggedIn = true;
    return resp;
  }

  Future<bool> checkToken() async {
    final resp = await apiManager.checkToken();
    if (resp) isLoggedIn = true;
    return resp;
  }

  Future<bool> destroyToken() async {
    bool resp = await apiManager.destroyToken();
    if (resp) isLoggedIn = false;
    return resp;
  }

  Future logout() async {
    final resp = await apiManager.logout();
    if (resp) isLoggedIn = true;
    return resp;
  }

  Future<String> readTokenAccess() async {
    return await secureStorage.read(key: 'access') ?? '';
  }

  Future<String> readTokenRefresh() async {
    return await secureStorage.read(key: 'refresh') ?? '';
  }
}
