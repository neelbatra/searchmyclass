import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:search_my_class/constants.dart';
import 'package:search_my_class/screens/product_page.dart';
import 'package:search_my_class/widgets/class_card.dart';
import 'package:search_my_class/widgets/custom_action_bar.dart';

class HomeTab extends StatelessWidget {
  final CollectionReference _productRef =
      FirebaseFirestore.instance.collection("institutes");

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Stack(
        children: [
          FutureBuilder<QuerySnapshot>(
            future: _productRef.get(),
            builder: (context, snapshot) {
              if (snapshot.hasError) {
                return Scaffold(
                  body: Center(
                    child: Text("Error: ${snapshot.error}"),
                  ),
                );
              }

              //***very imp***
              //collection dat ready  to display
              if (snapshot.connectionState == ConnectionState.done) {
                // display the data inside a list view
                return ListView(
                  padding: EdgeInsets.only(
                    top: 110.0,
                    bottom: 12,
                  ),
                  children: snapshot.data.docs.map((document) {
                    return ClassCard(
                      classCard: document.data()['classCard'],
                      imageUrl: document.data()['images'][0],
                      fees: "\₹${document.data()['fees']}",
                      onPressed: () {
                        Navigator.push(context,MaterialPageRoute(builder: (context) => ProductPage(productId: document.id,),),);
                      },
                    );
                  }).toList(),
                );
              }

              //loading State
              return Scaffold(
                body: Center(
                  child: CircularProgressIndicator(),
                ),
              );
            },
          ),
          CustomActBar(
            title: "HOME",
            hasBackArrow: false,
          ),
        ],
      ),
    );
  }
}
