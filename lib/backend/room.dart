import 'package:firebase_database/firebase_database.dart';


class Room {

  final String _id;
  String adminId = ""; 
  DatabaseReference? ref;
  Map<String, dynamic> data = {};

  Room(this._id, {DatabaseReference? lref}) {
    if (lref == null) {
      ref = FirebaseDatabase.instance.ref("rooms").child(_id);
    } else {
      ref = lref;
    }
    adminId = ref!.child("admin").get() as String;
    addDataListener((d) { data = d;});
  }

  void addDataListener( void Function(Map<String, dynamic> data)? onValue) {
    ref?.onValue.listen((event) {
      data = event.snapshot.value as Map<String, dynamic>;
      if (onValue != null) {
        onValue(data);
      }
    });
  }

  String get id => _id;

  bool isAdmin(String uid) {
    return adminId == uid;
  }

  void join(String myName) {
    ref!.child("players").child(myName).set(true);


  }
  



}