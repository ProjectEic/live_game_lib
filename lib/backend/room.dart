import 'package:firebase_database/firebase_database.dart';


class Room {

  final String _id;
  String adminId = ""; 
  DatabaseReference? ref;
  Map<String, dynamic> data = {};

  late DatabaseReference myDataRef;

  Room(this._id, {DatabaseReference? lref,  String? adminId}) {
    if (lref == null) {
      ref = FirebaseDatabase.instance.ref("rooms").child(_id);
    } else {
      ref = lref;
    }
    if (adminId != null) {
      ref!.child("admin").set(adminId);
      this.adminId = adminId;
    } else {
      () async {
        this.adminId = (await ref!.child("admin").get()) as String;
      }();
    }

    addDataListener((d) { data = d;});
    () async {
      data = (await ref!.get()).value as Map<String, dynamic>;
    }();
  }

  void addDataListener( void Function(Map<String, dynamic> data)? onValue) {
    ref?.onValue.listen((event) {
      data = event.snapshot.value as Map<String, dynamic>;
      if (onValue != null) {
        onValue(data);
      }
    });
  }

  List<String> get players => ((data["players"]??Map<String, dynamic>()) as Map<String, dynamic>).keys.toList();

  String get id => _id;

  bool isAdmin(String uid) {
    return adminId == uid;
  }

  bool joined(String uid) {
    return (data["players"]??Map<String, dynamic>()).containsKey(uid);
  }

  Future<void> disconnect() async {
    await myDataRef.remove();
  }

  void join(String myName) {
    myDataRef = ref!.child("players").child(myName);
    myDataRef.set(true);
    myDataRef.onDisconnect().remove();
  }
  



}