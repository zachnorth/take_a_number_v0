import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:takeanumber/screens/waitingWrapper.dart';
import 'package:takeanumber/services/database.dart';
import 'package:takeanumber/shared/loading.dart';
import 'package:takeanumber/services/auth.dart';
import 'package:takeanumber/shared/constants.dart';


class JoinLine extends StatefulWidget {
  @override
  _JoinLineState createState() => _JoinLineState();
}

class _JoinLineState extends State<JoinLine> {

  final AuthService _auth = AuthService();
  bool loading = false;

  String personName = '';
  String storeName = '';


  @override
  Widget build(BuildContext context) {

    return loading ? Loading() : Scaffold(
      backgroundColor: Colors.grey[400],
      appBar: AppBar(
        title: Text('Join New Line'),
        backgroundColor: Colors.teal[400],
      ),
      body: Container(
        child: Column(
          children: <Widget>[
            SizedBox(height: 10.0),
            TextFormField(
              decoration: textInputDecoration,
              validator: (val) => val.isEmpty ? 'Please enter the name of the line you wish to join' : null,
              onChanged: (val) {
                setState(() => storeName = val);
              },
            ),
            SizedBox(height: 5.0),
            TextFormField(
              decoration: textInputDecoration,
              validator: (val) => val.isEmpty ? 'Please enter your name' : null,
              onChanged: (val) {
                setState(() => personName = val);
              },
            ),

            RaisedButton(
              color: Colors.teal[300],
              child: Text('Print Lines'),
              onPressed: () async => Firestore.instance.collection('lines').document(storeName).collection('line').getDocuments().then((myDocuments) {
                print('${myDocuments.documents.length}'.toString());
              }),
            ),

            RaisedButton(
              color: Colors.green[500],
              child: Text('Join Line'),
              onPressed: () async => _joinLineHelper(storeName, personName, context),    //await DatabaseService(uid: personName).addUserToExistingLine(storeName, personName)
            ),
            RaisedButton(
              color: Colors.red[500],
              child: Text('Delet $personName from list'),
              onPressed: () async => Firestore.instance.collection('lines').document(storeName).collection('line').document(personName).delete(),
            )
          ],
        ),
      ),
    );


  }

  void _joinLineHelper(String storeName, String personName, BuildContext context) async {

    dynamic result = await _auth.signInAnon();

    if(result == null){
      print('Error signing in');
    } else {
      print('Signed In');
      print(result.uid);

      await DatabaseService(uid: result.uid).addUserToExistingLine(storeName, personName, result.uid);
    }
    Navigator.of(context).push(
        MaterialPageRoute<void>(
            builder: (BuildContext context) {
              return WaitingWrapper();
            }
        )
    );


  }

}
