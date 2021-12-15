 import 'package:shared_preferences/shared_preferences.dart';

class Preference {
  static final Preference _intancia = new Preference._internal();

  factory Preference() {
    return _intancia;
  }
  Preference._internal();
  SharedPreferences? _prefs;

  iniPrefs() async {
    _prefs = await SharedPreferences.getInstance();
  }

  String get ipAndport {
    return _prefs!.getString('ipport') ?? '192.168.1.103:8000';
  }

  set ipAndport(String ipport) {
    _prefs!.setString('ipport', ipport);
  }

 
}
 