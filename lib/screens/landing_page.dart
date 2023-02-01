import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:search_my_class/screens/login_page.dart';
import 'package:search_my_class/constants.dart';
import 'package:search_my_class/screens/home_page.dart';

class LandingPage extends StatelessWidget {
  final Future<FirebaseApp> _initialization = Firebase.initializeApp();

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      future: _initialization,
      builder: (context, snapshot) {
        //If snapshot has error
        if (snapshot.hasError) {
          return Scaffold(
            body: Center(
              child: Text("Error: ${snapshot.error}"),
            ),
          );
        }
        //connection made to firebase- Firebase app
        if (snapshot.connectionState == ConnectionState.done) {
          // StreamBuilder can check the login state live
          return StreamBuilder(
              stream: FirebaseAuth.instance.authStateChanges(),
              builder: (context, streamSnapshot){
                //If streamSnapshot has error
                if (streamSnapshot.hasError) {
                  return Scaffold(
                    body: Center(
                      child: Text("Error: ${streamSnapshot.error}"),
                    ),
                  );
                }

                //connection state active - do the user login check inside the
                //if statement
                if(streamSnapshot.connectionState == ConnectionState.active) {

                  //return LoginPage();

                  // get the user
                  User _user = streamSnapshot.data;
                  if(_user == null) {
                    // user not logged in, head to login
                    return LoginPage();
                  }
                  else{
                    // the user is logged in , head to home page
                    return HomePage();
                  }
                }
                //checking the auth state- loading
                return Scaffold(
                  body: Center(
                    child: Text(
                      "checking authentication...",
                      style: Constants.regularHeading,
                    ),
                  ),
                );
              }
          );
              }



        //connection of firebase project-Loading
        return Scaffold(
          body: Center(
            child: Text(
              "Initialization App...",
              style: Constants.regularHeading,
            ),
          ),
        );
      },
    );
  }
}
