import 'package:ak_mined/modules/student/models/professor_models.dart';
import 'package:ak_mined/modules/student/services/professor_service.dart';
import 'package:ak_mined/modules/student/widgets/speciality_table_card.dart';
import 'package:ak_mined/modules/student/widgets/widgets.dart';
import 'package:animate_do/animate_do.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';

class ProfessorScreen extends StatelessWidget {
  static const String routeName = "professor_screen";

  ProfessorScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (_) => ProfessorService(),
      child: Scaffold(
          appBar: AppBar(
            elevation: 0,
            iconTheme: IconThemeData(color: Colors.white),
            title: Text(
              'Mis profesores',
              style: TextStyle(color: Colors.white),
            ),
          ),
          body: GetData()),
    );
  }
}

class GetData extends StatefulWidget {
  @override
  _GetDataState createState() => _GetDataState();
}

class _GetDataState extends State<GetData> {
  Map professorData = {};
  List keys = [];

  final RefreshController _refreshController =
      RefreshController(initialRefresh: false);

  @override
  Widget build(BuildContext context) {
    final professorData = Provider.of<ProfessorService>(context);
    if (professorData.isLoading) return showLoading();
    this.professorData = professorData.professorList;

    this.keys = professorData.professorList.keys.toList();

    return Container(
      width: double.infinity,
      height: double.infinity,
      child: SmartRefresher(
        enablePullDown: true,
        header: WaterDropMaterialHeader(),
        onRefresh: () async {
          await professorData.loadProfessorData();
          _refreshController.loadComplete();
        },
        controller: _refreshController,
        child: ListView.builder(
          itemCount: keys.length,
          physics: BouncingScrollPhysics(),
          itemBuilder: _itemBuilder,
        ),
      ),
    );
  }

  showLoading() {
    return Container(
      child: Center(
        child: CircularProgressIndicator(),
      ),
    );
  }

  Widget _itemBuilder(BuildContext context, int index) {
    List<Professor> e = this.professorData[this.keys[index]];

   return FadeInDown(
        delay: Duration(milliseconds: 200), child: SpecialityTableCard(e));
  }
}
