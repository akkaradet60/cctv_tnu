import 'package:flutter/material.dart';

class MenusCustomS extends StatelessWidget {
  final String SOS;

  final int ss = 0;

  MenusCustomS({
    Key? key,
    required this.SOS,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.orange,
      height: 45,
      width: 365,
      child: SafeArea(
        child: Padding(
          padding: EdgeInsets.all(8.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Padding(
                padding: EdgeInsets.symmetric(horizontal: 8, vertical: 16),
              ),
              Material(
                elevation: 18,
                shadowColor: Colors.grey.withOpacity(0.5),
                child: TextField(
                  decoration: InputDecoration(
                    suffixIcon: IconButton(
                      icon: Icon(Icons.search),
                      onPressed: () =>
                          Navigator.pushNamed(context, '/otopproductssearch'),
                    ),
                    labelText: SOS,
                    fillColor: Colors.white,
                    filled: true,
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
