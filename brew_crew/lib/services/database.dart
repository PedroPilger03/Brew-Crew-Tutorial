import 'package:brew_crew/models/brew.dart';
import 'package:brew_crew/models/coffee_user.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class DatabaseService {

  final String? uid;
  DatabaseService ({ this.uid });

  //collection reference
  final CollectionReference brewCollection = FirebaseFirestore.instance.collection('brews');

  Future updateUserData(String sugars, String name, int strength) async {
    return await brewCollection.doc(uid).set({
      'sugars': sugars,
      'name': name,
      'strenght': strength,
    });
  }

  // brew list from snapshot
  List<Brew> _brewListFromSnapshot(QuerySnapshot snapshot) {
    return snapshot.docs.map((doc){
      return Brew(
        name: doc.get('name') ?? '',
        strenght: doc.get('strenght') ?? '0',
        sugars: doc.get('sugars') ?? 0,
        
      );
    }).toList();
  }

  // CoffeeUserData from snapshot
  CoffeeUserData _coffeeUserDataFromSnapshot(DocumentSnapshot snapshot) {
    Map<String, dynamic> data = snapshot.data()! as Map<String, dynamic>;

    return CoffeeUserData(
      uid: data['uid'],
      name: data['name'],
      sugars: data['sugars'],
      strenght: data['strenght'],
    );
  }

  // get brews stream
  Stream<List<Brew>> get brews {
    return brewCollection.snapshots().map(_brewListFromSnapshot);
  }

  //get user doc stream
  Stream<CoffeeUserData> get userData {
    return brewCollection.doc(uid).snapshots()
      .map(_coffeeUserDataFromSnapshot);
  }
}