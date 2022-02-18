import 'package:flutter/material.dart';

class bk extends StatefulWidget {
  bk({Key? key}) : super(key: key);

  @override
  _bkState createState() => _bkState();
}

class _bkState extends State<bk> {
  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
          gradient: LinearGradient(
              colors: [Colors.white, Colors.white],
              begin: Alignment.topRight,
              end: Alignment.bottomLeft)),
    );
  }
}
