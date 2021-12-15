import 'package:ak_mined/modules/auth/screens/check_auth_screen.dart';
import 'package:ak_mined/modules/home/screens/home_screen.dart';
import 'package:ak_mined/modules/setting/screens/setting_screen.dart';
import 'package:ak_mined/modules/student/screens/educational_centers_screen.dart';
import 'package:ak_mined/modules/student/screens/stundent_data_screen.dart';
import 'package:ak_mined/modules/auth/screens/login_screen.dart';
import 'package:ak_mined/modules/student/screens/professor_screen.dart';
import 'package:flutter/material.dart';

Map<String, WidgetBuilder> getApplicationRoutes() {
  return <String, WidgetBuilder>{
    '/': (BuildContext context) => CheckAuthScreen                                                                                                           (),
    CheckAuthScreen.routeName: (_) => CheckAuthScreen(),
    LoginScreen.routeName: (_) => LoginScreen(),
    StudentDataScreen.routeName: (_) => StudentDataScreen(),
    EducationalCentersScreen.routeName: (_) => EducationalCentersScreen(),
    ProfessorScreen.routeName: (_) => ProfessorScreen(),
    HomeScreen.routeName: (_) => HomeScreen(),
    SettingScreen.routeName:(_) => SettingScreen(),

  };
}
