import 'package:ak_mined/modules/student/services/educational_centers_service.dart';
import 'package:ak_mined/modules/student/widgets/widgets.dart';
import 'package:animate_do/animate_do.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';

class EducationalCentersScreen extends StatelessWidget {
  static const String routeName = "educational_centers_screen";

  EducationalCentersScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (_) => EducationalCenterService(),
      child: Scaffold(
          appBar: AppBar(
            elevation: 0,
            iconTheme: IconThemeData(color: Colors.white),
            title: Text(
              'Centro educacional',
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
   List list = [];

  final RefreshController _refreshController =
      RefreshController(initialRefresh: false);

  @override
  Widget build(BuildContext context) {
    final educationalCenterData =
        Provider.of<EducationalCenterService>(context);
    if (educationalCenterData.isLoading) return showLoading();
    list=educationalCenterData.educationalCenterList;

    return Container(
      width: double.infinity,
      height: double.infinity,
      child: SmartRefresher(
          enablePullDown: true,
          header: WaterDropMaterialHeader(),
          onRefresh: () async {
            await educationalCenterData.loadEducationalCenterData();
            _refreshController.loadComplete();
          },
          controller: _refreshController,
          child: ListView.builder(
            physics: BouncingScrollPhysics(),
            itemCount: list.length,
            itemBuilder: _itemBuilder,
          )),
    );
  }

  showLoading() {
    return Container(
      child: Center(
        child: CircularProgressIndicator(),
      ),
    );
  }

  educacionalCenterCards(data) {
    return Container(
      padding: EdgeInsets.only(
        bottom: 15,
      ),
      child: Column(
        children: [
          FadeInDown(
            child: InfoCard(
              title: data[0]['Nombre'],
              data: data[0],
            ),
          ),
          FadeInDown(
            delay: Duration(milliseconds: 250),
            child: InfoCard(
              title: 'Consejo de dirección',
              data: data[1],
            ),
          ),
        ],
      ),
    );
  }

  Widget _itemBuilder(BuildContext context, int index) {
   
    return educacionalCenterCards(this.list[index]);
  }
}
