import 'package:flutter/material.dart';
import 'package:takeanumber/services/auth.dart';


class AnonymousSignIn extends StatefulWidget {
  @override
  _AnonymousSignInState createState() => _AnonymousSignInState();
}

class _AnonymousSignInState extends State<AnonymousSignIn> {

  final AuthService _auth = AuthService();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[500],
      appBar: AppBar(
        backgroundColor: Colors.teal[400],
        elevation: 0.0,
        title: Text('Anonymous Sign In'),
      ),
      body: Container(
        padding: EdgeInsets.symmetric(vertical: 20.0, horizontal: 50.0),
        child: RaisedButton(
          child: Text('Sign In Anon'),
          onPressed: () async {
            dynamic result = await _auth.signInAnon();
            if(result == null){
              print('Error signing in');
            } else {
              print('Signed In: ${result.uid}');
            }
          },
        ),
      ),
    );
  }
}
