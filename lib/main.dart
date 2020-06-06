
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:provider/provider.dart';
import 'package:takeanumber/models/user.dart';
import 'package:takeanumber/screens/joinLineWrapper.dart';
import 'dart:async';
import 'package:takeanumber/screens/wrapper.dart';
import 'package:takeanumber/services/auth.dart';
import 'package:takeanumber/shared/loading.dart';
import 'screens/anonymous_signin_wrapper.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Take A Number',
      theme: ThemeData(
        primarySwatch: Colors.teal,
        brightness: Brightness.dark,
        primaryColorBrightness: Brightness.dark,
      ),
      home: MyHomePage(title: 'Take A Number Home Page'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  MyHomePage({Key key, this.title}) : super(key: key);

  final String title;

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {

  Future <String> _numPeople;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
        backgroundColor: Colors.teal,
        brightness: Brightness.dark,
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[


            RaisedButton(
              shape: RoundedRectangleBorder(
                  borderRadius: new BorderRadius.circular(18.0),
                  side: BorderSide(color: Colors.black)
              ),
              onPressed: () =>  _wrapperHelper(context),
              child: Text(
                'Start A Line',
                style: TextStyle(fontSize: 30, color: Colors.white)
              ),
            ),
            RaisedButton(
              shape: RoundedRectangleBorder(
                  borderRadius: new BorderRadius.circular(18.0),
                  side: BorderSide(color: Colors.black)
              ),
                onPressed: () => _joinLineHelper(this.context),  //_joinNewLine(this.context)
              child: Text(
                'Join A Line',
                  style: TextStyle(fontSize: 30, color: Colors.white)
              ),
            ),
            RaisedButton(
              onPressed: () async => Firestore.instance.collection('lines').getDocuments().then((myDocuments) {
                print('${myDocuments.documents.length}');
              }),    //_streamTestHelper(context)
            ),
            RaisedButton(
              color: Colors.black,
              child: Text('Anonymous Sign In'),
              onPressed: () {
                Navigator.of(context).push( MaterialPageRoute<void>(
                  builder: (BuildContext context) {
                    return AnonymousSignInWrapper();
                  }
                ));
              }
            )
          ],
        ),
      ),
       // This trailing comma makes auto-formatting nicer for build methods.
    );
  }

}
  Widget _buildListItem(BuildContext context, DocumentSnapshot document) {
    return ListTile(
      title: Row(
        children: <Widget>[
          Expanded(
            child: Text(document['firstname']),
          ),
          Expanded(
            child: Text(document['lastname']),
          ),
          Expanded(
            child: Text(document['username']),
          ),
          Expanded(
            child: Text(document['password']),
          ),
        ],
      ),
    );
  }


  void _streamTestHelper(BuildContext context) {
    Navigator.of(context).push(
      MaterialPageRoute<void>(
        builder: (BuildContext context) {
          return Scaffold(
            appBar: AppBar(
              title: Text('Display Line'),
            ),
            body: StreamBuilder(
              stream: Firestore.instance.collection('lines').snapshots(),
              builder: (context, snapshot) {
                if(!snapshot.hasData) return Loading();
                return Text(helper().toString());
              },
            ),
          );
        }
      )
    );
  }

  Future<String> helper() async {
    String result = await Firestore.instance.collection('lines').getDocuments().then((myDocuments) {
      return '${myDocuments.documents.length}'.toString();
    });

    return result;
  }

  void _joinLineHelper(BuildContext context) {
    Navigator.of(context).push(
      MaterialPageRoute<void>(
        builder: (BuildContext context) {
          return StreamProvider<User>.value(
              value: AuthService().user,
              child: MaterialApp(
                home: JoinLineWrapper(),
              ),
          );
        }
      )
    );
  }


  void _wrapperHelper(BuildContext context) {
    Navigator.of(context).push(
      MaterialPageRoute<void>(
        builder: (BuildContext context) {
          return StreamProvider<User>.value(
              value: AuthService().user,
              child: MaterialApp(
                home: Wrapper(),
              )
          );
        }
      )
    );
  }

  void _joinNewLine(BuildContext context) {
    Navigator.of(context).push(
      MaterialPageRoute<void>(
        builder: (BuildContext context) {
          return Scaffold(
            appBar: AppBar(
              title: Text('Join New Line'),
            ),
            body: StreamBuilder(
              stream: Firestore.instance.collection('namesnshit').snapshots(),  //$lineName instead of 'namesnshit'
              builder: (context, snapshot) {
                if (!snapshot.hasData) return Loading();
                return ListView.builder(
                  itemExtent: 80.0,
                  itemCount: snapshot.data.documents.length,
                  itemBuilder: (context, index) =>
                      _buildListItem(context, snapshot.data.documents[index]),
                );
              }
            ),
          );
        }
      )
    );
  }

  void _showAccount(BuildContext context) {
    Navigator.of(context).push(
      MaterialPageRoute<void>(
        builder: (BuildContext context) {
          return Scaffold(
            appBar: AppBar(
            title: Text('Account Page'),
            )
          );
        }
      )
    );
  }


