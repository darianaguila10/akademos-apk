import 'package:ak_mined/modules/student/services/student_data_service.dart';
import 'package:ak_mined/modules/student/widgets/widgets.dart';
import 'package:animate_do/animate_do.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';

class StudentDataScreen extends StatefulWidget {
  static const String routeName = "student_data_screen";

  StudentDataScreen({Key? key}) : super(key: key);

  @override
  _StudentDataScreenState createState() => _StudentDataScreenState();
}

class _StudentDataScreenState extends State<StudentDataScreen> {
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (_) => StudentDataService(),
      child: Scaffold(
        appBar: AppBar(
          elevation: 0,
          iconTheme: IconThemeData(color: Colors.white),
          title: Text(
            'Mis datos',
            style: TextStyle(color: Colors.white),
          ),
        ),
        /*  drawer: AKDrawer(), */
        body: StudentData(),
      ),
    );
  }
}

class StudentData extends StatelessWidget {
  final RefreshController _refreshController =
      RefreshController(initialRefresh: false);

  @override
  Widget build(BuildContext context) {
    final studentData = Provider.of<StudentDataService>(context);
    if (studentData.isLoading) return showLoading();
    
    return Container(
      width: double.infinity,
      height: double.infinity,
      child: SmartRefresher(
        enablePullDown: true,
        header: WaterDropMaterialHeader(),
        onRefresh: () async {
          await studentData.loadStudentData();
          _refreshController.loadComplete();
        },
        controller: _refreshController,
        child: ListView(
          physics: BouncingScrollPhysics(),
          children: [
            FadeInDown(
              child: InfoCard(
                title: 'Información nominal',
                data: studentData.studentData,
              ),
            ),
          ],
        ),
      ),
    );
  }

  showLoading() {
    return Container(
/*       color: Colors.black.withOpacity(0.1), */
      child: Center(
        child: CircularProgressIndicator(),
      ),
    );
  }
}
