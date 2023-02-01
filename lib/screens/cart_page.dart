import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:search_my_class/constants.dart';
import 'package:search_my_class/screens/product_page.dart';
import 'package:search_my_class/services/firebase_services.dart';
import 'package:search_my_class/widgets/custom_action_bar.dart';

class CartPage extends StatefulWidget {
  @override
  _CartPageState createState() => _CartPageState();
}

class _CartPageState extends State<CartPage> {
  FirebaseServices _firebaseServices = FirebaseServices();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          FutureBuilder<QuerySnapshot>(
            future: _firebaseServices.usersRef
                .doc(_firebaseServices.getUserId())
                .collection("Cart")
                .get(),
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
                    return GestureDetector(
                      onTap: () {
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => ProductPage(
                                productId: document.id,
                              ),
                            ));
                      },
                      child: FutureBuilder(
                        future: _firebaseServices.productRef.doc(document.id).get(),
                        builder: (context, classSnap){
                          if(classSnap.hasError){
                            return Container(
                              child: Center(
                                child: Text("${classSnap.error}"),
                              ),
                            );
                          }
                          if(classSnap.connectionState == ConnectionState.done){
                          Map _classMap = classSnap.data.data();

                          return Padding(
                            padding: const EdgeInsets.symmetric(
                              vertical: 16.0,
                              horizontal: 24.0,
                            ),
                            child: Row(
                              mainAxisAlignment:
                              MainAxisAlignment.start,
                              children: [
                                Container(
                                  width: 90,
                                  height: 90,
                                  child: ClipRRect(
                                    borderRadius:
                                    BorderRadius.circular(8.0),
                                    child: Image.network(
                                      "${_classMap['images'][0]}",
                                      fit: BoxFit.cover,
                                    ),
                                  ),
                                ),
                                Container(
                                  padding: EdgeInsets.only(
                                    left: 16.0,
                                  ),
                                  child: Column(
                                    mainAxisAlignment:
                                    MainAxisAlignment.start,
                                    crossAxisAlignment:
                                    CrossAxisAlignment.start,
                                    children: [
                                      Text(
                                        "${_classMap['classCard']}",
                                        style: TextStyle(
                                            fontSize: 18.0,
                                            color: Colors.black,
                                            fontWeight:
                                            FontWeight.w600),
                                      ),
                                      Padding(
                                        padding: const EdgeInsets
                                            .symmetric(
                                          vertical: 4.0,
                                        ),
                                        child: Text(
                                          "\₹${_classMap['fees']}",
                                          style: TextStyle(
                                              fontSize: 16.0,
                                              color: Theme.of(context)
                                                  .accentColor,
                                              fontWeight:
                                              FontWeight.w600),
                                        ),
                                      ),
                                      Text(
                                        "Batch - ${document.data()['batch']}",
                                        style: TextStyle(
                                            fontSize: 16.0,
                                            color: Colors.black,
                                            fontWeight:
                                            FontWeight.w600),
                                      ),
                                    ],
                                  ),
                                ),
                              ],
                            ),
                          );
                          }
                          return Container(
                            child: Center(
                              child: CircularProgressIndicator(),
                            )
                          );
                          },
                      ),
                    );
                  },
                  ).toList(),
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
            hasBackArrow: true,
            hasBackground: true,
            title: "CART",
          )
        ],
      ),
    );
  }
}
