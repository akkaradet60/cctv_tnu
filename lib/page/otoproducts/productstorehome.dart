import 'package:carousel_slider/carousel_slider.dart';
import 'package:cctv_tun/page/global/global.dart';
import 'package:cctv_tun/page/global/style/global.dart';
import 'package:cctv_tun/widgets/Text_pane.dart';
import 'package:flutter_locales/flutter_locales.dart';

import 'package:flutter_neumorphic/flutter_neumorphic.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

var productt;

class productstorehome extends StatefulWidget {
  productstorehome({Key? key}) : super(key: key);

  @override
  _productshop_page createState() => _productshop_page();
}

class _productshop_page extends State<productstorehome> {
  @override
  void initState() {
    super.initState();
  }

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
          title: Column(
            children: [
              Center(child: LocaleText('ร้านค้า')),
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
                              height: 200,
                              child: FutureBuilder<Map<String, dynamic>>(
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
                                            () {},
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
                          height: 1000,
                          width: 400,
                          child: Column(
                            children: [
                              Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: Container(
                                  height: 250,
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
                                          mainAxisAlignment:
                                              MainAxisAlignment.center,
                                          children: [
                                            Icon(
                                              Icons.article,
                                              size: 40,
                                              color: ThemeBc.white,
                                            ),
                                            SizedBox(width: 10),
                                            LocaleText(
                                              'ชื่อร้านค้า',
                                              style: TextStyle(
                                                fontSize: 15.0,
                                                fontWeight: FontWeight.bold,
                                                // backgroundColor: Colors.black45,
                                                color: ThemeBc.white,
                                              ),
                                            ),
                                            Text(
                                              'ชื่อร้านค้า',
                                              style: TextStyle(
                                                fontSize: 15.0,
                                                fontWeight: FontWeight.bold,
                                                // backgroundColor: Colors.black45,
                                                color: ThemeBc.white,
                                              ),
                                            ),
                                          ],
                                        ),
                                        SizedBox(height: 18),
                                        Container(
                                          decoration: BoxDecoration(
                                              color: Colors.grey[200],
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
                                          height: 150,
                                          child: Column(
                                            children: [
                                              Container(
                                                width: 350,
                                                height: 150,
                                                child: Padding(
                                                  padding: EdgeInsets.all(8.0),
                                                  child: ListView(
                                                    children: [
                                                      LocaleText(
                                                        'รายละเอียดร้านค้า',
                                                        style: primaryTextStyle
                                                            .copyWith(
                                                          fontSize: 15,
                                                        ),
                                                      ),
                                                      Text(
                                                        'รายละเอียดร้านค้า',
                                                        style: primaryTextStyle
                                                            .copyWith(
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
                              ),
                              SizedBox(height: 10),
                              Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: Container(
                                    height: 50,
                                    decoration: BoxDecoration(
                                        color: ThemeBc.black,
                                        borderRadius: BorderRadius.circular(
                                          10,
                                        ),
                                        boxShadow: [
                                          BoxShadow(
                                              color:
                                                  Colors.black.withOpacity(0.5),
                                              offset: Offset(2, 4),
                                              blurRadius: 7.0,
                                              spreadRadius: 1.0),
                                        ]),
                                    child: Row(
                                      children: [
                                        Padding(
                                          padding: const EdgeInsets.all(8.0),
                                          child: Text_pane(
                                              text: 'สินค้าของร้านค้า',
                                              color: Colors.white,
                                              fontSize: 15),
                                        ),
                                      ],
                                    )),
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
