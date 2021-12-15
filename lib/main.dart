import 'package:ak_mined/environments/gloabal_variable.dart';
import 'package:ak_mined/modules/auth/services/auth_service.dart';
import 'package:ak_mined/modules/auth/services/notification_service.dart';
import 'package:ak_mined/preference/preference.dart';
import 'package:ak_mined/routes.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();

  //preferencias
  final prefs = Preference();
  await prefs.iniPrefs();
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    GlobalVariables gv = GlobalVariables();

    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => AuthService()),
      ],
      child: MaterialApp(
        scaffoldMessengerKey: NotificationService.messengerKey,
        title: 'AK-MINED',
        theme: ThemeData(
          scaffoldBackgroundColor: Colors.grey[300],
          appBarTheme: AppBarTheme(brightness: Brightness.dark),
          // is not restarted.a
          primaryColor: Color(0xFFf38f1d),
          accentColor: Color(0xFFF0A855),
        ),
        routes: getApplicationRoutes(),
      ),
    );
  }
}
