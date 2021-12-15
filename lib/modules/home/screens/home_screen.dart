import 'package:ak_mined/environments/gloabal_variable.dart';
import 'package:ak_mined/modules/home/widgets/panel_widget.dart';
import 'package:ak_mined/modules/setting/screens/setting_screen.dart';
import 'package:ak_mined/modules/student/screens/educational_centers_screen.dart';
import 'package:ak_mined/modules/student/screens/professor_screen.dart';
import 'package:ak_mined/modules/student/screens/stundent_data_screen.dart';
import 'package:ak_mined/modules/student/widgets/widgets.dart';
import 'package:animate_do/animate_do.dart';
import 'package:flutter/material.dart';

class HomeScreen extends StatefulWidget {
  static const String routeName = "home_screen";

  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final List<Map<String, dynamic>> panelList = [
    {
      'name': "Mis datos",
      'icon': Icons.person_outline,
      'route': StudentDataScreen.routeName
    },
    {
      'name': "Centro Educacional",
      'icon': Icons.account_tree_outlined,
      'route': EducationalCentersScreen.routeName
    },
    {
      'name': "Profesores",
      'icon': Icons.menu_book_rounded,
      'route': ProfessorScreen.routeName
    },
  ];
  @override
  void initState() {
    GlobalVariables.addNumberStarts();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          actions: [
            IconButton(
                icon: Icon(Icons.settings),
                onPressed: () {
                  Navigator.pushNamed(context, SettingScreen.routeName);
                })
          ],
          iconTheme: IconThemeData(color: Colors.white),
          title: Text(
            'Akademos',
            style: TextStyle(color: Colors.white),
          ),
        ),
        drawer: AKDrawer(),
        body: Container(
          child: GridView.builder(
            itemCount: panelList.length,
            gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                childAspectRatio: 2.6,
                crossAxisCount: 1,
                crossAxisSpacing: 16,
                mainAxisSpacing: 16),
            padding: EdgeInsets.only(top: 16, left: 20, right: 20, bottom: 33),
            itemBuilder: (context, index) {
              //para animar solo la primera vez
              return getAnimatedCard(index);
            },
            physics: BouncingScrollPhysics(),
          ),
        ));
  }

  getAnimatedCard(int index) {
    return GlobalVariables.getnumberStarts == 1
        ? FadeInLeft(
            delay: Duration(milliseconds: index * 250),
            child: PanelCard(
                name: panelList[index]['name'],
                //esto es para el candado abierto o cerrado
                icon: panelList[index]['icon'],
                onTap: () async {
                  Navigator.of(context).pushNamed(panelList[index]['route']);
                }),
          )
        : PanelCard(
            name: panelList[index]['name'],
            //esto es para el candado abierto o cerrado
            icon: panelList[index]['icon'],
            onTap: () async {
              Navigator.of(context).pushNamed(panelList[index]['route']);
            });
  }
}
