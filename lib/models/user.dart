class User {

  final String uid;

  User({ this.uid });

}

class UserData {

  //potential stream to know how many people currently in line
  //final int numberPeopleInLine;
  final String uid;
  final String name;
  final String sugars;
  final int strength;

  UserData({ this.uid, this.name, this.sugars, this.strength });

}