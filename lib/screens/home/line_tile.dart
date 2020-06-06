import 'package:flutter/material.dart';
import 'package:takeanumber/models/line.dart';


class LineTile extends StatelessWidget {

  final Line line;
  LineTile({ this.line });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(top: 8.0),
      child: Card(
        margin: EdgeInsets.fromLTRB(20.0, 6.0, 20.0, 0.0),
        child: ListTile(
          leading: CircleAvatar(
            radius: 25.0,
            backgroundColor: Colors.green[line.strength],
            backgroundImage: AssetImage('assets/cartoon-turtle-png.png'),
          ),
          title: Text(line.name),
          subtitle: Text('Takes ${line.sugars} sugar(s)'),
        ),
      ),
    );
  }
}
