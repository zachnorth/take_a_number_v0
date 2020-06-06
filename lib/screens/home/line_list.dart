import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:provider/provider.dart';
import 'package:takeanumber/models/line.dart';
import 'package:takeanumber/screens/home/line_tile.dart';

class LineList extends StatefulWidget {
  @override
  _LineListState createState() => _LineListState();
}

class _LineListState extends State<LineList> {
  @override
  Widget build(BuildContext context) {

    final lines = Provider.of<List<Line>>(context) ?? [];

    return ListView.builder(
      itemCount: lines.length,
      itemBuilder: (context, index) {
        return LineTile(line: lines[index]);
      },
    );
  }
}
