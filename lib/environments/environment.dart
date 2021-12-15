import 'package:ak_mined/preference/preference.dart';

class Envirotnments {
  final shPref = Preference();
/*   static const */ String baseUrl = '192.168.1.103:8000';
  static const String token = '';
  Envirotnments() {
  this.baseUrl=shPref.ipAndport;
  }
}
