import 'package:cctv_tun/page/models/otoproduct.dart';
import 'package:cctv_tun/shared/theme.dart';

import 'package:cctv_tun/widgets/menus_otoppro.dart';
import 'package:flutter/material.dart';

import 'package:http/http.dart' as http;
import 'dart:convert';

class products_page extends StatefulWidget {
  products_page({Key? key}) : super(key: key);

  @override
  _otopproductsState createState() => _otopproductsState();
}

class _otopproductsState extends State<products_page> {
  List<Data> data = [];
  bool isLoading = true;
  Future<void> getData() async {
    var url = Uri.parse('https://api.codingthailand.com/api/course');
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
        child: isLoading == true
            ? Row(
                children: [
                  Center(
                    child: CircularProgressIndicator(),
                  ),
                ],
              )
            : ListView.separated(
                itemBuilder: (context, index) {
                  return Center(
                    child: Row(
                      children: [
                        InkWell(
                          onTap: () {
                            Navigator.pushNamed(context, '/productshop_page',
                                arguments: {
                                  'id': data[index].id,
                                  'detail': data[index].detail,
                                  'picture': data[index].picture,
                                  'view': data[index].view,
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
                                              color:
                                                  Colors.grey.withOpacity(0.5),
                                              offset: Offset(2, 2),
                                              blurRadius: 7,
                                              spreadRadius: 1.0),
                                          BoxShadow(
                                              color:
                                                  Colors.grey.withOpacity(0.5),
                                              offset: Offset(2, 4),
                                              blurRadius: 7.0,
                                              spreadRadius: 1.0),
                                        ]),
                                    child: Column(
                                      mainAxisAlignment:
                                          MainAxisAlignment.center,
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
                                                      'ชื่อสินค้า: ${data[index].detail}',
                                                      style: primaryTextStyle
                                                          .copyWith(
                                                              fontSize: 18,
                                                              fontWeight:
                                                                  medium),
                                                    ),
                                                  ),
                                                  SizedBox(height: 15),
                                                  Text(
                                                    'ราคาสินค้า : ${data[index].view} บาท',
                                                    style: primaryTextStyle
                                                        .copyWith(
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
                separatorBuilder: (context, index) => Divider(),
                itemCount: data.length),
      ),
    );
  }
}
