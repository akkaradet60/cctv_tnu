import 'package:carousel_slider/carousel_slider.dart';
import 'package:cctv_tun/page/global/global.dart';
import 'package:cctv_tun/page/global/style/global.dart';
import 'package:flutter_locales/flutter_locales.dart';

import 'package:flutter_neumorphic/flutter_neumorphic.dart';
import 'package:google_fonts/google_fonts.dart';
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

  var _counter = 0;
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
            color: ThemeBc.app_white_color, //change your color here
          ),
          foregroundColor: ThemeBc.app_white_color,
          backgroundColor: ThemeBc.app_theme_color,
          title: Column(
            children: [
              Center(
                  child: LocaleText(
                '??????????????????',
                style: GoogleFonts.sarabun(
                  textStyle: TextStyle(
                    color: ThemeBc.app_textwhite_color,
                    fontWeight: FontWeight.bold,
                    fontSize: 18,
                  ),
                ),
              )),
            ],
          ),
          actions: <Widget>[
            IconButton(
              icon: Icon(
                Icons.refresh,
                color: ThemeBc.app_linear_on,
              ),
              tooltip: 'Show Snackbar',
              onPressed: () {},
            ),
          ],
        ),
        body: Container(
          decoration: BoxDecoration(
              gradient: LinearGradient(colors: [
            ThemeBc.app_linear_on,
            ThemeBc.app_linear_lower,
          ], begin: Alignment.topRight, end: Alignment.bottomLeft)),
          child: Padding(
            padding: EdgeInsets.all(10),
            child: ListView(
              children: [
                Container(
                  child: Column(
                    children: [
                      Container(
                        height: 300,
                        child: Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Container(
                            child: FutureBuilder<Map<String, dynamic>>(
                              future: getDataSlide(),
                              builder: (context, snapshot) {
                                if (snapshot.hasData) {
                                  if (snapshot.data!['data'] == '?????????????????????????????????') {
                                    return Padding(
                                      padding: const EdgeInsets.all(8.0),
                                      child: Column(
                                        children: [
                                          Container(
                                            decoration: BoxDecoration(
                                                color: ThemeBc.app_linear_on,
                                                borderRadius:
                                                    BorderRadius.circular(
                                                  10,
                                                ),
                                                boxShadow: [
                                                  BoxShadow(
                                                      color: Colors.black
                                                          .withOpacity(0.1),
                                                      offset: Offset(2, 4),
                                                      blurRadius: 7.0,
                                                      spreadRadius: 1.0),
                                                ]),
                                            child: Padding(
                                              padding:
                                                  const EdgeInsets.all(8.0),
                                              child: Text(
                                                '?????????????????????????????????',
                                                style: TextStyle(
                                                  fontSize: 20.0,
                                                  fontWeight: FontWeight.w300,
                                                  // backgroundColor: Colors.black45,
                                                  color: ThemeBc
                                                      .app_textwhite_color,
                                                ),
                                              ),
                                            ),
                                          ),
                                        ],
                                      ),
                                    );
                                  } else {
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
                                        child: InkWell(
                                          // child: Card(
                                          //   margin: EdgeInsets.only(
                                          //     top: 10.0,
                                          //     bottom: 10.0,
                                          //   ),
                                          //   elevation: 6.0,
                                          // shadowColor: Colors.redAccent,
                                          // shape: RoundedRectangleBorder(
                                          //     // borderRadius: BorderRadius.circular(30.0),
                                          //     ),

                                          child: ClipRRect(
                                            borderRadius: BorderRadius.all(
                                              Radius.circular(10.0),
                                            ),
                                            child: ListView(
                                              children: [
                                                Stack(
                                                  children: <Widget>[
                                                    Image.network(
                                                      productt[
                                                          'productiPathName'],
                                                      fit: BoxFit.cover,
                                                      width: double.infinity,
                                                    ),
                                                    Column(
                                                      children: [
                                                        SizedBox(height: 160),
                                                      ],
                                                    ),
                                                  ],
                                                ),
                                              ],
                                            ),
                                          ),
                                        ),
                                      ),
                                    );
                                  }

                                  // return ListView.separated(
                                  //     itemBuilder: (context, index) {
                                  // return Text('3232');

                                } else if (snapshot.hasError) {
                                  return Center(
                                      child: Text(
                                          '??????????????????????????????????????????????????? Server ${snapshot.error}'));
                                }

                                return Center(
                                    child: CircularProgressIndicator());
                              },
                            ),
                          ),
                        ),
                      ),
                      Container(
                        child: Container(
                          height: 500,
                          width: 400,
                          child: Column(
                            children: [
                              Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: Container(
                                  height: 400,
                                  decoration: BoxDecoration(
                                      color: ThemeBc.app_white_color,
                                      borderRadius: BorderRadius.circular(
                                        10,
                                      ),
                                      boxShadow: [
                                        BoxShadow(
                                            color:
                                                Colors.black.withOpacity(0.1),
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
                                              size: 30,
                                              color:
                                                  ThemeBc.app_textblack_color,
                                            ),
                                            SizedBox(width: 10),
                                            LocaleText(
                                              '??????????????????????????????',
                                              style: GoogleFonts.sarabun(
                                                textStyle: TextStyle(
                                                  color: ThemeBc
                                                      .app_textblack_color,
                                                  fontWeight: FontWeight.bold,
                                                  fontSize: 15,
                                                ),
                                              ),
                                            ),
                                            Text(
                                              ' :  ${productt['productName']}',
                                              style: GoogleFonts.sarabun(
                                                textStyle: TextStyle(
                                                  color: ThemeBc
                                                      .app_textblack_color,
                                                  fontWeight: FontWeight.w400,
                                                  fontSize: 15,
                                                ),
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
                                                  size: 30,
                                                  color: ThemeBc
                                                      .app_textblack_color,
                                                ),
                                                SizedBox(width: 10),
                                                LocaleText(
                                                  '????????????????????????????????????????????????????????????',
                                                  style: GoogleFonts.sarabun(
                                                    textStyle: TextStyle(
                                                      color: ThemeBc
                                                          .app_textblack_color,
                                                      fontWeight:
                                                          FontWeight.bold,
                                                      fontSize: 15,
                                                    ),
                                                  ),
                                                ),
                                              ],
                                            ),
                                            ElevatedButton(
                                              style: ElevatedButton.styleFrom(
                                                primary: ThemeBc.app_linear_on,
                                                onPrimary:
                                                    ThemeBc.app_white_color,
                                              ),
                                              child: LocaleText(
                                                '???????????????????????????',
                                                style: GoogleFonts.sarabun(
                                                  textStyle: TextStyle(
                                                    color: ThemeBc
                                                        .app_textwhite_color,
                                                    fontWeight: FontWeight.w400,
                                                    fontSize: 15,
                                                  ),
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
                                          child: Column(
                                            mainAxisAlignment:
                                                MainAxisAlignment.center,
                                            children: [
                                              Text(
                                                '$_product',
                                                style: GoogleFonts.sarabun(
                                                  textStyle: TextStyle(
                                                    color: ThemeBc
                                                        .app_textblack_color,
                                                    fontWeight: FontWeight.w400,
                                                    fontSize: 20,
                                                  ),
                                                ),
                                              ),
                                              LocaleText(
                                                '?????????',
                                                style: GoogleFonts.sarabun(
                                                  textStyle: TextStyle(
                                                    color: ThemeBc
                                                        .app_textblack_color,
                                                    fontWeight: FontWeight.w400,
                                                    fontSize: 20,
                                                  ),
                                                ),
                                              ),
                                            ],
                                          ),
                                        ),
                                        SizedBox(height: 10),
                                        Padding(
                                          padding: const EdgeInsets.all(8.0),
                                          child: Row(
                                            mainAxisAlignment:
                                                MainAxisAlignment.spaceBetween,
                                            children: [
                                              Container(
                                                child: Row(
                                                  children: [
                                                    ElevatedButton(
                                                        style: ElevatedButton
                                                            .styleFrom(
                                                          primary: ThemeBc
                                                              .app_white_color,
                                                          onPrimary:
                                                              Colors.white,
                                                        ),
                                                        child: Text(
                                                          '-',
                                                          style: TextStyle(
                                                            fontSize: 20.0,
                                                            fontWeight:
                                                                FontWeight.bold,
                                                            // backgroundColor: Colors.black45,
                                                            color: ThemeBc
                                                                .app_textblack_color,
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
                                                        fontWeight:
                                                            FontWeight.bold,
                                                        // backgroundColor: Colors.black45,
                                                        color: ThemeBc
                                                            .app_textblack_color,
                                                      ),
                                                    ),
                                                    SizedBox(
                                                      width: 10,
                                                    ),
                                                    ElevatedButton(
                                                        style: ElevatedButton
                                                            .styleFrom(
                                                          primary: ThemeBc
                                                              .app_white_color,
                                                        ),
                                                        child: Text(
                                                          '+',
                                                          style: TextStyle(
                                                            fontSize: 20.0,
                                                            fontWeight:
                                                                FontWeight.bold,
                                                            // backgroundColor: Colors.black45,
                                                            color: ThemeBc
                                                                .app_textblack_color,
                                                          ),
                                                        ),
                                                        onPressed:
                                                            _incrementCounter)
                                                  ],
                                                ),
                                              ),
                                              ElevatedButton(
                                                  style:
                                                      ElevatedButton.styleFrom(
                                                    primary:
                                                        ThemeBc.app_linear_on,
                                                  ),
                                                  child: Text(
                                                    '????????????',
                                                    style: GoogleFonts.sarabun(
                                                      textStyle: TextStyle(
                                                        color: ThemeBc
                                                            .app_textwhite_color,
                                                        fontWeight:
                                                            FontWeight.w400,
                                                        fontSize: 15,
                                                      ),
                                                    ),
                                                  ),
                                                  onPressed: () {
                                                    showDialog(
                                                      context: context,
                                                      builder: (context) {
                                                        return AlertDialog(
                                                          shape: RoundedRectangleBorder(
                                                              borderRadius:
                                                                  new BorderRadius
                                                                          .circular(
                                                                      30)),
                                                          // elevation: 100,
                                                          content: Container(
                                                            height: 150,
                                                            width: 300,
                                                            child: ListView(
                                                              children: [
                                                                Column(
                                                                  crossAxisAlignment:
                                                                      CrossAxisAlignment
                                                                          .start,
                                                                  children: [
                                                                    Container(
                                                                      decoration: BoxDecoration(
                                                                          color: Colors.grey[200],
                                                                          borderRadius: BorderRadius.circular(
                                                                            10,
                                                                          ),
                                                                          boxShadow: []),
                                                                      child:
                                                                          Padding(
                                                                        padding:
                                                                            const EdgeInsets.all(8.0),
                                                                        child:
                                                                            Column(
                                                                          children: [
                                                                            Padding(
                                                                              padding: const EdgeInsets.all(0),
                                                                              child: Row(
                                                                                children: [
                                                                                  LocaleText(
                                                                                    '??????????????????????????????',
                                                                                    style: GoogleFonts.sarabun(
                                                                                      textStyle: TextStyle(
                                                                                        color: ThemeBc.app_textblack_color,
                                                                                        fontWeight: FontWeight.bold,
                                                                                        fontSize: 15,
                                                                                      ),
                                                                                    ),
                                                                                  ),
                                                                                  Container(
                                                                                    height: 20,
                                                                                    width: 150,
                                                                                    child: ListView(
                                                                                      scrollDirection: Axis.horizontal,
                                                                                      children: [
                                                                                        Text(
                                                                                          '  ${productt['productName']}',
                                                                                          style: GoogleFonts.sarabun(
                                                                                            textStyle: TextStyle(
                                                                                              color: ThemeBc.app_textblack_color,
                                                                                              fontWeight: FontWeight.w400,
                                                                                              fontSize: 15,
                                                                                            ),
                                                                                          ),
                                                                                        ),
                                                                                      ],
                                                                                    ),
                                                                                  ),
                                                                                ],
                                                                              ),
                                                                            ),
                                                                            Row(
                                                                              children: [
                                                                                LocaleText(
                                                                                  '???????????????',
                                                                                  style: GoogleFonts.sarabun(
                                                                                    textStyle: TextStyle(
                                                                                      color: ThemeBc.app_textblack_color,
                                                                                      fontWeight: FontWeight.w400,
                                                                                      fontSize: 15,
                                                                                    ),
                                                                                  ),
                                                                                ),
                                                                                Container(
                                                                                  height: 20,
                                                                                  child: Text(
                                                                                    '  ${_counter}',
                                                                                    style: GoogleFonts.sarabun(
                                                                                      textStyle: TextStyle(
                                                                                        color: ThemeBc.app_textblack_color,
                                                                                        fontWeight: FontWeight.w400,
                                                                                        fontSize: 15,
                                                                                      ),
                                                                                    ),
                                                                                  ),
                                                                                ),
                                                                              ],
                                                                            ),
                                                                            Row(
                                                                              mainAxisAlignment: MainAxisAlignment.center,
                                                                              children: [
                                                                                Container(
                                                                                  child: Padding(
                                                                                    padding: const EdgeInsets.all(0),
                                                                                    child: Row(
                                                                                      children: [
                                                                                        LocaleText(
                                                                                          '????????????',
                                                                                          style: GoogleFonts.sarabun(
                                                                                            textStyle: TextStyle(
                                                                                              color: ThemeBc.app_textblack_color,
                                                                                              fontWeight: FontWeight.w400,
                                                                                              fontSize: 15,
                                                                                            ),
                                                                                          ),
                                                                                        ),
                                                                                        Container(
                                                                                          height: 20,
                                                                                          child: Text(
                                                                                            ' $_product  ',
                                                                                            style: GoogleFonts.sarabun(
                                                                                              textStyle: TextStyle(
                                                                                                color: ThemeBc.app_textblack_color,
                                                                                                fontWeight: FontWeight.w400,
                                                                                                fontSize: 15,
                                                                                              ),
                                                                                            ),
                                                                                          ),
                                                                                        ),
                                                                                        LocaleText(
                                                                                          '?????????',
                                                                                          style: GoogleFonts.sarabun(
                                                                                            textStyle: TextStyle(
                                                                                              color: ThemeBc.app_textblack_color,
                                                                                              fontWeight: FontWeight.w400,
                                                                                              fontSize: 15,
                                                                                            ),
                                                                                          ),
                                                                                        ),
                                                                                      ],
                                                                                    ),
                                                                                  ),
                                                                                ),
                                                                              ],
                                                                            ),
                                                                          ],
                                                                        ),
                                                                      ),
                                                                    ),
                                                                  ],
                                                                ),
                                                                SizedBox(
                                                                    height: 10),
                                                                Row(
                                                                  mainAxisAlignment:
                                                                      MainAxisAlignment
                                                                          .center,
                                                                  children: [
                                                                    ElevatedButton(
                                                                        style: ElevatedButton
                                                                            .styleFrom(
                                                                          primary:
                                                                              ThemeBc.app_linear_on,
                                                                        ),
                                                                        child:
                                                                            Text(
                                                                          '????????????',
                                                                          style:
                                                                              GoogleFonts.sarabun(
                                                                            textStyle:
                                                                                TextStyle(
                                                                              color: ThemeBc.app_textwhite_color,
                                                                              fontWeight: FontWeight.w400,
                                                                              fontSize: 15,
                                                                            ),
                                                                          ),
                                                                        ),
                                                                        onPressed:
                                                                            () {}),
                                                                  ],
                                                                ),
                                                              ],
                                                            ),
                                                          ),
                                                        );
                                                      },
                                                    );
                                                  }),
                                            ],
                                          ),
                                        ),
                                        Container(
                                          decoration: BoxDecoration(
                                              color: Colors.grey[200],
                                              borderRadius:
                                                  BorderRadius.circular(
                                                10,
                                              ),
                                              boxShadow: []),
                                          height: 150,
                                          child: Column(
                                            children: [
                                              Container(
                                                width: 350,
                                                child: Padding(
                                                  padding: EdgeInsets.all(8.0),
                                                  child: Column(
                                                    crossAxisAlignment:
                                                        CrossAxisAlignment
                                                            .start,
                                                    children: [
                                                      Text(
                                                        '   ${productt['product_detail']} ',
                                                        style:
                                                            GoogleFonts.sarabun(
                                                          textStyle: TextStyle(
                                                            color: ThemeBc
                                                                .app_textblack_color,
                                                            fontWeight:
                                                                FontWeight.w400,
                                                            fontSize: 15,
                                                          ),
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
                              ),
                              // Container(
                              //   margin: EdgeInsets.only(
                              //     top: 10,
                              //   ),
                              //   child: Column(
                              //     children: [
                              //       // Text(
                              //       //   ' $_product : ?????????',
                              //       //   style: primaryTextStyle.copyWith(
                              //       //       fontSize: 25,
                              //       //       fontWeight: FontWeight.bold),
                              //       // ),
                              //       SizedBox(
                              //         width: 60,
                              //       ),

                              //     ],
                              //   ),
                              // ),
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
