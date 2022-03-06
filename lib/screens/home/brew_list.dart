import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:ninja_brew_crew/models/brew.dart';
import 'package:ninja_brew_crew/models/user.dart';
import 'package:ninja_brew_crew/screens/home/brew_tile.dart';
import 'package:flutter/material.dart';
import 'package:ninja_brew_crew/shared/loading.dart';
import 'package:provider/provider.dart';

class BrewList extends StatefulWidget {
  const BrewList({Key? key}) : super(key: key);

  @override
  _BrewListState createState() => _BrewListState();
}

class _BrewListState extends State<BrewList> {
  @override
  Widget build(BuildContext context) {
    // final brews = Provider.of<List<Brew>>(context);
    final user = Provider.of<UserModel?>(context);

    return StreamBuilder<QuerySnapshot>(
      stream: FirebaseFirestore.instance
          .collection('brews')
          .doc(user!.uid)
          .collection('items')
          .snapshots(),
      builder: (context, snapshot) {
        //     return snapshot.hasData
        //         ? ListView.builder(
        //             itemCount: snapshot.data!.docs.length,
        //             itemBuilder: (context, index) {
        //               var items =
        //                   snapshot.data!.docs.map((DocumentSnapshot document) {
        //                 return BrewTile(brew: document);
        //               });
        //               return Text('null');
        //             })
        //         : Center(child: CircularProgressIndicator());
        //   },
        // );

        if (!snapshot.hasData) {
          return Center(child: CircularProgressIndicator());
        } else if (snapshot.hasData) {
          var items = snapshot.data!.docs.length;

          // .map((DocumentSnapshot document) {
          //   print(" here >>>  ${document.data()}");
          // });
          print("$items");
          return BrewTile(brew: snapshot.data!.docs[0]);
          // return ListView.builder(
          //   itemCount: items,
          //   itemBuilder: (context, index) {
          //     return BrewTile(brew: snapshot.data!.docs[index]);
          //   },
          // );
        } else {
          // print("error in .....");
          return Text('no data');
        }

        //
        // return snapshot.hasData
        //     ? ListView.builder(
        //         itemCount: 2,
        //         // userSnapshot.data!.docs.length,
        //         itemBuilder: (context, index) {
        //           // DocumentSnapshot userData = snapshot.data!.docs[index];
        //           // print(' >>>>>> $userData');
        //           return Text(' data : >>< ${snapshot.data!.docs[0]}');
        //         })
        //     : Text('hello');
      },
    );
    // return ListView.builder(
    //   itemCount: brews.length,
    //   itemBuilder: (context, index) {
    //     return BrewTile(brew: brews[index]);
    //   },
    // );
  }
}
