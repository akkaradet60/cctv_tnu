import 'dart:async';

import 'package:cctv_tun/models/model/product_store.dart';
import 'package:cctv_tun/models/search/search_store.dart';
import 'package:cctv_tun/page/global/global.dart';
import 'package:cctv_tun/page/global/style/global.dart';
import 'package:cctv_tun/widgets/search_widget.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class productsearchstore_page extends StatefulWidget {
  @override
  _productstore_page createState() => _productstore_page();
}

class _productstore_page extends State<productsearchstore_page> {
  // Future<Map<String, dynamic>> getDataSlide() async {
  //   var url = (Global.urlWeb +
  //       'api/app/blog/restful/?blog_app_id=${Global.app_id}&blog_cat_id=1');
  //   var response = await http.get(Uri.parse(url), headers: {
  //     'Authorization':
  //         'Bearer ${Global.token ?? "eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJ1c2VybmFtZSI6IjFAZ21haWwuY29tIiwiZXhwIjoxNjcxNTY2NjU4fQ.uSP6DuFYLScksvlgYZbHPEVG8FaQYGZjk37IZoOlGbg"}'
  //   });

  //   if (response.statusCode == 200) {
  //     imgSlide = json.decode(response.body);

  //     // print(imgSlide['data'].length);
  //     return imgSlide;
  //   } else {
  //     throw Exception('$response.statusCode');
  //   }
  // }

  List<product_store> books = [];
  String query = '';
  Timer? debouncer;

  @override
  void initState() {
    super.initState();

    init();
  }

  @override
  void dispose() {
    debouncer?.cancel();
    super.dispose();
  }

  void debounce(
    VoidCallback callback, {
    Duration duration = const Duration(milliseconds: 1000),
  }) {
    if (debouncer != null) {
      debouncer!.cancel();
    }

    debouncer = Timer(duration, callback);
  }

  Future init() async {
    final books = await BooksApi.getBooks(query);

    setState(() => this.books = books);
  }

  @override
  Widget build(BuildContext context) => Scaffold(
        appBar: AppBar(
          centerTitle: true,
          iconTheme: IconThemeData(
            color: ThemeBc.white, //change your color here
          ),
          shadowColor: ThemeBc.white,
          foregroundColor: ThemeBc.white,
          backgroundColor: ThemeBc.background,
          title: Column(
            children: [
              Center(child: Text('ค้นหา ร้านค้า OTOP')),
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
          color: ThemeBc.white,
          child: Column(
            children: <Widget>[
              buildSearch(),
              Expanded(
                child: ListView.builder(
                  itemCount: books.length,
                  itemBuilder: (context, index) {
                    final book = books[index];

                    return buildBook(book);
                  },
                ),
              ),
            ],
          ),
        ),
      );

  Widget buildSearch() => Padding(
        padding: const EdgeInsets.all(8.0),
        child: Container(
          decoration: BoxDecoration(
              color: ThemeBc.white,
              borderRadius: BorderRadius.circular(
                20,
              ),
              boxShadow: [
                BoxShadow(
                    color: Colors.black.withOpacity(0.5),
                    offset: Offset(2, 2),
                    blurRadius: 7,
                    spreadRadius: 1.0),
              ]),
          child: SearchWidget(
            text: query,
            hintText: 'ค้นหา สินค้า',
            onChanged: searchBook,
          ),
        ),
      );

  Future searchBook(String query) async => debounce(() async {
        final books = await BooksApi.getBooks(query);

        if (!mounted) return;

        setState(() {
          this.query = query;
          this.books = books;
        });
      });

  Widget buildBook(product_store productt) => Padding(
        padding: const EdgeInsets.all(8.0),
        child: Container(
          height: 250,
          decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(
                20,
              ),
              boxShadow: [
                BoxShadow(
                    color: Colors.black.withOpacity(0.5),
                    offset: Offset(2, 2),
                    blurRadius: 7,
                    spreadRadius: 1.0),
              ]),
          child: ListView(
            scrollDirection: Axis.horizontal,
            children: [
              InkWell(
                onTap: () {
                  Navigator.pushNamed(context, '/productstorehome', arguments: {
                    'otop_id': productt.otop_id,
                    'otop_dateil': productt.otop_dateil,
                    'otop_name': productt.otop_name,
                    'otop_lat': productt.otop_lat,
                    'otop_image': productt.otop_image != null
                        ? Global.domainImage + productt.otop_image
                        : Global.domainImage,
                  });
                },
                child: Container(
                  child: Row(
                    children: [
                      Padding(
                        padding: const EdgeInsets.all(2.0),
                        child: ClipRRect(
                          borderRadius: BorderRadius.all(
                            Radius.circular(20.0),
                          ),
                          child: Image.network(
                            Global.domainImage + productt.otop_image != null
                                ? Global.domainImage + productt.otop_image
                                : Global.domainImage,
                            fit: BoxFit.cover,
                            width: 210,
                            height: 250,
                          ),
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.all(2.0),
                        child: Container(
                          width: 175,
                          decoration: BoxDecoration(
                              color: ThemeBc.black,
                              borderRadius: BorderRadius.circular(
                                20,
                              ),
                              boxShadow: []),
                          child: Padding(
                            padding: const EdgeInsets.all(5.0),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Center(
                                  child: Text(
                                    'ชื่อร้านค้า : ${productt.otop_name}',
                                    style: TextStyle(
                                      fontSize: 15.0,
                                      fontWeight: FontWeight.bold,
                                      // backgroundColor: Colors.black45,
                                      color: ThemeBc.white,
                                    ),
                                  ),
                                ),
                                Center(
                                  child: Text(
                                    'id : ${productt.otop_id}',
                                    style: TextStyle(
                                      fontSize: 15.0,
                                      fontWeight: FontWeight.bold,
                                      // backgroundColor: Colors.black45,
                                      color: ThemeBc.white,
                                    ),
                                  ),
                                ),
                                SizedBox(height: 10),
                                Text(
                                  'ร้านนี้ : ${productt.otop_dateil}',
                                  style: TextStyle(
                                    fontSize: 15.0,
                                    fontWeight: FontWeight.bold,
                                    // backgroundColor: Colors.black45,
                                    color: ThemeBc.white,
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
              ),

              // ListTile(
              //   leading: Image.network(
              //     Global.domainImage + book.urlImage,
              //     fit: BoxFit.cover,
              //     width: 200,
              //     height: 500,
              //   ),
              //   title: Text('${book.title}'),
              //   subtitle: Text('${book.author}'),
              // ),
            ],
          ),
        ),
      );
}