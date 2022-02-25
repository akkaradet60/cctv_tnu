import 'package:flutter/material.dart';
import 'package:flutter_facebook_auth/flutter_facebook_auth.dart';
import 'package:flutter_neumorphic/flutter_neumorphic.dart';

class sss extends StatefulWidget {
  sss({Key? key}) : super(key: key);

  @override
  State<sss> createState() => _sssState();
}

class _sssState extends State<sss> {
  @override
  Widget build(BuildContext context) {
    bool _isLoggedIn = false;
    Map _userObj = {};

    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(),
      body: Stack(
        children: [
          Image.network(
            'https://photo.maahalai.com/wp-content/uploads/2018/02/PicsArt-Full-Moon.jpg',
            width: double.infinity,
            height: MediaQuery.of(context).size.height,
            fit: BoxFit.cover,
          ),
          Container(
              width: MediaQuery.of(context).size.width - 100,
              height: 350,
              decoration: BoxDecoration(
                  color: Colors.black45,
                  borderRadius: BorderRadius.circular(10)))
        ],
      ),
    );
  }
}
