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
        if (!snapshot.hasData) {
          return const Center(child: CircularProgressIndicator());
        } else if (snapshot.hasData) {
          return ListView.builder(
            itemCount: snapshot.data!.docs.length,
            itemBuilder: (context, index) {
              return BrewTile(brew: snapshot.data!.docs[index]);
            },
          );
        } else {
          return Text('no data');
        }
      },
    );
  }
}
