import 'package:brew_crew/models/brew.dart';
import 'package:brew_crew/screens/home/setings_form.dart';
import 'package:brew_crew/services/auth.dart';
import 'package:brew_crew/services/database.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:brew_crew/screens/home/brew_list.dart';

class Home extends StatelessWidget {

  final AuthService _auth = AuthService();

  @override
  Widget build(BuildContext context) {

    void _showSettingsPanel(){

      showModalBottomSheet(

        context: context, 
        builder: (context){

          return Container(

            padding: EdgeInsets.symmetric(vertical: 20.0, horizontal: 60.0),
            child: SettingsForm(),
          );
        },
      );
    }
    
    return StreamProvider<List<Brew>?>.value(
      
      initialData: null,
      value: DatabaseService(uid: '').brews,

      child: Scaffold(
    
        backgroundColor: Colors.brown[50],
        
        appBar: AppBar(
    
          backgroundColor: Colors.brown[400],
          elevation: 0.0,
    
          title: Text('Brew Crew'),
    
          actions: <Widget>[
    
            FlatButton.icon(
    
              onPressed: () async {
                await _auth.signOut();
              },
              icon: Icon(Icons.person),
              label: Text('Logout'),
            ),

             FlatButton.icon(
    
              onPressed: () async {
                _showSettingsPanel();
              },
              icon: Icon(Icons.settings),
              label: Text('settings'),
            ),
          ],
        ),

        body: Container(

          decoration: BoxDecoration(

            image: DecorationImage(

              image: AssetImage('assets/coffee_bg.png'),
              fit: BoxFit.cover,
            ),
          ),

          child: BrewList()
        ),
      ),
    );
  }
}