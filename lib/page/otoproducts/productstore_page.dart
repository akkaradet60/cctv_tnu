import 'dart:async';

import 'package:cctv_tun/models/api/books_api.dart';
import 'package:cctv_tun/models/model/product.dart';
import 'package:cctv_tun/page/global/global.dart';
import 'package:cctv_tun/page/global/style/global.dart';
import 'package:cctv_tun/widgets/search_widget.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class productstore_page extends StatefulWidget {
  @override
  _productstore_page createState() => _productstore_page();
}

class _productstore_page extends State<productstore_page> {
  late Map<String, dynamic> imgSlide;

  int _currentIndex = 0;

  Future<Map<String, dynamic>> getDataSlide() async {
    var url = (Global.urlWeb +
        'api/app/blog/restful/?blog_app_id=${Global.app_id}&blog_cat_id=${Global.glog_catid}');
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

  List<product> books = [];
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
          title: Center(child: Text('ค้นหา OTOP')),
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

  Widget buildBook(product productt) => Padding(
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
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: ClipRRect(
                  borderRadius: BorderRadius.all(
                    Radius.circular(20.0),
                  ),
                  child: Image.network(
                    Global.domainImagenew + productt.urlImage,
                    fit: BoxFit.cover,
                    width: 210,
                    height: 230,
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Container(
                  width: 150,
                  decoration: BoxDecoration(
                      color: ThemeBc.black,
                      borderRadius: BorderRadius.circular(
                        20,
                      ),
                      boxShadow: [
                        // BoxShadow(
                        //     color: Colors.grey.withOpacity(0.5),
                        //     offset: Offset(2, 2),
                        //     blurRadius: 7,
                        //     spreadRadius: 1.0),
                        // BoxShadow(
                        //     color: Colors.black.withOpacity(0.5),
                        //     offset: Offset(2, 4),
                        //     blurRadius: 7.0,
                        //     spreadRadius: 1.0),
                      ]),
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'ชื่อสินค้า : ${productt.title}',
                          style: TextStyle(
                            fontSize: 15.0,
                            fontWeight: FontWeight.bold,
                            // backgroundColor: Colors.black45,
                            color: ThemeBc.white,
                          ),
                        ),
                        SizedBox(height: 5),
                        Text(
                          'เนื่อหาสิ้นค้า : ${productt.author}',
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
