import 'package:cctv_tun/page/global/global.dart';
import 'package:cctv_tun/page/global/style/global.dart';
import 'package:cctv_tun/widgets/Text_pane.dart';

import 'package:flutter/material.dart';
import 'package:flutter_locales/flutter_locales.dart';

import 'package:http/http.dart' as http;
import 'dart:convert';

class travelhome_page extends StatefulWidget {
  travelhome_page({Key? key}) : super(key: key);

  @override
  _productshome_page createState() => _productshome_page();
}

class _productshome_page extends State<travelhome_page> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        bottomNavigationBar: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Container(
            height: 60,
            color: ThemeBc.white,
            child: Container(
              decoration: BoxDecoration(
                  color: ThemeBc.black,
                  borderRadius: BorderRadius.circular(
                    10,
                  ),
                  boxShadow: [
                    BoxShadow(
                        color: Colors.white.withOpacity(0.5),
                        offset: Offset(2, 2),
                        blurRadius: 7,
                        spreadRadius: 1.0),
                  ]),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  IconButton(
                      icon: Icon(
                        Icons.festival,
                        size: 30,
                        color: ThemeBc.white,
                      ),
                      tooltip: 'Show Snackbar',
                      onPressed: () {
                        Navigator.pushNamed(context, '/travelhome_page');
                      }),
                  IconButton(
                    icon: Icon(
                      Icons.room,
                      size: 30,
                      color: ThemeBc.white,
                    ),
                    tooltip: 'Show Snackbar',
                    onPressed: () {
                      Navigator.pushNamed(context, '/travelmapS_page');
                    },
                  ),
                  IconButton(
                    icon: Icon(
                      Icons.kitesurfing,
                      size: 30,
                      color: ThemeBc.white,
                    ),
                    tooltip: 'Show Snackbar',
                    onPressed: () {
                      ScaffoldMessenger.of(context).showSnackBar(
                          const SnackBar(content: Text('กำลังพัฒนา')));
                    },
                  ),
                  IconButton(
                    icon: Icon(
                      Icons.landscape,
                      size: 30,
                      color: ThemeBc.white,
                    ),
                    tooltip: 'Show Snackbar',
                    onPressed: () {
                      ScaffoldMessenger.of(context).showSnackBar(
                          const SnackBar(content: Text('กำลังพัฒนา')));
                    },
                  ),
                ],
              ),
            ),
          ),
        ),
        appBar: AppBar(
          iconTheme: IconThemeData(
            color: ThemeBc.white, //change your color here
          ),
          shadowColor: ThemeBc.white,
          foregroundColor: ThemeBc.white,
          backgroundColor: ThemeBc.background,
          title: Column(
            children: [
              Center(child: LocaleText('ท่องเที่ยว')),
            ],
          ),
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
                colors: [ThemeBc.white, ThemeBc.white],
                begin: Alignment.topRight,
                end: Alignment.bottomLeft),
          ),
          child: ListView(
            children: [
              SizedBox(
                width: 20,
              ),
              Column(
                crossAxisAlignment: CrossAxisAlignment.end,
                children: [],
              ),
              //sso(context),
              travel01(context),
              travel02(context),
              travel03(context)
            ],
          ),
        ));
  }

  Widget travel01(BuildContext context) {
    bool isLoading = true;
    var hotlinee;
    var productt;
    var detail;

    late Map<String, dynamic> imgSlide;

    int _currentIndex = 0;

    Future<Map<String, dynamic>> getDataSlide() async {
      var url =
          ('https://www.bc-official.com/api/app_nt/api/app/travel/type/restful/?type_app_id=1');
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

    @override
    void initState() {
      super.initState();

      getDataSlide();
    }

    return Container(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SizedBox(height: 5),
          Container(
            height: 320,
            child: FutureBuilder<Map<String, dynamic>>(
              future: getDataSlide(),
              builder: (context, snapshot) {
                if (snapshot.hasData) {
                  return Column(
                    children: [
                      InkWell(
                        onTap: () {
                          Navigator.pushNamed(context, '/travel_page',
                              arguments: {
                                'type_app_id': snapshot.data!['data'][0]
                                    ['type_app_id'],
                                'type_name': snapshot.data!['data'][0]
                                    ['type_name'],
                              });
                        },
                        child: Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Container(
                            child: Column(
                              children: [
                                Stack(
                                  children: <Widget>[
                                    Container(
                                      height: 300,
                                      child: ClipRRect(
                                        borderRadius: BorderRadius.all(
                                          Radius.circular(10.0),
                                        ),
                                        child: Image.network(
                                          snapshot.data!['data'][0]
                                                      ['type_image'] !=
                                                  null
                                              ? Global.domainImagenew +
                                                  snapshot.data!['data'][0]
                                                      ['type_image']
                                              : '${Global.networkImage}',
                                          fit: BoxFit.cover,
                                          width: double.infinity,
                                        ),
                                      ),
                                    ),
                                    Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        SizedBox(height: 60),
                                        Container(
                                          decoration: BoxDecoration(
                                              color: ThemeBc.black,
                                              borderRadius:
                                                  BorderRadius.circular(
                                                10,
                                              ),
                                              boxShadow: [
                                                BoxShadow(
                                                    color: Colors.black
                                                        .withOpacity(0.5),
                                                    offset: Offset(2, 2),
                                                    blurRadius: 7,
                                                    spreadRadius: 1.0),
                                              ]),
                                          child: Padding(
                                            padding: const EdgeInsets.all(8.0),
                                            child: Text(
                                              // '${titles[_currentIndex]}',
                                              '${snapshot.data!['data'][0]['type_name']}',
                                              style: TextStyle(
                                                fontSize: 24.0,
                                                fontWeight: FontWeight.bold,
                                                // backgroundColor: Colors.black45,
                                                color: ThemeBc.white,
                                              ),
                                            ),
                                          ),
                                        ),
                                        SizedBox(height: 40),
                                        Container(
                                          height: 140,
                                          color: Colors.black54,
                                          child: ListView(
                                            children: [
                                              Padding(
                                                padding:
                                                    const EdgeInsets.all(8.0),
                                                child: Text_pane(
                                                    text:
                                                        '  ${snapshot.data!['data'][0]['type_detail']}',
                                                    color: ThemeBc.white,
                                                    fontSize: 15),
                                              )
                                            ],
                                          ),
                                        ),
                                      ],
                                    ),
                                  ],
                                ),
                              ],
                            ),
                          ),
                        ),
                      ),
                    ],
                  );
                } else if (snapshot.hasError) {}

                return Center(child: CircularProgressIndicator());
              },
            ),
          ),
        ],
      ),
    );
  }

  Widget travel02(BuildContext context) {
    bool isLoading = true;
    var hotlinee;
    var productt;
    var detail;

    late Map<String, dynamic> imgSlide;

    int _currentIndex = 0;

    Future<Map<String, dynamic>> getDataSlide() async {
      var url =
          ('https://www.bc-official.com/api/app_nt/api/app/travel/type/restful/?type_app_id=2');
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

    @override
    void initState() {
      super.initState();

      getDataSlide();
    }

    return Container(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SizedBox(height: 5),
          Container(
            height: 320,
            child: FutureBuilder<Map<String, dynamic>>(
              future: getDataSlide(),
              builder: (context, snapshot) {
                if (snapshot.hasData) {
                  return Column(
                    children: [
                      InkWell(
                        onTap: () {
                          Navigator.pushNamed(context, '/travel_page',
                              arguments: {
                                'type_app_id': snapshot.data!['data'][0]
                                    ['type_app_id'],
                                'type_name': snapshot.data!['data'][0]
                                    ['type_name'],
                              });
                        },
                        child: Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Container(
                            child: Column(
                              children: [
                                Stack(
                                  children: <Widget>[
                                    Container(
                                      height: 300,
                                      child: ClipRRect(
                                        borderRadius: BorderRadius.all(
                                          Radius.circular(10.0),
                                        ),
                                        child: Image.network(
                                          snapshot.data!['data'][0]
                                                      ['type_image'] !=
                                                  null
                                              ? Global.domainImagenew +
                                                  snapshot.data!['data'][0]
                                                      ['type_image']
                                              : '${Global.networkImage}',
                                          fit: BoxFit.cover,
                                          width: double.infinity,
                                        ),
                                      ),
                                    ),
                                    Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        SizedBox(height: 60),
                                        Container(
                                          decoration: BoxDecoration(
                                              color: ThemeBc.black,
                                              borderRadius:
                                                  BorderRadius.circular(
                                                10,
                                              ),
                                              boxShadow: [
                                                BoxShadow(
                                                    color: Colors.black
                                                        .withOpacity(0.5),
                                                    offset: Offset(2, 2),
                                                    blurRadius: 7,
                                                    spreadRadius: 1.0),
                                              ]),
                                          child: Padding(
                                            padding: const EdgeInsets.all(8.0),
                                            child: Text(
                                              // '${titles[_currentIndex]}',
                                              '${snapshot.data!['data'][0]['type_name']}',
                                              style: TextStyle(
                                                fontSize: 24.0,
                                                fontWeight: FontWeight.bold,
                                                // backgroundColor: Colors.black45,
                                                color: ThemeBc.white,
                                              ),
                                            ),
                                          ),
                                        ),
                                        SizedBox(height: 40),
                                        Container(
                                          height: 140,
                                          color: Colors.black54,
                                          child: ListView(
                                            children: [
                                              Padding(
                                                padding:
                                                    const EdgeInsets.all(8.0),
                                                child: Text_pane(
                                                    text:
                                                        '  ${snapshot.data!['data'][0]['type_detail']}',
                                                    color: ThemeBc.white,
                                                    fontSize: 15),
                                              )
                                            ],
                                          ),
                                        ),
                                      ],
                                    ),
                                  ],
                                ),
                              ],
                            ),
                          ),
                        ),
                      ),
                    ],
                  );
                } else if (snapshot.hasError) {}

                return Center(child: CircularProgressIndicator());
              },
            ),
          ),
        ],
      ),
    );
  }

  Widget travel03(BuildContext context) {
    bool isLoading = true;
    var hotlinee;
    var productt;
    var detail;

    late Map<String, dynamic> imgSlide;

    int _currentIndex = 0;

    Future<Map<String, dynamic>> getDataSlide() async {
      var url =
          ('https://www.bc-official.com/api/app_nt/api/app/travel/type/restful/?type_app_id=3');
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

    @override
    void initState() {
      super.initState();

      getDataSlide();
    }

    return Container(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SizedBox(height: 5),
          Container(
            height: 320,
            child: FutureBuilder<Map<String, dynamic>>(
              future: getDataSlide(),
              builder: (context, snapshot) {
                if (snapshot.hasData) {
                  return Column(
                    children: [
                      InkWell(
                        onTap: () {
                          Navigator.pushNamed(context, '/travel_page',
                              arguments: {
                                'type_app_id': snapshot.data!['data'][0]
                                    ['type_app_id'],
                                'type_name': snapshot.data!['data'][0]
                                    ['type_name'],
                              });
                        },
                        child: Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Container(
                            child: Column(
                              children: [
                                Stack(
                                  children: <Widget>[
                                    Container(
                                      height: 300,
                                      child: ClipRRect(
                                        borderRadius: BorderRadius.all(
                                          Radius.circular(10.0),
                                        ),
                                        child: Image.network(
                                          snapshot.data!['data'][0]
                                                      ['type_image'] !=
                                                  null
                                              ? Global.domainImagenew +
                                                  snapshot.data!['data'][0]
                                                      ['type_image']
                                              : '${Global.networkImage}',
                                          fit: BoxFit.cover,
                                          width: double.infinity,
                                        ),
                                      ),
                                    ),
                                    Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        SizedBox(height: 60),
                                        Container(
                                          decoration: BoxDecoration(
                                              color: ThemeBc.black,
                                              borderRadius:
                                                  BorderRadius.circular(
                                                10,
                                              ),
                                              boxShadow: [
                                                BoxShadow(
                                                    color: Colors.black
                                                        .withOpacity(0.5),
                                                    offset: Offset(2, 2),
                                                    blurRadius: 7,
                                                    spreadRadius: 1.0),
                                              ]),
                                          child: Padding(
                                            padding: const EdgeInsets.all(8.0),
                                            child: Text(
                                              // '${titles[_currentIndex]}',
                                              '${snapshot.data!['data'][0]['type_name']}',
                                              style: TextStyle(
                                                fontSize: 24.0,
                                                fontWeight: FontWeight.bold,
                                                // backgroundColor: Colors.black45,
                                                color: ThemeBc.white,
                                              ),
                                            ),
                                          ),
                                        ),
                                        SizedBox(height: 40),
                                        Container(
                                          height: 140,
                                          color: Colors.black54,
                                          child: ListView(
                                            children: [
                                              Padding(
                                                padding:
                                                    const EdgeInsets.all(8.0),
                                                child: Text_pane(
                                                    text:
                                                        '  ${snapshot.data!['data'][0]['type_detail']}',
                                                    color: ThemeBc.white,
                                                    fontSize: 15),
                                              )
                                            ],
                                          ),
                                        ),
                                      ],
                                    ),
                                  ],
                                ),
                              ],
                            ),
                          ),
                        ),
                      ),
                    ],
                  );
                } else if (snapshot.hasError) {}

                return Center(child: CircularProgressIndicator());
              },
            ),
          ),
        ],
      ),
    );
  }
}
