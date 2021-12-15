import 'dart:async';
import 'dart:convert';
import 'dart:io';

import 'package:ak_mined/database/database.dart';
import 'package:ak_mined/environments/environment.dart';
import 'package:ak_mined/modules/auth/services/notification_service.dart';
import 'package:ak_mined/utils/error_message.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:http/http.dart' as http;

class APIManager {
  final secureStorage = FlutterSecureStorage();
  DatabaseHelper databaseHelper = DatabaseHelper();
  Envirotnments envirotnments = Envirotnments();
  post({path: ''}) async {
    //cargo el token de acceso del storage
    String tokenAccess = await secureStorage.read(key: 'access') ?? '';

    try {
      final url = Uri.http(envirotnments.baseUrl, path);
      http.Response resp = await http.post(url, headers: {
        'Content-Type': 'application/json',
        'Authorization': 'Bearer $tokenAccess'
      }).timeout(Duration(seconds: 15), onTimeout: () {
        return http.Response('Error', 500);
      });
      print(resp.body);
      if (resp.statusCode == 200) {
        return resp;
      } else {
        print('Request failed with status: ${resp.statusCode}.');
        return null;
      }
    } catch (e) {
      if (e is SocketException) {
        NotificationService.showSnackBar(ErrorMessage.conection);
      } else if (e is TimeoutException) {
        NotificationService.showSnackBar(ErrorMessage.timeout);
      } else {
        NotificationService.showSnackBar(ErrorMessage.server);
      }
      print('asda');
      return null;
    }
  }

  get({path: '', amountRefresh: 0, refreshParam}) async {
    String? refresh = refreshParam;
    //cantida de repeticiones
    if (amountRefresh < 2) {
      //cargo el token de acceso del storage
      String tokenAccess = await secureStorage.read(key: 'access') ?? '';

      try {
        final url = Uri.http(envirotnments.baseUrl, '/api/v1/' + path);
        http.Response resp = await http.get(url, headers: {
          'Content-Type': 'application/json',
          'Authorization': 'Bearer $tokenAccess',
        }).timeout(Duration(seconds: 15), onTimeout: () {
          return http.Response('Error', 500);
        });

        if (resp.statusCode == 200) {
          return resp;
        }
        //si da un error de token
        else if (resp.statusCode == 403 || resp.statusCode == 401) {
          refresh = await refreshToken();
          return await get(
              path: path,
              amountRefresh: amountRefresh + 1,
              refreshParam: refresh);
        } else {
          print(resp.body);
          print('erro Request failed with status: ${resp.statusCode}.');
          NotificationService.showSnackBar(
              'Request failed with status: ${resp.statusCode}');
          return null;
        }
      } catch (e) {
        if (e is SocketException) {
          NotificationService.showSnackBar(ErrorMessage.conection);
        } else if (e is TimeoutException) {
          NotificationService.showSnackBar(ErrorMessage.timeout);
        } else {
          NotificationService.showSnackBar(ErrorMessage.server);
        }
        print('error desconocido ');
        return null;
      }
    }
    //error en el token de acceso
    else {
      print('------------------------');
      print(refresh);
      print('------------------------');
      if (refresh =='token_not_valid') {
        NotificationService.showSnackBar(ErrorMessage.tokenNotValid);
/*         return ErrorMessage.tokenNotValid; */
      }
       return null;
    }
  }

  Future<String?> refreshToken() async {
    try {
      final url = Uri.http(envirotnments.baseUrl, '/api/v1/fuc/token/refresh/');
      String refreshToken = await secureStorage.read(key: 'refresh') ?? '';
      /*   print('refresh: $refreshToken'); */
      final resp = await http
          .post(url,
              headers: {'Content-Type': 'application/json'},
              body: json.encode({"refresh": refreshToken}))
          .timeout(Duration(seconds: 15), onTimeout: () {
        return http.Response('Error', 500);
      });

      if (resp.statusCode == 200) {
        final Map<String, dynamic> decodedResp = json.decode(resp.body);
        print('resp: $decodedResp');

        if (decodedResp.containsKey('access')) {
          secureStorage.write(key: 'access', value: decodedResp['access']);
          return null;
        } else {
          return decodedResp['error']['message'];
        }
      } else {
        /* eniar si hay token invalido*/
        NotificationService.showSnackBar('resp: ${resp.body}');
        final Map<String, dynamic> decodedResp = json.decode(resp.body);
        String code = decodedResp['code'];
        return code;
      }
    } catch (e) {
      if (e is SocketException) {
        return ErrorMessage.conection;
      } else if (e is TimeoutException) {
        return ErrorMessage.timeout;
      } else {
        print(e.toString());
        return ErrorMessage.server;
      }
    }
  }

