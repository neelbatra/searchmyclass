import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:search_my_class/constants.dart';

class AccountTab extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return ListView(
      children: [
        Container(
          width: 250,
          height: 250,
          margin: EdgeInsets.only(top: 100, left: 100, right: 100, bottom: 100),
          decoration: BoxDecoration(
              color: Color(0xFFDCDCDC),
              borderRadius: BorderRadius.circular(50)),
          alignment: Alignment.center,
          child: Image(
            image: AssetImage("assets/images/tab_accountuser.png"),
          ),
        ),
        Container(
          alignment: Alignment.center,
          child: Text(
            "Hi User",
            style: Constants.boldHeading2,
          ),
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              " Log Out    ",
              style: Constants.regularHeading,
            ),
            GestureDetector(
              onTap: (){
                FirebaseAuth.instance.signOut();
              },
              child: Container(
                child: Image(
                  image: AssetImage("assets/images/tab_logout.png"),
                ),
              ),
            )
          ],
        ),
      ],
    );
  }
}
