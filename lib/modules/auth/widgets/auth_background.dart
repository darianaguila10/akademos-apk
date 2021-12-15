import 'package:ak_mined/modules/setting/screens/setting_screen.dart';
import 'package:flutter/material.dart';
import 'package:ak_mined/utils/extensions.dart';

class AuthBackground extends StatelessWidget {
  final Widget child;

  const AuthBackground({Key? key, required this.child}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      height: double.infinity,
      child: Stack(
        children: [
          _UpBox(),
          _HeaderIcon(),
          Positioned(
              bottom: 20,
              width: context.width,
              child: Column(
                children: [
                  Text("Universidad de las Ciencias Informática.",
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        fontSize: 14,
                      )),
                  SizedBox(
                    height: 5,
                  ),
                  Text("XAUCE Akademos. Todos los derechos reservados.",
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        fontSize: 14,
                      )),
                ],
              )),
         
          this.child, Positioned(
              top: 50,
              right: 20,
              child: IconButton(
                  iconSize: 30,
                  icon: Icon(
                    Icons.settings,
                    color: Colors.white,
                  ),
                  onPressed: () {
                    print("Asd");
                    Navigator.pushNamed(context, SettingScreen.routeName);
                  })),
        ],
      ),
    );
  }
}

class _HeaderIcon extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Container(
        margin: EdgeInsets.only(top: 30),
        width: double.infinity,
        child: Icon(
          Icons.person_pin,
          color: Colors.white,
          size: 100,
        ),
      ),
    );
  }
}

class _UpBox extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
/*       color: Theme.of(context).primaryColor, */
      width: double.infinity,
      height: context.height * 0.4,
      decoration: _upBoxDecoration(),
    );
  }

  BoxDecoration _upBoxDecoration() => BoxDecoration(
          gradient: LinearGradient(
              begin: Alignment.topCenter,
              end: Alignment.bottomCenter,
              colors: [
            Color(0xFFf38f1d),
            Color(0xFFF3A74F),
          ]));
}
