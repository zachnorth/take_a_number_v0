import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:takeanumber/models/line.dart';
import 'package:takeanumber/models/user.dart';


class DatabaseService {

  final String uid;
  final String lineName;
  DatabaseService({ this.uid, this.lineName });

  //collection reference
  final CollectionReference currentLines = Firestore.instance.collection('lines');    // /Costco/line1


  Future updateUserData(String sugars, String name, int strength) async {
    //Potentially where i have to look up stores by a name (uid)
    //pass storeName to .document(storeName) to create a new line with the document name storeName
    return await currentLines.document(uid).setData({
      'sugars': sugars,
      'name': name,
      'strength': strength,
    });
  }

  Future addUserToExistingLine(String storeName, String userName, String uid) async {

    dynamic result = await currentLines.document(storeName).collection('line').document(userName).get();
    if(!result.exists) {
      return await currentLines.document(storeName).collection('line').document(userName).setData({
        'name': userName,
        'time': DateTime.now(),
        'uid': uid
      });
    } else {
      print('User $userName Already exists');
    }

  }

  //list list from snapshot
  List<Line> _lineListFromSnapshot(QuerySnapshot snapshot) {
    return snapshot.documents.map((doc) {
      return Line(
        name: doc.data['name'] ?? '',
        sugars: doc.data['sugars'] ?? '0',
        strength: doc.data['strength'] ?? 0,
      );
    }).toList();
  }

  //user data from snapshot
  UserData _userDataFromSnapshot(DocumentSnapshot snapshot) {
    return UserData(
      uid: uid,
      name: snapshot.data['name'],
      sugars: snapshot.data['sugars'],
      strength: snapshot.data['strength']
    );
  }


  //get lines stream
  Stream<List<Line>> get lines {
    return currentLines.snapshots()
    .map(_lineListFromSnapshot);
  }

  //get user doc stream
  Stream<UserData> get userData {
    return currentLines.document(uid).snapshots()
    .map(_userDataFromSnapshot);
  }

}