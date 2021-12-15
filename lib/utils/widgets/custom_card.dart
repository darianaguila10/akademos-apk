import 'package:flutter/material.dart';

class CustomCard extends StatelessWidget {
  final Widget child;

  const CustomCard({Key? key, required this.child}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20),
      child: Container(margin: EdgeInsets.only(top: 15,bottom: 20),
          width: double.infinity,
       /*    padding: EdgeInsets.all(10), */
          decoration: _cardDecoration(),
          child: this.child),
    );
  }

  BoxDecoration _cardDecoration() => BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(15),
          boxShadow: [
            BoxShadow(
                color: Colors.black12, blurRadius: 14, offset: Offset(0, 5))
          ]);
}
