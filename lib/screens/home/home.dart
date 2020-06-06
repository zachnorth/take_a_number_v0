import 'package:flutter/material.dart';
import 'package:takeanumber/models/line.dart';
import 'package:takeanumber/screens/home/line_list.dart';
import 'package:takeanumber/screens/home/settings_form.dart';
import 'package:takeanumber/services/auth.dart';
import 'package:provider/provider.dart';
import 'package:takeanumber/services/database.dart';
import 'dart:math';

class Home extends StatelessWidget {

  final AuthService _auth = AuthService();

  @override
  Widget build(BuildContext context) {

    void _showSettingsPanel() {
      showModalBottomSheet(context: context, builder: (context) {
        return Container(
          padding: EdgeInsets.symmetric(vertical: 20.0, horizontal: 60.0),
          child: SettingsForm(),
        );
      });
    }

    final String background = _imageGetter();

    return StreamProvider<List<Line>>.value(
      value: DatabaseService().lines,
      child: Scaffold(
        backgroundColor: Colors.grey[500],
        appBar: AppBar(
          title: Text('Take a Number'),
          backgroundColor: Colors.teal[400],
          elevation: 0.0,
          actions: <Widget>[
            FlatButton.icon(
              icon: Icon(Icons.person),
              label: Text('Logout'),
              onPressed: () async {
                await _auth.signOut();
              },
            ),
            FlatButton.icon(
              icon: Icon(Icons.settings),
              label: Text('Settings'),
              onPressed: () => _showSettingsPanel(),
            ),
          ],
        ),
        body: Container(
          decoration: BoxDecoration(
            image: DecorationImage(
              image: AssetImage('assets/$background'),
                  fit: BoxFit.cover
            ),
          ),
          child: LineList(),
        ),
      ),
    );
  }

  String _imageGetter() {
    var rng = new Random();
    var list = ['maroonBells.jpg', 'everest1.jpg', 'falls1.jpg', 'fuji1.jpg', 'halfdome1.jpg'];
    return list[rng.nextInt(5)];
  }
}