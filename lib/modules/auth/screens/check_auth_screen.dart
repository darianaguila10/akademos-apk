import 'package:ak_mined/modules/auth/screens/login_screen.dart';
import 'package:ak_mined/modules/auth/services/auth_service.dart';
import 'package:ak_mined/modules/home/screens/home_screen.dart';
import 'package:flutter/material.dart';
import 'package:ak_mined/utils/extensions.dart';
import 'package:provider/provider.dart';

class CheckAuthScreen extends StatelessWidget {
  static const String routeName = "check_auth_screen";

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: FutureBuilder(
        future: checkLoginState(context),
        builder: (BuildContext context, AsyncSnapshot snapshot) {
          return Stack(children: [
            Center(child: CircularProgressIndicator()),
            Positioned(
              width: context.width,
              child: Text(
                'Bienvenido a Akademos',
                style: TextStyle(fontSize: 18),
                textAlign: TextAlign.center,
              ),
              bottom: 40,
            )
          ]);
        },
      ),
    );
  }

  Future checkLoginState(BuildContext context) async {
    final authService = Provider.of<AuthService>(context, listen: false);
    final isLoggedIn = await authService.checkToken();
    if (isLoggedIn) {
      Navigator.pushReplacement(
          context,
          PageRouteBuilder(
              pageBuilder: (_, __, ___) => HomeScreen(),
              transitionDuration: Duration(milliseconds: 0)));
    } else {
      Navigator.pushReplacement(
          context,
          PageRouteBuilder(
              pageBuilder: (_, __, ___) => LoginScreen(),
              transitionDuration: Duration(milliseconds: 0)));
    }
  }
}
