import 'package:carousel_slider/carousel_slider.dart';
import 'package:cctv_tun/page/global/global.dart';
import 'package:cctv_tun/page/global/style/global.dart';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_neumorphic/flutter_neumorphic.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class productshop_page extends StatefulWidget {
  productshop_page({Key? key}) : super(key: key);

  @override
  _productshop_page createState() => _productshop_page();
}

class _productshop_page extends State<productshop_page> {
  var productt;
  var detail;
  bool isLoading = true;
  late Map<String, dynamic> imgSlide;

  int _currentIndex = 0;
  Future<Map<String, dynamic>> getDataSlide() async {
    var url = (Global.urlWeb +
        'api/app/otop/product/image/restful/?producti_product_id=${productt['productiproductid']}');
    var response = await http.get(Uri.parse(url), headers: {
      'Authorization':
          'Bearer ${Global.token ?? "eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJ1c2VybmFtZSI6IjFAZ21haWwuY29tIiwiZXhwIjoxNjcxNTY2NjU4fQ.uSP6DuFYLScksvlgYZbHPEVG8FaQYGZjk37IZoOlGbg"}'
    });

    if (response.statusCode == 200) {
      imgSlide = json.decode(response.body);

      // print(imgSlide['data'].length);
      return imgSlide;
    } else {
      throw Exception('$response.statusCode');
    }
  }

  var _counter = 1;
  var _product = int.parse('0');
  var _product1 = int.parse('0');

  /* void _incrementCounter() {
    setState(() {
      _counter++;
      _product = _product + _product1;
    });
  }*/

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    void _incrementCounter() {
      _product1 = int.parse('${productt['productPrice']}');
      setState(() {
        _counter++;
        _product = _product + _product1;
      });
    }

    void _incrementCounterp() {
      setState(() {
        _product1 = int.parse('${productt['productPrice']}');
        _counter--;
        _product = _product - _product1;
        if (_counter < 0) {
          _counter = 0;
        }
        if (_product < 0) {
          _product = 0;
        }
      });
    }

