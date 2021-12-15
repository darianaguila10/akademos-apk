import 'package:flutter/material.dart';

class InfoCard extends StatelessWidget {
  final Map data;
  final String title;

  const InfoCard({
    Key? key,
    required this.title,
    required this.data,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 30),
      child: Container(
        margin: EdgeInsets.only(top: 20,bottom: 20),
        width: double.infinity,
        padding: EdgeInsets.all(20),
        decoration: _cardDecoration(),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: generatedRow(context),
        ),
      ),
    );
  }

  BoxDecoration _cardDecoration() => BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(25),
          boxShadow: [
            BoxShadow(
                color: Colors.black12, blurRadius: 14, offset: Offset(0, 5))
          ]);

  generatedRow(BuildContext context) {
    List<Widget> listRow = [];
    listRow.add(Text(
      this.title,
      style: TextStyle(
        fontSize: 20,
        fontWeight: FontWeight.w500,
      ),
    ));
    listRow.add(Row(children: [
      Container(
        margin: EdgeInsets.only(top: 5),
        height: 2,
        width: this.title.length * 10.5,
        color: Theme.of(context).primaryColor,
      ),
      Expanded(
        child: Container(
          margin: EdgeInsets.only(top: 5),
          height: 2,
          color: Colors.grey[300],
        ),
      ),
    ]));
    data.forEach((key, value) {
      listRow.add(Container(
        margin: EdgeInsets.only(top: 10),
        child: Row(
          children: [
            Text(
              key + ": ",
              style: TextStyle(fontWeight: FontWeight.w500, fontSize: 15),
            ),
            Flexible(
              child: Text(
                value.toString(),
                style: TextStyle(fontSize: 15),
                textAlign: TextAlign.start,
              ),
            )
          ],
        ),
      ));
    });

    return listRow;
  }
}
