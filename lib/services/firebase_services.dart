import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

class FirebaseServices {
  FirebaseAuth _firebaseServices = FirebaseAuth.instance;
  FirebaseFirestore _firebaseFirestore = FirebaseFirestore.instance;

  String getUserId() {
    return _firebaseServices.currentUser.uid;
  }

  final CollectionReference productRef =
      FirebaseFirestore.instance.collection("institutes");

  final CollectionReference usersRef = FirebaseFirestore.instance.collection(
      "Users"); // logic : user-> user ID (document)->cart->productId(document)

}
