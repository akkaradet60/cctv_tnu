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
        body: Container(
          decoration: BoxDecoration(
              gradient: LinearGradient(
                  colors: [Colors.pinkAccent, Colors.orangeAccent],
                  begin: Alignment.topRight,
                  end: Alignment.bottomLeft)),
          child: Padding(
            padding: const EdgeInsets.all(10),
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
                        Padding(
                          padding: const EdgeInsets.all(10.0),
                          child: Card(
                            child: Column(
                              children: [
                                Container(
                                  width: 300,
                                  height: 300,
                                  child: Image.network(
                                      '${productt['productiPathName']}'),
                                  // decoration: BoxDecoration(
                                  //   image: DecorationImage(
                                  //       image: NetworkImage(
                                  //           '${productt['productiPathName']}')),
                                  // ),
                                ),
                              ],
                            ),
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
                                              context, '/shop'),
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
                                          '   ชื่อสินค้า :  ',
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
                                            padding: const EdgeInsets.all(8.0),
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
                          height: 300,
                          width: 400,
                          margin: EdgeInsets.only(top: 0),
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
