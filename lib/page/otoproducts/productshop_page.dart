import 'package:cctv_tun/shared/theme.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class productshop_page extends StatefulWidget {
  productshop_page({Key? key}) : super(key: key);

  @override
  _productsState createState() => _productsState();
}

class _productsState extends State<productshop_page> {
  var productt;
  var detail;
  bool isLoading = true;

  get defaultMargin => null;
  Future<void> getData(String picture) async {
    var url = Uri.parse('https://api.codingthailand.com/api/course/');
    var response = await http.get(url);
    if (response.statusCode == 200) {
      // print(json.decode(response.body));
      //นำ json ใส่ที่โมเมล product
      detail = json.decode(response.body);
      return detail;
      // final product paroduct = product.fromJson(json.decode(response.body));
      // print(paroduct.data);
      //setState(() {
      //   data = paroduct.data!;
      //   isLoading = false;
      // });
    } else {
      // setState(() {
      //    isLoading = false;
      //  });
      //  print('error 400');
      throw Exception('erroe');
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
      _product1 = int.parse('${productt['view']}');
      setState(() {
        _counter++;
        _product = _product + _product1;
      });
    }

    void _incrementCounterp() {
      setState(() {
        _product1 = int.parse('${productt['view']}');
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

    productt = ModalRoute.of(context)!.settings.arguments;
    return Scaffold(
      appBar: AppBar(
        title: const Text('สินค้า'),
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
      body: FutureBuilder<dynamic>(
          future: getData(productt['picture']),
          builder: (context, snapshot) {
            if (snapshot.hasData) {
              return ListView.separated(
                  itemBuilder: (context, index) {
                    return Container(
                      margin: EdgeInsets.only(
                        top: 10,
                      ),
                      child: Container(
                        color: Colors.grey,
                        margin: const EdgeInsets.symmetric(horizontal: 15),
                        child: Column(
                          children: [
                            Container(
                              child: Card(
                                child: Container(
                                  decoration: BoxDecoration(
                                    image: DecorationImage(
                                        image: NetworkImage(
                                            '${productt['picture']}')),
                                  ),
                                ),
                              ),
                              height: 300,
                              width: 400,
                              margin: EdgeInsets.only(top: 0),
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
                                              Icons.shopping_bag_outlined,
                                              color: Colors.red,
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
                                              onPressed: () =>
                                                  Navigator.pushNamed(context,
                                                      '/products_page'),
                                            )
                                          ],
                                        ),
                                      ),
                                      Container(
                                        color: Colors.pink[200],
                                        child: Row(
                                          children: [
                                            Icon(
                                              Icons.favorite,
                                              color: Colors.red,
                                              size: 40,
                                            ), //'${productt['view']
                                            Container(
                                              width: 300,
                                              child: Text(
                                                '   ชื่อสินค้า : ${productt['detail']} ',
                                                style:
                                                    primaryTextStyle.copyWith(
                                                  fontSize: 15,
                                                ),
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
                                                            primary: Colors
                                                                .orange[300],
                                                            onPrimary:
                                                                Colors.black,
                                                          ),
                                                          child: Text(
                                                            '-',
                                                            style: primaryTextStyle
                                                                .copyWith(
                                                                    fontSize:
                                                                        20,
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
                                                  style:
                                                      primaryTextStyle.copyWith(
                                                          fontSize: 25,
                                                          fontWeight:
                                                              FontWeight.bold,
                                                          height: 2),
                                                ),
                                                SizedBox(
                                                  width: 10,
                                                ),
                                                ElevatedButton(
                                                    style: ElevatedButton
                                                        .styleFrom(
                                                      primary:
                                                          Colors.orange[300],
                                                      onPrimary: Colors.black,
                                                    ),
                                                    child: Text(
                                                      '+',
                                                      style: primaryTextStyle
                                                          .copyWith(
                                                              fontSize: 20,
                                                              fontWeight:
                                                                  FontWeight
                                                                      .bold,
                                                              height: 2),
                                                    ),
                                                    onPressed:
                                                        _incrementCounter)
                                              ],
                                            )
                                          ],
                                        ),
                                      ),
                                      Container(
                                        height: 55,
                                        color: Colors.grey[200],
                                        child: Row(
                                          children: [
                                            Text(
                                              '   รายละเอียดสินค้า : ',
                                              style: primaryTextStyle.copyWith(
                                                fontSize: 15,
                                              ),
                                            ),
                                          ],
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                              height: 300,
                              width: 400,
                              margin: EdgeInsets.only(top: 0),
                            ),
                          ],
                        ),
                      ),
                    );
                  },
                  separatorBuilder: (context, index) => Divider(),
                  itemCount: snapshot.data.length);
            } else if (snapshot.hasError) {
              return Text('data');
            }
            return Center(
              child: CircularProgressIndicator(),
            );
          }),
    );
  }
}
