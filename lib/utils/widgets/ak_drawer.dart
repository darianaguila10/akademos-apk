import 'package:ak_mined/modules/auth/screens/login_screen.dart';
import 'package:ak_mined/modules/auth/services/auth_service.dart';
import 'package:ak_mined/modules/student/screens/educational_centers_screen.dart';
import 'package:ak_mined/modules/student/screens/stundent_data_screen.dart';
import 'package:ak_mined/modules/student/screens/professor_screen.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class AKDrawer extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final authService = Provider.of<AuthService>(context, listen: true);
    return new Drawer(
      child: new ListView(
        padding: const EdgeInsets.only(top: 0.0),
        children: <Widget>[
          new UserAccountsDrawerHeader(
            accountName: Text(
              "Estudiante 1",
              style: TextStyle(color: Colors.white),
            ),
            accountEmail: null,
            currentAccountPicture: CircleAvatar(
              backgroundColor: Colors.grey,
              child: Icon(
                Icons.person,
                color: Colors.white,
                size: 35,
              ),
            ),
          ),
          ListTile(
            title: new Text(
              "Inicio",
              overflow: TextOverflow.ellipsis,
            ),
            /*  trailing: Icon(Icons.home), */
            onTap: () {
              Navigator.of(context).pop();
            },
          ),
          Divider(
            height: 5,
            color: Colors.grey,
          ),
          ListTile(
            title: new Text(
              "Mis datos",
              overflow: TextOverflow.ellipsis,
            ),
            trailing: Icon(Icons.navigate_next),
            onTap: () {
              Navigator.popAndPushNamed(context, StudentDataScreen.routeName);
            },
          ),
          ListTile(
            title: new Text(
              "Centro educacional",
              overflow: TextOverflow.ellipsis,
            ),
            trailing: Icon(Icons.navigate_next),
            onTap: () {
              Navigator.popAndPushNamed(
                  context, EducationalCentersScreen.routeName);
            },
          ),
          ListTile(
            title: new Text(
              "Mis profesores",
              overflow: TextOverflow.ellipsis,
            ),
            trailing: Icon(Icons.navigate_next),
            onTap: () {
              Navigator.popAndPushNamed(context, ProfessorScreen.routeName);
            },
          ),
          Divider(
            height: 5,
            color: Colors.grey,
          ),
          ListTile(
            title: new Text(
              "Cerrar sesión",
              overflow: TextOverflow.ellipsis,
            ),
            trailing: Icon(Icons.logout),
            onTap: () {
              showDialog(
                  context: context,
                  builder: (builder) {
                    return AlertDialog(
                      shape: RoundedRectangleBorder(
                          borderRadius:
                              BorderRadius.all(Radius.circular(20.0))),
                      title: Text("Cerrar sesión"),
                      content: Text("¿Esta seguro de cerrar la sesión?"),
                      actions: <Widget>[
                        ElevatedButton(
                          style: ElevatedButton.styleFrom(
                            primary: Theme.of(context).accentColor,
                            shape: new RoundedRectangleBorder(
                              borderRadius: new BorderRadius.circular(30.0),
                            ),
                          ),
                          child: Text("Cancelar"),
                          onPressed: () {
                            Navigator.of(context).pop();
                          },
                        ),
                        ElevatedButton(
                            style: ElevatedButton.styleFrom(
                              primary: Theme.of(context).primaryColor,
                              shape: new RoundedRectangleBorder(
                                borderRadius: new BorderRadius.circular(30.0),
                              ),
                            ),
                            child: Text("Aceptar"),
                            onPressed: () async {
                              if (await authService.logout()) {
                                /*  Navigator.of(context).pop(); */
                                Navigator.of(context).pushNamedAndRemoveUntil(
                                    LoginScreen.routeName,
                                    (Route<dynamic> route) => false);
                              }else{
                                Navigator.of(context).pop();
                                Navigator.of(context).pop();

                              }
                              /*   Navigator.pushReplacementNamed(
                                  context, LoginScreen.routeName); */
                            })
                      ],
                    );
                  });
            },
          ),
        ],
      ),
    );
  }
}
