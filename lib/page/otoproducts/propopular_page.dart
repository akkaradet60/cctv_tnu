import 'package:cctv_tun/models/product/bestseller.dart';
import 'package:cctv_tun/page/global/global.dart';

import 'package:cctv_tun/shared/theme.dart';

import 'package:flutter/material.dart';

import 'package:http/http.dart' as http;
import 'dart:convert';

import 'package:shared_preferences/shared_preferences.dart';

class propopular_page extends StatefulWidget {
  propopular_page({Key? key}) : super(key: key);

  @override
  _otopproductsState createState() => _otopproductsState();
}

class _otopproductsState extends State<propopular_page> {
  List<Data> data = [];
  bool isLoading = true;
  var productt;
  Future<void> getData() async {
    var url =
        'https://www.bc-official.com/api/app_nt/api/app/otop/popular-product/restful/?product_app_id=${Global.app_id}';
    var response = await http.get(Uri.parse(url),
        headers: {'Authorization': 'Bearer ${Global.token}'});
    // print(json.decode(response.body));

    if (response.statusCode == 200) {
      // print(json.decode(response.body));
      //นำ json ใส่ที่โมเมล product
      final BestSeller paroduct =
          BestSeller.fromJson(json.decode(response.body));
      print(paroduct.data);
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

  Future<void> getProfile() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();

    Map<String, dynamic> appToken =
        json.decode(prefs.getString('token').toString());
    // print(appToken['access_token']);

    setState(() {
      Global.token = appToken['access_token'];
    });

    var newProfile = json.decode(prefs.getString('profile').toString());
    var newApplication = json.decode(prefs.getString('application').toString());
    // print(newProfile);
    // print(newApplication);
    //call redux action
    /* final store = StoreProvider.of<AppState>(context);
    store.dispatch(updateProfileAction(newProfile));
    store.dispatch(updateApplicationAction(newApplication));*/
  }

  @override
  void initState() {
    super.initState();
    getData();
    getProfile();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      bottomNavigationBar: customBottomNav(),
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
            ? Center(
                child: CircularProgressIndicator(),
              )
            : ListView.builder(
                // scrollDirection: Axis.horizontal,
                itemBuilder: (context, index) {
                  var app_image = data[index].productImage![0] != null
                      ? data[index].productImage![0].productiPathName
                      : 'https://upload.wikimedia.org/wikipedia/commons/thumb/c/c7/555.jpg/1024px-555.jpg';

                  //  var   app_image = data[index].productImage![0].productiPathName ??
                  //         'https://upload.wikimedia.org/wikipedia/commons/thumb/c/c7/555.jpg/1024px-555.jpg';

                  return Center(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        InkWell(
                          onTap: () {
                            Navigator.pushNamed(context, '/productshop_page',
                                arguments: {
                                  'productName': data[index].productName,
                                  'productPrice': data[index].productPrice,
                                  'productiPathName': data[index]
                                          .productImage![0]
                                          .productiPathName ??
                                      'https://upload.wikimedia.org/wikipedia/commons/thumb/c/c7/555.jpg/1024px-555.jpg',

                                  /*   'id': data[index].id,
                                'detail': data[index].detail,
                                'picture': data[index].picture,
                                'view': data[index].view,*/
                                });
                          },
                          child: Container(
                            margin: EdgeInsets.only(top: 20, bottom: 0),
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
                                            color: Colors.grey.withOpacity(0.5),
                                            offset: Offset(2, 2),
                                            blurRadius: 7,
                                            spreadRadius: 1.0),
                                        BoxShadow(
                                            color: Colors.grey.withOpacity(0.5),
                                            offset: Offset(2, 4),
                                            blurRadius: 7.0,
                                            spreadRadius: 1.0),
                                      ]),
                                  child: Column(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      Column(
                                        children: [
                                          Padding(
                                            padding: const EdgeInsets.all(10.0),
                                            child: Container(
                                                child: Image.network(
                                              app_image!,
                                              width: 200,
                                            )),
                                          ),
                                          SizedBox(height: 15),
                                          Container(
                                            width: 340,
                                            color: Colors.grey[200],
                                            height: 100,
                                            child: Column(
                                              children: [
                                                SizedBox(height: 15),
                                                Container(
                                                  child: Text(
                                                    'ชื่อสินค้า: ',
                                                    style: primaryTextStyle
                                                        .copyWith(
                                                            fontSize: 18,
                                                            fontWeight: medium),
                                                  ),
                                                ),
                                                SizedBox(height: 15),
                                                Text(
                                                  'ราคาสินค้า : ${data[index].productPrice} บาท',
                                                  style:
                                                      primaryTextStyle.copyWith(
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
                      ],
                    ),
                  );
                },
                // separatorBuilder: (context, index) => Divider(),
                itemCount: data.length),
      ),
    );
  }

  Widget customBottomNav() {
    return SingleChildScrollView(
      padding: const EdgeInsets.all(8.0),
      child: Container(
        height: 100,
        child: BottomAppBar(
            shape: CircularNotchedRectangle(),
            notchMargin: 5,
            color: Colors.pink,
            clipBehavior: Clip.antiAlias,
            child: Row(
              children: [
                Container(
                  margin: EdgeInsets.only(
                    top: 5,
                    left: 50,
                  ),
                  width: 80,
                  child: Image.network(
                      'https://district.cdd.go.th/bangkruai/wp-content/uploads/sites/308/2021/02/logo_img1599704122.png'),
                ),
                Container(
                  padding: EdgeInsets.symmetric(horizontal: 10),
                  child: Text(
                    'สินค้า OTOP ทั้งหมด',
                    style: primaryTextStyle.copyWith(
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                        color: Colors.white),
                  ),
                )
              ],
            )),
      ),
    );
  }
}
