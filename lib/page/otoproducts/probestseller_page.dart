import 'package:cctv_tun/page/global/global.dart';
import 'package:cctv_tun/page/models/otoproduct.dart';
import 'package:cctv_tun/shared/theme.dart';

import 'package:flutter/material.dart';

import 'package:http/http.dart' as http;
import 'dart:convert';

class probestseller_page extends StatefulWidget {
  probestseller_page({Key? key}) : super(key: key);

  @override
  _otopproductsState createState() => _otopproductsState();
}

class _otopproductsState extends State<probestseller_page> {
  List<Data> data = [];
  bool isLoading = true;
  Future<void> getData() async {
    var url = Uri.parse(
        'https://bc-official.com/api/app_nt/api/app/otop/best-seller-product/restful/?product_app_id=${Global.app_id}');
    var response = await http.get(url);
    if (response.statusCode == 200) {
      // print(json.decode(response.body));
      //นำ json ใส่ที่โมเมล product
      final product paroduct = product.fromJson(json.decode(response.body));
      // print(paroduct.data);
      setState(() {
        data = paroduct.data!;
        isLoading = false;
      });
    } else {
      setState(() {
        isLoading = false;
      });
      print('error 400');
    }
  }

  @override
  void initState() {
    super.initState();
    getData();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      bottomNavigationBar: customBottomNav(),
      appBar: AppBar(
        title: const Text('สินค้า OTOP'),
        actions: <Widget>[
          IconButton(
            icon: Image.asset('assets/logo.png', scale: 15),
            tooltip: 'Show Snackbar',
            onPressed: () {
              ScaffoldMessenger.of(context).showSnackBar(
                  const SnackBar(content: Text('เราเทศบาลเมืองมหาสารคาม')));
            },
          ),
        ],
      ),
      body: Container(
        decoration: BoxDecoration(
            gradient: LinearGradient(
                colors: [Colors.pinkAccent, Colors.orangeAccent],
                begin: Alignment.topRight,
                end: Alignment.bottomLeft)),
        child: ListView.builder(
            scrollDirection: Axis.horizontal,
            itemBuilder: (context, index) {
              return Center(
                child: Row(
                  children: [
                    InkWell(
                      onTap: () {
                        Navigator.pushNamed(context, '/productshop_page',
                            arguments: {
                              /*    'id': data[index].id,
                              'detail': data[index].detail,
                              'picture': data[index].picture,
                              'view': data[index].view,*/
                            });
                      },
                      child: Container(
                        margin: EdgeInsets.only(top: 20, bottom: 0),
                        child: SingleChildScrollView(
                          scrollDirection: Axis.horizontal,
                          child: Row(
                            children: [
                              SizedBox(width: defaultMargin),
                              Container(
                                height: 400,
                                width: 365,
                                decoration: BoxDecoration(
                                    color: secondaryTextColor,
                                    borderRadius: BorderRadius.circular(
                                      24,
                                    ),
                                    boxShadow: [
                                      BoxShadow(
                                          color: Colors.grey.withOpacity(0.5),
                                          offset: Offset(2, 2),
                                          blurRadius: 7,
                                          spreadRadius: 1.0),
                                      BoxShadow(
                                          color: Colors.grey.withOpacity(0.5),
                                          offset: Offset(2, 4),
                                          blurRadius: 7.0,
                                          spreadRadius: 1.0),
                                    ]),
                                child: Column(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    Column(
                                      children: [
                                        Image.network(
                                          '${data[index].picture}',
                                          width: 200,
                                        ),
                                        SizedBox(height: 15),
                                        Container(
                                          width: 340,
                                          color: Colors.grey[200],
                                          height: 150,
                                          child: Column(
                                            children: [
                                              SizedBox(height: 15),
                                              Container(
                                                width: 300,
                                                child: Text(
                                                  'ชื่อสินค้า: ${data[index].}',
                                                  style:
                                                      primaryTextStyle.copyWith(
                                                          fontSize: 18,
                                                          fontWeight: medium),
                                                ),
                                              ),
                                              SizedBox(height: 15),
                                              Text(
                                                'ราคาสินค้า : ${data[index].view} บาท',
                                                style:
                                                    primaryTextStyle.copyWith(
                                                        fontSize: 20,
                                                        fontWeight: medium),
                                              ),
                                            ],
                                          ),
                                        )
                                      ],
                                    )
                                  ],
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              );
            },
            // separatorBuilder: (context, index) => Divider(),
            itemCount: data.length),
      ),
    );
  }

  Widget customBottomNav() {
    return Container(
      height: 100,
      child: BottomAppBar(
          shape: CircularNotchedRectangle(),
          notchMargin: 5,
          color: Colors.pink,
          clipBehavior: Clip.antiAlias,
          child: Row(
            children: [
              Container(
                margin: EdgeInsets.only(
                  top: 5,
                  left: 50,
                ),
                width: 80,
                child: Image.network(
                    'https://district.cdd.go.th/bangkruai/wp-content/uploads/sites/308/2021/02/logo_img1599704122.png'),
              ),
              Container(
                padding: EdgeInsets.symmetric(horizontal: 10),
                child: Text(
                  'สินค้าขายดีอาทิตย์นี้',
                  style: primaryTextStyle.copyWith(
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                      color: Colors.white),
                ),
              )
            ],
          )),
    );
  }
}
