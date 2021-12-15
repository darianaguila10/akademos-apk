import 'package:ak_mined/environments/gloabal_variable.dart';
import 'package:ak_mined/preference/preference.dart';
import 'package:flutter/material.dart';

class SettingScreen extends StatefulWidget {
  static const String routeName = "setting_screen";

  @override
  _SettingScreenState createState() => _SettingScreenState();
}

class _SettingScreenState extends State<SettingScreen> {
  final prefs = Preference();
  @override
  void initState() {
    GlobalVariables.addNumberStarts();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          iconTheme: IconThemeData(color: Colors.white),
          title: Text(
            'Configuración',
            style: TextStyle(color: Colors.white),
          ),
        ),
        body: Container(
          padding: EdgeInsets.all(20),
          child: TextFormField(
            initialValue: prefs.ipAndport,
            onChanged: (v) {
              if ( v.length > 8) {
                print('guardo');
                prefs.ipAndport = v;
              }
            },
           /*  keyboardType: TextInputType.numberWithOptions(
              decimal: true,
            ), */
            decoration: InputDecoration(
                hintText: "Dirección IP y PORT",
                labelText: "IP:PORT",
                border: OutlineInputBorder(
                    gapPadding: 0.0, borderRadius: BorderRadius.circular(16))),
          ),
        ));
  }
}
