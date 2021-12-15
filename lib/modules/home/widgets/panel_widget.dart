import 'package:flutter/material.dart';
import 'package:ak_mined/utils/extensions.dart';

class PanelCard extends StatefulWidget {
  final name;
  final icon;
  final onTap;

  const PanelCard({
    this.name,
    this.onTap,
    this.icon,
  });
  @override
  _PanelCardState createState() => _PanelCardState();
}

class _PanelCardState extends State<PanelCard> {
  @override
  Widget build(BuildContext context) {
    final borderRadius = BorderRadius.circular(12);
    final lineRadius = BorderRadius.only(
        topRight: Radius.circular(27), bottomLeft: Radius.circular(15));
    final backColor = Colors.white;

    return Container(
      decoration: BoxDecoration(boxShadow: [
        BoxShadow(
          color: Colors.grey.withOpacity(0.3),

          spreadRadius: 3,
          blurRadius: 3,
          offset: Offset(0, 2), // changes position of shadow
        ),
      ],  borderRadius: borderRadius),
      child: Material(  borderRadius: borderRadius,
        child: InkWell(
          onTap: widget.onTap,
          borderRadius: borderRadius,
          child: Ink(
            child: Stack(children: [
              Container(
                padding: EdgeInsets.all(20),
                child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      Flexible(
                        child: Padding(
                          padding: const EdgeInsets.only(top: 15),
                          child: Text(
                            widget.name,
                            overflow: TextOverflow.ellipsis,
                            maxLines: 1,
                            style: TextStyle(
                              color: Color(0xFF7E7A7A),
                              fontSize: 21.0,
                            ),
                          ),
                        ),
                      ),
                      Icon(widget.icon,
                          color: Theme.of(context).primaryColor, size: 50),
                    ]),
              ),
              Positioned(
                child: Container(
                  decoration: BoxDecoration(
                    color: Theme.of(context).primaryColor,
                    borderRadius: lineRadius,
                  ),
                  width: (context.width) / 2,
                  height: 8,
                ),
                bottom: 0,
                left: 0,
              )
            ]),
            decoration: BoxDecoration(
              borderRadius: borderRadius,
              color: backColor,
            ),
          ),
        ),
      ),
    );
  }
}
