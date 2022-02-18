import 'package:flutter/material.dart';
import 'package:flutter_facebook_auth/flutter_facebook_auth.dart';

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
      body: Container(
        child: _isLoggedIn
            ? Column(
                children: [
                  // Image.network(_userObj["picture"]["data"]["url"]),
                  Text(_userObj["name"]),
                  Text(_userObj["email"]),

                  TextButton(
                      onPressed: () {
                        setState(() {
                          _isLoggedIn = false;
                          _userObj = {};
                        });
                      },
                      child: Text('logour'))
                ],
              )
            : Center(
                child: Column(
                  children: [
                    ElevatedButton(
                      child: Text('ghame'),
                      onPressed: () {
                        FacebookAuth.instance.login(permissions: [
                          "public_profile",
                          "email"
                        ]).then((value) {
                          FacebookAuth.instance.getUserData().then((userData) {
                            setState(() {
                              _isLoggedIn = true;
                              _userObj = userData;
                            });
                          });
                        });
                      },
                    ),
                  ],
                ),
              ),
      ),
    );
  }
}
