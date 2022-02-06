import 'dart:convert';

import 'package:brew_crew/models/brew.dart';
import 'package:brew_crew/models/myuser.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class DatabaseService{

  final String uid;
  DatabaseService({required this.uid});

  //collection reference
  final CollectionReference brewCollection = FirebaseFirestore.instance.collection('brews');

  Future updateUserData(String sugars, String name, int strength) async {

    return await brewCollection.doc(uid).set({
      'sugars': sugars,
      'name': name,
      'strength': strength,
    });
  }

  //brew list from snapshot
  List<Brew> _brewListFromSnapshot(QuerySnapshot snapshot){

    return snapshot.docs.map((doc){

      var doc_obj = jsonDecode(jsonEncode(doc.data()!));
      
      return Brew(
        name: doc_obj['name'] ?? '', 
        sugars: doc_obj['sugars'] ?? '0', 
        strength: doc_obj['strength'] ?? 0,
      );
    }).toList();
  }

    //get brews stream
  Stream<List<Brew>> get brews{
    return brewCollection.snapshots()
    .map(_brewListFromSnapshot);
  }

  //userData from snapshot
  UserData _userDataFromSnapshot(DocumentSnapshot snapshot){

    var doc_obj = jsonDecode(jsonEncode(snapshot.data()!));
      
    return UserData(
      uid: uid,
      name: doc_obj['name'], 
      sugars: doc_obj['sugars'], 
      strength: doc_obj['strength'],
    );
  }

  //get userdoc stream
  Stream<UserData> get userData{
    return brewCollection.doc(uid).snapshots()
    .map(_userDataFromSnapshot);
  }
}