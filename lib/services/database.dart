import 'package:ninja_brew_crew/models/brew.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:ninja_brew_crew/models/user.dart';
import 'package:provider/provider.dart';

class DatabaseService {
  final String? uid;
  DatabaseService({this.uid});

  // collection reference
  final CollectionReference brewCollection =
      FirebaseFirestore.instance.collection('brews');
// .collection('items').doc()
// Firestore.instance.collection('path').document("documentPath").collection('subCollectionPath').setData({});
  Future<void> updateUserData(String sugars, String name, int strength) async {
    return await brewCollection.doc(uid).collection('items').doc().set({
      'sugars': sugars,
      'name': name,
      'strength': strength,
    });
  }

  // brew list from snapshot
  List<Brew> _brewListFromSnapshot(QuerySnapshot snapshot) {
    return snapshot.docs.map((doc) {
      //print(doc.data);
      return Brew(
          name: doc.get('name') ?? '',
          strength: doc.get('strength') ?? 0,
          sugars: doc.get('sugars') ?? '0');
    }).toList();
  }

  // get brews stream
  Stream<List<Brew>> get brews {
    // var resultsub;
    // brewCollection
    //     .doc('NqPY2vndGBWTfPDhAOiZMPVnJ8C2')
    //     .collection('items')
    //     .snapshots()
    //     .map((snapshot) {
    //   snapshot.docs.map((doc) {
    //     // resultsub = doc.get;
    //   });
    // });
    // print('here <<<<<:>>>>> $resultsub');
    return brewCollection
        .doc('NqPY2vndGBWTfPDhAOiZMPVnJ8C2')
        .collection('items')
        .snapshots()
        .map(_brewListFromSnapshot);
  }
  // brewCollection.snapshots()
  //    .map(_brewListFromSnapshot);

  // .document("horlaz229@gmail.com"). collection('Wallet').getDocuments()
}
