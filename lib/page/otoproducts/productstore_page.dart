import 'package:cctv_tun/page/global/style/global.dart';
import 'package:flutter/material.dart';

class productstore_page extends StatefulWidget {
  productstore_page({Key? key}) : super(key: key);

  @override
  State<productstore_page> createState() => _productstore_pageState();
}

class _productstore_pageState extends State<productstore_page> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        iconTheme: IconThemeData(
          color: ThemeBc.white, //change your color here
        ),
        shadowColor: ThemeBc.white,
        foregroundColor: ThemeBc.white,
        backgroundColor: ThemeBc.background,
        title: Center(child: Text('ค้นหาร้านค้า')),
        actions: <Widget>[
          IconButton(
            icon: Image.asset('assets/logo.png', scale: 15),
            tooltip: 'Show Snackbar',
            onPressed: () {
              ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(content: Text('เราเทศบาลเมืองมหาสารคาม')));
            },
          ),
        ],
      ),
      body: Container(
        color: ThemeBc.background,
        child: ListView(
          children: [
            sso(context),
          ],
        ),
      ),
    );
  }

  Widget sso(BuildContext context) {
    return Container(
      color: ThemeBc.background,
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Container(
          decoration: BoxDecoration(
              color: secondaryTextColor,
              borderRadius: BorderRadius.circular(
                20,
              ),
              boxShadow: [
                BoxShadow(
                    color: Colors.grey.withOpacity(0.5),
                    offset: Offset(2, 2),
                    blurRadius: 7,
                    spreadRadius: 1.0),
                BoxShadow(
                    color: Colors.black.withOpacity(0.5),
                    offset: Offset(2, 4),
                    blurRadius: 7.0,
                    spreadRadius: 1.0),
              ]),
          child: SafeArea(
            child: Padding(
              padding: EdgeInsets.all(8.0),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Padding(
                    padding: EdgeInsets.symmetric(horizontal: 0, vertical: 0),
                  ),
                  TextField(
                    decoration: InputDecoration(
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(
                          20.0,
                        ),
                      ),
                      suffixIcon: IconButton(
                        icon: Icon(Icons.search),
                        onPressed: () =>
                            Navigator.pushNamed(context, '/productstore_page'),
                      ),
                      labelText: 'ค้นหา',
                      fillColor: Colors.white,
                      filled: true,
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