  Future<String?> login(String ci, String tomo, String folio) async {
    final Map<String, dynamic> authData = {
      'ci': int.parse(ci.trim()),
      'tome': int.parse(tomo.trim()),
      'folio': int.parse(folio.trim())
    };

    try {
      final url = Uri.http(envirotnments.baseUrl, '/api/v1/fuc/token/');
      final resp = await http
          .post(url,
              headers: {'Content-Type': 'application/json'},
              body: json.encode(authData))
          .timeout(Duration(seconds: 15), onTimeout: () {
        return http.Response('Error', 500);
      });

      if (resp.statusCode == 200) {
        final Map<String, dynamic> decodedResp = json.decode(resp.body);

        if (decodedResp.containsKey('access') &&
            decodedResp.containsKey('refresh')) {
          secureStorage.write(key: 'access', value: decodedResp['access']);
          secureStorage.write(key: 'refresh', value: decodedResp['refresh']);

          //elimina anteriores por si hubo algun error
          databaseHelper.deleteAllData();
          return null;
        } else {
          return decodedResp['error']['message'];
        }
      } else {
        print('resp: ${resp.body}');

        return ('Request failed with status: ${resp.statusCode}.');
      }
    } catch (e) {
      if (e is SocketException) {
        return ErrorMessage.conection;
      } else if (e is TimeoutException) {
        return ErrorMessage.timeout;
      } else {
        print(e.toString());
        return ErrorMessage.server;
      }
    }
  }

  Future<bool> checkToken({amountRefresh: 0}) async {
    final tokenAccess = await readTokenAccess();
    print('token: $tokenAccess');
    if (amountRefresh < 2) {
      if (tokenAccess != '') {
        final Map<String, dynamic> authData = {
          'token': tokenAccess,
        };

        try {
          final url =
              Uri.http(envirotnments.baseUrl, '/api/v1/fuc/token/verify/');
          final resp = await http
              .post(url,
                  headers: {'Content-Type': 'application/json'},
                  body: json.encode(authData))
              .timeout(Duration(seconds: 15), onTimeout: () {
            return http.Response('Error', 500);
          });
          print(resp.body);
          if (resp.statusCode == 200) {
            final Map<String, dynamic> decodedResp = json.decode(resp.body);
            print('resp: $decodedResp');
            return true;
          }
          //si da un error de token
          else if (resp.statusCode == 403 || resp.statusCode == 401) {
            print('refresh');
            await refreshToken();
            return await checkToken(amountRefresh: amountRefresh + 1);
          } else if (resp.statusCode == 500) {
            return true;
          } else {
            logout();
            return false;
          }
        } catch (e) {
          if (e is SocketException) {
            NotificationService.showSnackBar(ErrorMessage.conection);
            return true;
          } else if (e is TimeoutException) {
            NotificationService.showSnackBar(ErrorMessage.timeout);
            return true;
          } else {
            NotificationService.showSnackBar(ErrorMessage.server);
            print(e.toString());
            return true;
          }
        }
      } else {
        return false;
      }
    } else {
      return false;
    }
  }

  Future<bool> destroyToken() async {
    final tokenRefresh = await readTokenRefresh();
    final tokenAccess = await readTokenAccess();

    if (tokenRefresh != '') {
      try {
        final url =
            Uri.http(envirotnments.baseUrl, '/api/v1/fuc/token/destroy/');
        final resp = await http
            .post(url,
                headers: {
                  'Content-Type': 'application/json',
                  'Authorization': 'Bearer $tokenAccess'
                },
                body: json.encode({"refresh_token": tokenRefresh}))
            .timeout(Duration(seconds: 15), onTimeout: () {
          return http.Response('Error', 500);
        });
        print(resp.body);
        if (resp.statusCode == 200) {
          return true;
        } else {
          NotificationService.showSnackBar('Error: ${resp.statusCode}');
          return false;
        }
      } catch (e) {
        if (e is SocketException) {
          NotificationService.showSnackBar(ErrorMessage.conection);
          return false;
        } else if (e is TimeoutException) {
          NotificationService.showSnackBar(ErrorMessage.timeout);
          return false;
        } else {
          NotificationService.showSnackBar(ErrorMessage.server);
          print(e.toString());
          return false;
        }
      }
    } else {
      return false;
    }
  }

  Future<String> readTokenAccess() async {
    return await secureStorage.read(key: 'access') ?? '';
  }

  Future<String> readTokenRefresh() async {
    return await secureStorage.read(key: 'refresh') ?? '';
  }

  Future logout() async {
    final resp =  await destroyToken();
    if (resp) {
      databaseHelper.deleteAllData();
      secureStorage.delete(key: 'refresh');
      secureStorage.delete(key: 'access');
    }
    return resp;
  }
}
