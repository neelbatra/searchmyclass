import 'package:flutter/material.dart';
import 'package:search_my_class/constants.dart';
import 'package:search_my_class/screens/product_page.dart';

class ClassCard extends StatelessWidget {
  final String productId;
  final Function onPressed;
  final String imageUrl;
  final String classCard;
  final String fees;
  ClassCard({this.productId,this.onPressed,this.imageUrl,this.classCard,this.fees});
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onPressed, /*() {
        Navigator.push(context, MaterialPageRoute(
          builder: (context) => ProductPage(productId: productId,),
        ));
      },*/
      child: Container(
        height: 350,
        margin: EdgeInsets.symmetric(
          vertical: 12,
          horizontal: 25,
        ),
        //clipping the image in a widget
        child: Stack(
          children: [
            Container(
              height: 350,
              child: ClipRRect(
                borderRadius: BorderRadius.circular(20),
                child: Image.network(
                  "$imageUrl",
                  //"${document.data()['images'][0]}",
                  fit: BoxFit.cover,
                ),
              ),
            ),
            Positioned(
              bottom: 0,
              left: 0,
              right: 0,
              child: Padding(
                padding: const EdgeInsets.all(15.0),
                child: Row(
                  mainAxisAlignment:
                  MainAxisAlignment.spaceBetween,
                  children: [
                    Container(
                      height: 42.0,
                      width: 240,
                      decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(15),
                          border: Border.all(
                              color: Colors.black, width: 1.0)),
                      alignment: Alignment.center,
                      child: Text(
                        classCard,
                        //document.data()['classCard'] ?? " Institute Name: ",
                        style: Constants.regularText,
                      ),
                    ),
                    Container(
                      height: 42.0,
                      width: 70,
                      decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(15),
                          border: Border.all(
                              color: Colors.black, width: 1.0)),
                      alignment: Alignment.center,
                      child: Text(
                        fees,
                       // "\₹${document.data()['fees']}" ?? " Fees: ",
                        style: TextStyle(
                          fontWeight: FontWeight.w900,
                          fontSize: 16.0,
                          color: Colors
                              .red, //Theme.of(context).accentColor,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
        //child: Text("Institute Name: ${document.data()['classCard']}"),
      ),
    );
    ;
  }
}
