import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:search_my_class/constants.dart';
import 'package:search_my_class/screens/product_page.dart';
import 'package:search_my_class/services/firebase_services.dart';
import 'package:search_my_class/widgets/class_card.dart';
import 'package:search_my_class/widgets/custom_input.dart';

class SearchTab extends StatefulWidget {
  @override
  _SearchTabState createState() => _SearchTabState();
}

class _SearchTabState extends State<SearchTab> {
  FirebaseServices _firebaseServices = FirebaseServices();

  String _searchString = "";

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Stack(
        children: [
          if (_searchString.isEmpty)
            Center(
              child: Container(
                child: Text(
                  "Search Results",
                  style: Constants.regularHeading,
                ),
              ),
            )
          else
            FutureBuilder<QuerySnapshot>(
              future: _firebaseServices.productRef
                  .orderBy("search_string")
                  .startAt([_searchString]).endAt(
                      ["$_searchString\uf8ff"]).get(),
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
                      top: 128.0,
                      bottom: 12,
                    ),
                    children: snapshot.data.docs.map((document) {
                      return ClassCard(
                        classCard: document.data()['classCard'],
                        imageUrl: document.data()['images'][0],
                        fees: "\₹${document.data()['fees']}",
                        onPressed: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => ProductPage(
                                productId: document.id,
                              ),
                            ),
                          );
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
          Padding(
            padding: const EdgeInsets.only(top: 45),
            child: CustomInput(
              hintText: "Search Here...",
              onSubmitted: (value) {
                setState(
                  () {
                    _searchString = value.toLowerCase();
                  },
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}
