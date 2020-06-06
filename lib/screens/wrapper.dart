import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:takeanumber/screens/authenticate/authenticate.dart';
import 'package:takeanumber/screens/home/home.dart';
import 'package:takeanumber/models/user.dart';

class Wrapper extends StatelessWidget {
  @override
  Widget build(BuildContext context) {

    final user = Provider.of<User>(context);

    if (user == null) {
      return Authenticate();
    } else {
      return Home();
    }
  }
}