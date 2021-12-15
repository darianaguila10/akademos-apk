import 'package:ak_mined/modules/student/models/professor_models.dart';
import 'package:ak_mined/utils/widgets/custom_card.dart';
import 'package:flutter/material.dart';

class SpecialityTableCard extends StatelessWidget {
  final List<Professor> professorList;

  SpecialityTableCard(this.professorList);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Container(
          margin: EdgeInsets.only(top: 20),
          padding: const EdgeInsets.symmetric(
            horizontal: 20,
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                this.professorList[0].speciality!,
                style: TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.w500,
                ),
              ),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 1),
                child: Row(children: [
                  Container(
                    margin: EdgeInsets.only(top: 5),
                    height: 2,
                    width: professorList[0].speciality!.length * 11.5,
                    color: Theme.of(context).primaryColor,
                  ),
                  Expanded(
                    child: Container(
                      margin: EdgeInsets.only(top: 5),
                      height: 2,
                      color: Colors.grey[400],
                    ),
                  ),
                ]),
              )
            ],
          ),
        ),
        CustomCard(
          child: ClipRRect(
            borderRadius: BorderRadius.circular(15.0),
            child: DataTable(columns: [
              DataColumn(label: Text("Profesor")),
              DataColumn(label: Text("Asignatura")),
            ], rows: getRow(professorList)),
          ),
        ),
      ],
    );
  }

  getRow(List<Professor> data) {
    List<DataRow> dataRow = [];
    int index = 1;
    data.forEach((e) => dataRow.add(DataRow(
            color: MaterialStateColor.resolveWith((states) =>
                index++ % 2 == 0 ? Color(0xFFF7F3F3) : Color(0xFFeaeaea)),
            cells: [
              DataCell(Text(e.professor!)),
              DataCell(Text(e.subject!)),
            ])));
    return dataRow;
  }
}
