import 'package:flutter/material.dart';
import 'package:search_my_class/constants.dart';

class BatchNumber extends StatefulWidget {
  final List batchList;
  final Function(String) onSelected;
  BatchNumber({this.batchList, this.onSelected});
  @override
  _BatchNumberState createState() => _BatchNumberState();
}

class _BatchNumberState extends State<BatchNumber> {

  int _selectedBatch = 0;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(left:20.0,top: 10, bottom: 6),
      child: Row(
        children: [
          for(var i=0;i<widget.batchList.length;i++ )
            GestureDetector(
              onTap: () {
                widget.onSelected("${widget.batchList[i]}");
                setState(() {
                  _selectedBatch = i;
                });
              },
              child: Container(
                alignment: Alignment.center,
                margin: EdgeInsets.symmetric(
                  horizontal: 4.0
                ),
                width: 100,
                height: 50,
                decoration: BoxDecoration(
                  color: _selectedBatch == i ? Color(0xFFE11C37) : Color(0xFFE8E1E7)  ,
                      borderRadius: BorderRadius.circular(10.0),
                  border: Border.all(color: Colors.black,width: 1)
                ),
                child: Text(
                  "${widget.batchList[i]}",
                  style: TextStyle(
                  fontWeight: FontWeight.w800,
                    color: _selectedBatch == i ? Colors.white : Colors.black,
                    fontSize: 16.0
                ),),
              ),
            )
        ],
      ),
    );
  }
}
