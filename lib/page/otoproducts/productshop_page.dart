import 'package:carousel_slider/carousel_slider.dart';
import 'package:cctv_tun/page/global/global.dart';
import 'package:cctv_tun/page/global/style/global.dart';
import 'package:flutter_locales/flutter_locales.dart';

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
          backgroundColor: ThemeBc.background,
          title: Column(
            children: [
              Center(child: LocaleText('สินค้า')),
            ],
          ),
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
                  colors: [ThemeBc.background, ThemeBc.background],
                  begin: Alignment.topRight,
                  end: Alignment.bottomLeft)),
          child: Padding(
            padding: EdgeInsets.all(10),
            child: ListView(
              children: [
                Container(
                  decoration: BoxDecoration(
                    color: secondaryTextColor,
                    borderRadius: BorderRadius.circular(
                      50,
                    ),
                  ),
                  child: Column(
                    children: [
                      Container(
                        child: Column(
                          children: [
                            Container(
                              decoration: BoxDecoration(
                                color: secondaryTextColor,
                                borderRadius: BorderRadius.circular(
                                  20,
                                ),
                              ),
                              height: 300,
                              child: FutureBuilder<Map<String, dynamic>>(
                                future: getDataSlide(),
                                builder: (context, snapshot) {
                                  if (snapshot.hasData) {
                                    // return ListView.separated(
                                    //     itemBuilder: (context, index) {
                                    // return Text('3232');
                                    return CarouselSlider.builder(
                                      itemCount: snapshot.data!['data'].length,
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
                                          child: Container(
                                            decoration: BoxDecoration(
                                                color: secondaryTextColor,
                                                borderRadius:
                                                    BorderRadius.circular(
                                                  10,
                                                ),
                                                boxShadow: [
                                                  BoxShadow(
                                                      color: Colors.black
                                                          .withOpacity(0.5),
                                                      offset: Offset(2, 4),
                                                      blurRadius: 7.0,
                                                      spreadRadius: 1.0),
                                                ]),
                                            child: Padding(
                                              padding:
                                                  const EdgeInsets.all(5.0),
                                              child: ClipRRect(
                                                borderRadius: BorderRadius.all(
                                                  Radius.circular(10.0),
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
                        child: Container(
                          height: 600,
                          width: 400,
                          child: Column(
                            children: [
                              Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: Container(
                                  height: 165,
                                  decoration: BoxDecoration(
                                      color: ThemeBc.background,
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
                                            color:
                                                Colors.black.withOpacity(0.5),
                                            offset: Offset(2, 4),
                                            blurRadius: 7.0,
                                            spreadRadius: 1.0),
                                      ]),
                                  child: Padding(
                                    padding: const EdgeInsets.all(8.0),
                                    child: Column(
                                      children: [
                                        Row(
                                          children: [
                                            Icon(
                                              Icons.article,
                                              size: 40,
                                              color: ThemeBc.white,
                                            ),
                                            SizedBox(width: 10),
                                            LocaleText(
                                              'ชื่อสินค้า',
                                              style: TextStyle(
                                                fontSize: 15.0,
                                                fontWeight: FontWeight.bold,
                                                // backgroundColor: Colors.black45,
                                                color: ThemeBc.white,
                                              ),
                                            ),
                                            Text(
                                              ' :  ${productt['productName']}',
                                              style: TextStyle(
                                                fontSize: 15.0,
                                                fontWeight: FontWeight.bold,
                                                // backgroundColor: Colors.black45,
                                                color: ThemeBc.white,
                                              ),
                                            ),
                                          ],
                                        ),
                                        Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.spaceBetween,
                                          children: [
                                            Row(
                                              children: [
                                                Icon(
                                                  Icons.shopping_cart_rounded,
                                                  size: 40,
                                                  color: ThemeBc.white,
                                                ),
                                                SizedBox(width: 10),
                                                LocaleText(
                                                  'ศูนย์แสดงสินค้าโอทอป',
                                                  style: TextStyle(
                                                    fontSize: 15.0,
                                                    fontWeight: FontWeight.bold,
                                                    // backgroundColor: Colors.black45,
                                                    color: ThemeBc.textwhite,
                                                  ),
                                                ),
                                              ],
                                            ),
                                            ElevatedButton(
                                              style: ElevatedButton.styleFrom(
                                                primary: ThemeBc.white,
                                                onPrimary: ThemeBc.white,
                                              ),
                                              child: LocaleText(
                                                'ดูร้านค้า',
                                                style: TextStyle(
                                                  fontSize: 15.0,
                                                  fontWeight: FontWeight.bold,
                                                  // backgroundColor: Colors.black45,
                                                  color: ThemeBc.black,
                                                ),
                                              ),
                                              onPressed: () =>
                                                  Navigator.pushNamed(context,
                                                      '/productshome_page'),
                                            )
                                          ],
                                        ),
                                        SizedBox(height: 18),
                                        Container(
                                          child: Row(
                                            mainAxisAlignment:
                                                MainAxisAlignment.center,
                                            children: [
                                              Text(
                                                ' $_product : ',
                                                style: TextStyle(
                                                  fontSize: 25.0,
                                                  fontWeight: FontWeight.bold,
                                                  // backgroundColor: Colors.black45,
                                                  color: ThemeBc.white,
                                                ),
                                              ),
                                              LocaleText(
                                                'บาท',
                                                style: TextStyle(
                                                  fontSize: 25.0,
                                                  fontWeight: FontWeight.bold,
                                                  // backgroundColor: Colors.black45,
                                                  color: ThemeBc.white,
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
                              // Padding(
                              //   padding: const EdgeInsets.all(8.0),
                              //   child: Container(
                              //     height: 55,
                              //     decoration: BoxDecoration(
                              //         color: ThemeBc.background,
                              //         borderRadius: BorderRadius.circular(
                              //           20,
                              //         ),
                              //         boxShadow: [
                              //           BoxShadow(
                              //               color: Colors.grey.withOpacity(0.5),
                              //               offset: Offset(2, 2),
                              //               blurRadius: 7,
                              //               spreadRadius: 1.0),
                              //           BoxShadow(
                              //               color:
                              //                   Colors.black.withOpacity(0.5),
                              //               offset: Offset(2, 4),
                              //               blurRadius: 7.0,
                              //               spreadRadius: 1.0),
                              //         ]),
                              //     child: Row(
                              //       children: [
                              //         Icon(
                              //           Icons.article,
                              //           size: 40,
                              //           color: ThemeBc.white,
                              //         ),
                              //         Text(
                              //           '             ชื่อสินค้า :  ${productt['productName']}',
                              //           style: TextStyle(
                              //             fontSize: 15.0,
                              //             fontWeight: FontWeight.bold,
                              //             // backgroundColor: Colors.black45,
                              //             color: ThemeBc.white,
                              //           ),
                              //         ),
                              //       ],
                              //     ),
                              //   ),
                              // ),
                              Container(
                                margin: EdgeInsets.only(
                                  top: 10,
                                ),
                                child: Column(
                                  children: [
                                    // Text(
                                    //   ' $_product : บาท',
                                    //   style: primaryTextStyle.copyWith(
                                    //       fontSize: 25,
                                    //       fontWeight: FontWeight.bold),
                                    // ),
                                    SizedBox(
                                      width: 60,
                                    ),
                                    Padding(
                                      padding: const EdgeInsets.all(8.0),
                                      child: Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceBetween,
                                        children: [
                                          Container(
                                            decoration: BoxDecoration(
                                                color: ThemeBc.background,
                                                borderRadius:
                                                    BorderRadius.circular(
                                                  10,
                                                ),
                                                boxShadow: [
                                                  BoxShadow(
                                                      color: Colors.grey
                                                          .withOpacity(0.5),
                                                      offset: Offset(2, 2),
                                                      blurRadius: 7,
                                                      spreadRadius: 1.0),
                                                  BoxShadow(
                                                      color: Colors.black
                                                          .withOpacity(0.5),
                                                      offset: Offset(2, 4),
                                                      blurRadius: 7.0,
                                                      spreadRadius: 1.0),
                                                ]),
                                            child: Row(
                                              children: [
                                                ElevatedButton(
                                                    style: ElevatedButton
                                                        .styleFrom(
                                                      primary:
                                                          ThemeBc.background,
                                                      onPrimary: Colors.white,
                                                    ),
                                                    child: Text(
                                                      '-',
                                                      style: TextStyle(
                                                        fontSize: 20.0,
                                                        fontWeight:
                                                            FontWeight.bold,
                                                        // backgroundColor: Colors.black45,
                                                        color: ThemeBc.white,
                                                      ),
                                                    ),
                                                    onPressed:
                                                        _incrementCounterp),
                                                SizedBox(
                                                  width: 10,
                                                ),
                                                Text(
                                                  '$_counter',
                                                  style: TextStyle(
                                                    fontSize: 20.0,
                                                    fontWeight: FontWeight.bold,
                                                    // backgroundColor: Colors.black45,
                                                    color: ThemeBc.white,
                                                  ),
                                                ),
                                                SizedBox(
                                                  width: 10,
                                                ),
                                                ElevatedButton(
                                                    style: ElevatedButton
                                                        .styleFrom(
                                                      primary:
                                                          ThemeBc.background,
                                                      onPrimary: Colors.black,
                                                    ),
                                                    child: Text(
                                                      '+',
                                                      style: TextStyle(
                                                        fontSize: 20.0,
                                                        fontWeight:
                                                            FontWeight.bold,
                                                        // backgroundColor: Colors.black45,
                                                        color: ThemeBc.white,
                                                      ),
                                                    ),
                                                    onPressed:
                                                        _incrementCounter)
                                              ],
                                            ),
                                          ),
                                          InkWell(
                                            onTap: () {
                                              showDialog(
                                                context: context,
                                                builder: (context) {
                                                  return AlertDialog(
                                                    shape: CircleBorder(),
                                                    // elevation: 100,
                                                    content: Container(
                                                      height: 230,
                                                      width: 400,
                                                      decoration: BoxDecoration(
                                                          color: ThemeBc
                                                              .background,
                                                          borderRadius:
                                                              BorderRadius
                                                                  .circular(
                                                            20,
                                                          ),
                                                          boxShadow: [
                                                            BoxShadow(
                                                                color: Colors
                                                                    .black
                                                                    .withOpacity(
                                                                        0.5),
                                                                offset: Offset(
                                                                    2, 2),
                                                                blurRadius: 7,
                                                                spreadRadius:
                                                                    1.0),
                                                            BoxShadow(
                                                                color: Colors
                                                                    .black
                                                                    .withOpacity(
                                                                        0.5),
                                                                offset: Offset(
                                                                    2, 4),
                                                                blurRadius: 7.0,
                                                                spreadRadius:
                                                                    1.0),
                                                          ]),
                                                      child: ListView(
                                                        children: [
                                                          Column(
                                                            crossAxisAlignment:
                                                                CrossAxisAlignment
                                                                    .start,
                                                            children: [
                                                              Padding(
                                                                padding:
                                                                    const EdgeInsets
                                                                            .all(
                                                                        8.0),
                                                                child: Row(
                                                                  children: [
                                                                    LocaleText(
                                                                      'ชื่อสินค้า',
                                                                      style:
                                                                          TextStyle(
                                                                        fontSize:
                                                                            15.0,
                                                                        fontWeight:
                                                                            FontWeight.bold,
                                                                        // backgroundColor: Colors.black45,
                                                                        color: ThemeBc
                                                                            .white,
                                                                      ),
                                                                    ),
                                                                    Container(
                                                                      height:
                                                                          20,
                                                                      width:
                                                                          150,
                                                                      child:
                                                                          ListView(
                                                                        scrollDirection:
                                                                            Axis.horizontal,
                                                                        children: [
                                                                          Text(
                                                                            ' : ${productt['productName']}',
                                                                            style:
                                                                                TextStyle(
                                                                              fontSize: 15.0,
                                                                              fontWeight: FontWeight.bold,
                                                                              // backgroundColor: Colors.black45,
                                                                              color: ThemeBc.white,
                                                                            ),
                                                                          ),
                                                                        ],
                                                                      ),
                                                                    ),
                                                                  ],
                                                                ),
                                                              ),
                                                              Padding(
                                                                padding:
                                                                    const EdgeInsets
                                                                            .all(
                                                                        8.0),
                                                                child: Row(
                                                                  children: [
                                                                    LocaleText(
                                                                      'จำนวน',
                                                                      style:
                                                                          TextStyle(
                                                                        fontSize:
                                                                            15.0,
                                                                        fontWeight:
                                                                            FontWeight.bold,
                                                                        // backgroundColor: Colors.black45,
                                                                        color: ThemeBc
                                                                            .white,
                                                                      ),
                                                                    ),
                                                                    Container(
                                                                      height:
                                                                          15,
                                                                      child:
                                                                          Text(
                                                                        ' : ${_counter}',
                                                                        style:
                                                                            TextStyle(
                                                                          fontSize:
                                                                              15.0,
                                                                          fontWeight:
                                                                              FontWeight.bold,
                                                                          // backgroundColor: Colors.black45,
                                                                          color:
                                                                              ThemeBc.white,
                                                                        ),
                                                                      ),
                                                                    ),
                                                                  ],
                                                                ),
                                                              ),
                                                            ],
                                                          ),
                                                          SizedBox(height: 10),
                                                          Row(
                                                            mainAxisAlignment:
                                                                MainAxisAlignment
                                                                    .center,
                                                            children: [
                                                              Container(
                                                                decoration:
                                                                    BoxDecoration(
                                                                        color: ThemeBc
                                                                            .white,
                                                                        borderRadius:
                                                                            BorderRadius.circular(
                                                                          20,
                                                                        ),
                                                                        boxShadow: [
                                                                      BoxShadow(
                                                                          color: Colors.black.withOpacity(
                                                                              0.5),
                                                                          offset: Offset(2,
                                                                              2),
                                                                          blurRadius:
                                                                              7,
                                                                          spreadRadius:
                                                                              1.0),
                                                                      BoxShadow(
                                                                          color: Colors.black.withOpacity(
                                                                              0.5),
                                                                          offset: Offset(2,
                                                                              4),
                                                                          blurRadius:
                                                                              7.0,
                                                                          spreadRadius:
                                                                              1.0),
                                                                    ]),
                                                                child: Padding(
                                                                  padding:
                                                                      const EdgeInsets
                                                                              .all(
                                                                          8.0),
                                                                  child: Row(
                                                                    children: [
                                                                      LocaleText(
                                                                        'ราคา',
                                                                        style:
                                                                            TextStyle(
                                                                          fontSize:
                                                                              15.0,
                                                                          fontWeight:
                                                                              FontWeight.bold,
                                                                          // backgroundColor: Colors.black45,
                                                                          color:
                                                                              ThemeBc.black,
                                                                        ),
                                                                      ),
                                                                      Container(
                                                                        height:
                                                                            15,
                                                                        child:
                                                                            Text(
                                                                          ' $_product : ',
                                                                          style:
                                                                              TextStyle(
                                                                            fontSize:
                                                                                15.0,
                                                                            fontWeight:
                                                                                FontWeight.bold,
                                                                            // backgroundColor: Colors.black45,
                                                                            color:
                                                                                ThemeBc.black,
                                                                          ),
                                                                        ),
                                                                      ),
                                                                      LocaleText(
                                                                        'บาท',
                                                                        style:
                                                                            TextStyle(
                                                                          fontSize:
                                                                              15.0,
                                                                          fontWeight:
                                                                              FontWeight.bold,
                                                                          // backgroundColor: Colors.black45,
                                                                          color:
                                                                              ThemeBc.black,
                                                                        ),
                                                                      ),
                                                                    ],
                                                                  ),
                                                                ),
                                                              ),
                                                            ],
                                                          ),
                                                          SizedBox(height: 10),
                                                          Row(
                                                            mainAxisAlignment:
                                                                MainAxisAlignment
                                                                    .center,
                                                            children: [
                                                              InkWell(
                                                                child:
                                                                    Container(
                                                                  height: 45,
                                                                  width: 100,
                                                                  decoration:
                                                                      BoxDecoration(
                                                                          color: ThemeBc
                                                                              .white,
                                                                          borderRadius:
                                                                              BorderRadius.circular(
                                                                            20,
                                                                          ),
                                                                          boxShadow: [
                                                                        BoxShadow(
                                                                            color: Colors.black.withOpacity(
                                                                                0.5),
                                                                            offset: Offset(
                                                                                2, 2),
                                                                            blurRadius:
                                                                                7,
                                                                            spreadRadius:
                                                                                1.0),
                                                                        BoxShadow(
                                                                            color: Colors.black.withOpacity(
                                                                                0.5),
                                                                            offset: Offset(
                                                                                2, 4),
                                                                            blurRadius:
                                                                                7.0,
                                                                            spreadRadius:
                                                                                1.0),
                                                                      ]),
                                                                  child:
                                                                      Padding(
                                                                    padding:
                                                                        const EdgeInsets.all(
                                                                            8.0),
                                                                    child:
                                                                        Center(
                                                                      child:
                                                                          LocaleText(
                                                                        'ชื้อ',
                                                                        style:
                                                                            TextStyle(
                                                                          fontSize:
                                                                              15.0,
                                                                          fontWeight:
                                                                              FontWeight.bold,
                                                                          // backgroundColor: Colors.black45,
                                                                          color:
                                                                              ThemeBc.black,
                                                                        ),
                                                                      ),
                                                                    ),
                                                                  ),
                                                                ),
                                                              ),
                                                            ],
                                                          ),
                                                        ],
                                                      ),
                                                    ),
                                                  );
                                                },
                                              );
                                            },
                                            child: Container(
                                              decoration: BoxDecoration(
                                                  color: ThemeBc.background,
                                                  borderRadius:
                                                      BorderRadius.circular(
                                                    10,
                                                  ),
                                                  boxShadow: [
                                                    BoxShadow(
                                                        color: Colors.grey
                                                            .withOpacity(0.5),
                                                        offset: Offset(2, 2),
                                                        blurRadius: 7,
                                                        spreadRadius: 1.0),
                                                    BoxShadow(
                                                        color: Colors.black
                                                            .withOpacity(0.5),
                                                        offset: Offset(2, 4),
                                                        blurRadius: 7.0,
                                                        spreadRadius: 1.0),
                                                  ]),
                                              height: 45,
                                              width: 100,
                                              child: Row(
                                                mainAxisAlignment:
                                                    MainAxisAlignment.center,
                                                children: [
                                                  LocaleText(
                                                    'ชื้อ',
                                                    style: TextStyle(
                                                      fontSize: 20.0,
                                                      fontWeight:
                                                          FontWeight.bold,
                                                      // backgroundColor: Colors.black45,
                                                      color: ThemeBc.white,
                                                    ),
                                                  ),
                                                ],
                                              ),
                                            ),
                                          ),
                                        ],
                                      ),
                                    )
                                  ],
                                ),
                              ),
                              SizedBox(height: 18),
                              Container(
                                decoration: BoxDecoration(
                                    color: Colors.grey[200],
                                    borderRadius: BorderRadius.circular(
                                      10,
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
                                height: 150,
                                child: Column(
                                  children: [
                                    Container(
                                      width: 350,
                                      child: Padding(
                                        padding: EdgeInsets.all(8.0),
                                        child: Column(
                                          children: [
                                            LocaleText(
                                              'รายละเอียดสินค้า',
                                              style: primaryTextStyle.copyWith(
                                                fontSize: 15,
                                              ),
                                            ),
                                            Text(
                                              ' : ${productt['product_detail']} ',
                                              style: primaryTextStyle.copyWith(
                                                fontSize: 15,
                                              ),
                                            ),
                                          ],
                                        ), //product_detail
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ));
  }
}