    print(_product1);
    productt = ModalRoute.of(context)!.settings.arguments;
    return Scaffold(
        appBar: AppBar(
          iconTheme: IconThemeData(
            color: ThemeBc.white, //change your color here
          ),
          shadowColor: ThemeBc.white,
          foregroundColor: ThemeBc.white,
          backgroundColor: ThemeBc.black,
          title: Text('สินค้า'),
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
          decoration: BoxDecoration(
              gradient: LinearGradient(
                  colors: [Colors.pinkAccent, Colors.orangeAccent],
                  begin: Alignment.topRight,
                  end: Alignment.bottomLeft)),
          child: Padding(
            padding: EdgeInsets.all(10),
            child: Card(
              child: ListView(
                children: [
                  Container(
                    decoration: BoxDecoration(
                        gradient: LinearGradient(
                            colors: [Colors.pinkAccent, Colors.orangeAccent],
                            begin: Alignment.topRight,
                            end: Alignment.bottomLeft)),
                    child: Column(
                      children: [
                        Card(
                          child: Column(
                            children: [
                              Container(
                                height: 300,
                                child: FutureBuilder<Map<String, dynamic>>(
                                  future: getDataSlide(),
                                  builder: (context, snapshot) {
                                    if (snapshot.hasData) {
                                      // return ListView.separated(
                                      //     itemBuilder: (context, index) {
                                      // return Text('3232');
                                      return CarouselSlider.builder(
                                        itemCount:
                                            snapshot.data!['data'].length,
                                        options: CarouselOptions(
                                          autoPlay: true,
                                          enlargeCenterPage: true,
                                          viewportFraction: 0.9,
                                          aspectRatio: 2.0,
                                          initialPage: 2,
                                          onPageChanged: (index, reason) {
                                            setState(
                                              () {
                                                _currentIndex = index;
                                              },
                                            );
                                          },
                                        ),
                                        itemBuilder: (BuildContext context,
                                                int item, int pageViewIndex) =>

                                            // Text('${snapshot.data!['data'][item]['blog_id']}');
                                            //     Container(
                                            //   child: Center(child: Text(item.toString())),
                                            //   color: Colors.green,
                                            // ),
                                            NeumorphicButton(
                                          style: NeumorphicStyle(
                                            shape: NeumorphicShape.flat,
                                            // boxShape:
                                            //     NeumorphicBoxShape.roundRect(BorderRadius.circular(50)),
                                            // boxShape: NeumorphicBoxShape.circle(),
                                            color: Colors.white,
                                          ),
                                          padding: EdgeInsets.all(0),
                                          child: Card(
                                            margin: EdgeInsets.only(
                                              top: 10.0,
                                              bottom: 10.0,
                                            ),
                                            elevation: 6.0,
                                            // shadowColor: Colors.redAccent,
                                            // shape: RoundedRectangleBorder(
                                            //     // borderRadius: BorderRadius.circular(30.0),
                                            //     ),
                                            child: ClipRRect(
                                              borderRadius: BorderRadius.all(
                                                Radius.circular(3.0),
                                              ),
                                              child: Stack(
                                                children: <Widget>[
                                                  Image.network(
                                                    productt[
                                                        'productiPathName'],
                                                    fit: BoxFit.cover,
                                                    width: double.infinity,
                                                  ),
                                                ],
                                              ),
                                            ),
                                          ),
                                        ),
                                      );
                                    } else if (snapshot.hasError) {
                                      return Center(
                                          child: Text(
                                              'เกิดข้อผิดพลาดจาก Server ${snapshot.error}'));
                                    }

                                    return Center(
                                        child: CircularProgressIndicator());
                                  },
                                ),
                              ),
                            ],
                          ),
                        ),
                        Container(
                          child: Card(
                            child: Container(
                              height: 600,
                              width: 400,
                              child: Column(
                                children: [
                                  Container(
                                    color: Colors.orange,
                                    child: Row(
                                      children: [
                                        Icon(
                                          Icons.shopping_cart_rounded,
                                          size: 40,
                                        ),
                                        Text(
                                          '   ศูนย์แสดงสินค้าโอทอป',
                                          style: primaryTextStyle.copyWith(
                                            fontSize: 15,
                                          ),
                                        ),
                                        SizedBox(
                                          width: 60,
                                        ),
                                        ElevatedButton(
                                          style: ElevatedButton.styleFrom(
                                            primary: Colors.orange[300],
                                            onPrimary: Colors.black,
                                          ),
                                          child: Text('ดูร้านค้า'),
                                          onPressed: () => Navigator.pushNamed(
                                              context, '/products_page'),
                                        )
                                      ],
                                    ),
                                  ),
                                  Container(
                                    color: Colors.pink[200],
                                    child: Row(
                                      children: [
                                        Icon(
                                          Icons.article,
                                          size: 40,
                                        ),
                                        Text(
                                          '   ชื่อสินค้า :  ${productt['productName']}',
                                          style: primaryTextStyle.copyWith(
                                            fontSize: 15,
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                  Container(
                                    margin: EdgeInsets.only(
                                      top: 10,
                                    ),
                                    child: Column(
                                      children: [
                                        Text(
                                          ' $_product : บาท',
                                          style: primaryTextStyle.copyWith(
                                              fontSize: 25,
                                              fontWeight: FontWeight.bold),
                                        ),
                                        SizedBox(
                                          width: 60,
                                        ),
                                        Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.center,
                                          children: [
                                            Container(
                                              child: Row(
                                                children: [
                                                  ElevatedButton(
                                                      style: ElevatedButton
                                                          .styleFrom(
                                                        primary:
                                                            Colors.orange[300],
                                                        onPrimary: Colors.black,
                                                      ),
                                                      child: Text(
                                                        '-',
                                                        style: primaryTextStyle
                                                            .copyWith(
                                                                fontSize: 20,
                                                                fontWeight:
                                                                    FontWeight
                                                                        .bold,
                                                                height: 2),
                                                      ),
                                                      onPressed:
                                                          _incrementCounterp),
                                                ],
                                              ),
                                            ),
                                            SizedBox(
                                              width: 10,
                                            ),
                                            Text(
                                              '$_counter',
                                              style: primaryTextStyle.copyWith(
                                                  fontSize: 25,
                                                  fontWeight: FontWeight.bold,
                                                  height: 2),
                                            ),
                                            SizedBox(
                                              width: 10,
                                            ),
                                            ElevatedButton(
                                                style: ElevatedButton.styleFrom(
                                                  primary: Colors.orange[300],
                                                  onPrimary: Colors.black,
                                                ),
                                                child: Text(
                                                  '+',
                                                  style:
                                                      primaryTextStyle.copyWith(
                                                          fontSize: 20,
                                                          fontWeight:
                                                              FontWeight.bold,
                                                          height: 2),
                                                ),
                                                onPressed: _incrementCounter)
                                          ],
                                        )
                                      ],
                                    ),
                                  ),
                                  Container(
                                    height: 100,
                                    color: Colors.grey[200],
                                    child: Column(
                                      children: [
                                        Container(
                                          width: 350,
                                          child: Padding(
                                            padding: EdgeInsets.all(8.0),
                                            child: Text(
                                              '   รายละเอียดสินค้า : ',
                                              style: primaryTextStyle.copyWith(
                                                fontSize: 15,
                                              ),
                                            ),
                                          ),
                                        ),
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
                  ),
                ],
              ),
            ),
          ),
        ));
  }
}
