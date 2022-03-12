// ignore_for_file: prefer_const_constructors

import 'package:ninja_brew_crew/models/brew.dart';
import 'package:ninja_brew_crew/models/user.dart';
import 'package:ninja_brew_crew/screens/home/brew_list.dart';
import 'package:ninja_brew_crew/services/auth.dart';
import 'package:ninja_brew_crew/services/database.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class Home extends StatelessWidget {
  final AuthService _auth = AuthService();

  Home({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final user = Provider.of<UserModel?>(context);
    return
        // StreamProvider<List<Brew>>.value(
        //   value: DatabaseService().brews,
        //   initialData: const [],
        //   child:
        Scaffold(
      backgroundColor: Colors.brown[50],
      appBar: AppBar(
        title: Text('Brew Crew'),
        backgroundColor: Colors.brown[400],
        elevation: 0.0,
        actions: <Widget>[
          FlatButton.icon(
            icon: Icon(Icons.person),
            label: Text('logout'),
            onPressed: () async {
              await _auth.signOut();
            },
          ),
          FlatButton.icon(
            icon: Icon(Icons.add),
            label: Text('add'),
            onPressed: () async {
              await DatabaseService(uid: user!.uid)
                  .updateUserData('0', 'new crew member', 100);
            },
          )
        ],
      ),
      body: BrewList(),
      // ),
    );
  }
}
