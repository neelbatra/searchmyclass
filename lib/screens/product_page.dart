import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:search_my_class/constants.dart';
import 'package:search_my_class/services/firebase_services.dart';
import 'package:search_my_class/widgets/batch_number.dart';
import 'package:search_my_class/widgets/custom_action_bar.dart';
import 'package:search_my_class/widgets/image_swipe.dart';

class ProductPage extends StatefulWidget {
  final String productId;

  ProductPage({this.productId});

  @override
  _ProductPageState createState() => _ProductPageState();
}

class _ProductPageState extends State<ProductPage> {

  FirebaseServices _firebaseServices = FirebaseServices();



 // User _user = FirebaseAuth.instance.currentUser;//** no need

  String _selectedBatch = "0";

  Future _addToCart() {
    return _firebaseServices.usersRef
        .doc(_firebaseServices.getUserId())
        .collection("Cart")
        .doc(widget.productId)
        .set({"batch": _selectedBatch});
  }

  Future _addToSaved() {
    return _firebaseServices.usersRef
        .doc(_firebaseServices.getUserId())
        .collection("Saved")
        .doc(widget.productId)
        .set({"batch": _selectedBatch});
  }

  final SnackBar _snackBar = SnackBar(content: Text("Product added to the cart"),);



  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          FutureBuilder(
              future: _firebaseServices.productRef.doc(widget.productId).get(),
              builder: (context, snapshot) {
                if (snapshot.hasError) {
                  return Scaffold(
                    body: Center(
                      child: Text("Error: ${snapshot.error}"),
                    ),
                  );
                }

                if (snapshot.connectionState == ConnectionState.done) {
                  //Firebase document data map
                  Map<String, dynamic> documentData = snapshot.data
                      .data(); //different data and different contextually used

                  //List of images
                  List imageList = documentData['images'];
                  //List of Batches
                  List batchList = documentData['batch'];

                  //set an initial batch
                  _selectedBatch = batchList[0];

                  return ListView(
                    children: [
                      ImageSwipe(
                        imageList: imageList,
                      ),
                      Padding(
                        padding: const EdgeInsets.only(
                            top: 24, left: 24, right: 24, bottom: 8),
                        child: Text(
                          "${documentData['classCard']}" ?? "Product Name",
                          style: TextStyle(
                              fontSize: 22,
                              fontWeight: FontWeight.w600,
                              color: Colors.black),
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.symmetric(
                            vertical: 8, horizontal: 24),
                        child: Text(
                          "${documentData['time open']}" ?? "open time",
                          style: Constants.regularText,
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.symmetric(
                            vertical: 8, horizontal: 24),
                        child: Text(
                          "${documentData['desc']}" ?? "Description",
                          style: Constants.regularText,
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.symmetric(
                            vertical: 8, horizontal: 24),
                        child: Text(
                          "\F\e\e\s\:  \ \₹${documentData['fees']}" ?? "FEES",
                          style: TextStyle(fontSize: 18, color: Colors.red),
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.symmetric(
                            vertical: 8, horizontal: 24),
                        child: Text(
                          "Select Batch",
                          //
                          style: Constants.regularText,
                        ),
                      ),
                      BatchNumber(
                        batchList: batchList,
                        onSelected: (batch){
                          _selectedBatch = batch;
                        },
                      ),
                      Padding(
                        padding: const EdgeInsets.all(24.0),
                        child: Row(
                          children: [
                            GestureDetector(
                              onTap: () async{
                                await _addToSaved();
                                Scaffold.of(context).showSnackBar(_snackBar);
                              },
                              child: Container(
                                width: 65,
                                height: 65,
                                decoration: BoxDecoration(
                                    color: Color(0xFFDCDCDC),
                                    borderRadius: BorderRadius.circular(15)),
                                alignment: Alignment.center,
                                child: Image(
                                  image:
                                      AssetImage("assets/images/tab_saved.png"),
                                  height: 22,
                                ),
                              ),
                            ), //saved classes
                            Expanded(
                              child: GestureDetector(
                                onTap: () async{
                                await _addToCart();
                                  Scaffold.of(context).showSnackBar(_snackBar);
                               // print("product added to cart");
                                },
                                child: Container(
                                  margin: EdgeInsets.only(left: 15),
                                  height: 65,
                                  decoration: BoxDecoration(
                                    color: Color(0xFFE11C37),
                                    borderRadius: BorderRadius.circular(20),
                                    border:
                                        Border.all(color: Colors.black, width: 1),
                                  ),
                                  alignment: Alignment.center,
                                  child: Text(
                                    "ADD TO CART",
                                    style: TextStyle(
                                      color: Colors.white,
                                      fontSize: 22,
                                      fontWeight: FontWeight.w600,
                                    ),
                                  ),
                                ),
                              ),
                            ), //add to cart
                          ],
                        ),
                      ) //lower functions
                    ],
                  );
                }

                //loading State
                return Scaffold(
                  body: Center(
                    child: CircularProgressIndicator(),
                  ),
                );
              }),
          CustomActBar(
            hasBackArrow: true,
            hasTitle: false,
            hasBackground: true,
          ),
        ],
      ),
    );
  }
}
/* child: Center(
              child: Text("Institute Page"),
            ),
          ),*/
