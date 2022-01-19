import 'package:cctv_tun/models/product/bestseller.dart';
import 'package:cctv_tun/page/global/global.dart';
import 'package:cctv_tun/shared/theme.dart';

import 'package:flutter/material.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

import 'package:shared_preferences/shared_preferences.dart';

class productshome_page extends StatefulWidget {
  productshome_page({Key? key}) : super(key: key);

  @override
  _nameState createState() => _nameState();
}

class _nameState extends State<productshome_page> {
  // List<Data> data = [];
  // bool isLoading = true;
  // Future<void> getData() async {
  //   var url =
  //       'https://www.bc-official.com/api/app_nt/api/app/otop/best-seller-product/restful/?product_app_id=${Global.app_id}';
  //   var response = await http.get(Uri.parse(url),
  //       headers: {'Authorization': 'Bearer ${Global.token}'});
  //   if (response.statusCode == 200) {
  //     // print(json.decode(response.body));
  //     //นำ json ใส่ที่โมเมล product
  //     final BestSeller paroduct =
  //         BestSeller.fromJson(json.decode(response.body));
  //     print(paroduct.data);
  //     setState(() {
  //       data = paroduct.data!;
  //       isLoading = false;
  //     });
  //   } else {
  //     setState(() {
  //       isLoading = false;
  //     });
  //     print('error 400');
  //   }
  // }

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

    getProfile();
  }

  // late Map< String,dynamic> profile;

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
      body: FormBuilder(
        child: SafeArea(
          child: Container(
            decoration: BoxDecoration(
                gradient: LinearGradient(
                    colors: [Colors.pinkAccent, Colors.orangeAccent],
                    begin: Alignment.topRight,
                    end: Alignment.bottomLeft)),
            margin: EdgeInsets.only(top: 15),
            child: ListView(
              children: [
                /* ListView.builder(
                    itemBuilder: (context, index) {
                      return Center(
                        child: Column(
                          children: [],
                        ),
                      );
                    },
                    itemCount: data.length),*/
                Container(
                  color: Colors.orange,
                  child: SafeArea(
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          const Padding(
                            padding: const EdgeInsets.symmetric(
                                horizontal: 0, vertical: 0),
                          ),
                          Material(
                            elevation: 18,
                            shadowColor: Colors.grey.withOpacity(0.5),
                            child: TextField(
                              decoration: InputDecoration(
                                suffixIcon: IconButton(
                                  icon: Icon(Icons.search),
                                  onPressed: () => Navigator.pushNamed(
                                      context, '/otopproductssearch'),
                                ),
                                labelText: 'ค้นหา',
                                fillColor: Colors.white,
                                filled: true,
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
                Container(
                  margin: EdgeInsets.only(
                      top: 5, left: defaultMargin, right: defaultMargin),
                  width: 300,
                  child: Image.network(
                      'https://district.cdd.go.th/bangkruai/wp-content/uploads/sites/308/2021/02/logo_img1599704122.png'),
                ),
                Container(
                  margin: EdgeInsets.only(
                      top: 5, left: defaultMargin, right: defaultMargin),
                  color: Colors.transparent,
                  width: 342,
                  height: 50,
                  child: Container(
                    child: ElevatedButton(
                      onPressed: () =>
                          Navigator.pushNamed(context, '/products_page'),
                      child: Text(
                        'สินค้า OTOP',
                        style: primaryTextStyle.copyWith(
                            fontSize: 20,
                            fontWeight: FontWeight.bold,
                            color: Colors.white),
                      ),
                      style: ElevatedButton.styleFrom(
                        primary: Colors.brown[900],
                        onPrimary: Colors.white,
                        shadowColor: Colors.grey[700],
                        elevation: 30,
                        shape: const RoundedRectangleBorder(
                            borderRadius:
                                BorderRadius.all(Radius.circular(40))),
                      ),
                    ),
                  ),
                ),
                SizedBox(height: 5),
                Container(
                  margin: EdgeInsets.only(
                      top: 5, left: defaultMargin, right: defaultMargin),
                  color: Colors.transparent,
                  width: 342,
                  height: 50,

                  //    decoration: BoxDecoration(
                  //  color: secondaryTextColor,
                  //  borderRadius: BorderRadius.circular(
                  //  40,
                  //  ),
                  child: Container(
                    child: ElevatedButton(
                      //probestseller_page
                      onPressed: () =>
                          Navigator.pushNamed(context, '/probestseller_page'),
                      child: Text(
                        'สินค้าขายดีอาทิตย์นี้',
                        style: primaryTextStyle.copyWith(
                            fontSize: 20,
                            fontWeight: FontWeight.bold,
                            color: Colors.white),
                      ),
                      style: ElevatedButton.styleFrom(
                        primary: Colors.brown[900],
                        onPrimary: Colors.white,
                        shadowColor: Colors.grey[700],
                        elevation: 30,
                        shape: const RoundedRectangleBorder(
                            borderRadius:
                                BorderRadius.all(Radius.circular(40))),
                      ),
                    ),
                  ),
                ),
                SizedBox(height: 5),
                Container(
                  margin: EdgeInsets.only(
                      top: 5, left: defaultMargin, right: defaultMargin),
                  color: Colors.transparent,
                  width: 342,
                  height: 50,
                  child: Container(
                    child: ElevatedButton(
                      //propopular_page
                      onPressed: () =>
                          Navigator.pushNamed(context, '/propopular_page'),
                      child: Text(
                        'ยอดนิยมประจำสัปดาห์',
                        style: primaryTextStyle.copyWith(
                            fontSize: 20,
                            fontWeight: FontWeight.bold,
                            color: Colors.white),
                      ),
                      style: ElevatedButton.styleFrom(
                        primary: Colors.brown[900],
                        onPrimary: Colors.white,
                        shadowColor: Colors.grey[700],
                        elevation: 30,
                        shape: const RoundedRectangleBorder(
                            borderRadius:
                                BorderRadius.all(Radius.circular(40))),
                      ),
                    ),
                  ),
                ),
                SizedBox(height: 10),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget customBottomNav() {
    return Container(
      height: 60,
      child: BottomAppBar(
          shape: CircularNotchedRectangle(),
          notchMargin: 5,
          color: Colors.pink,
          clipBehavior: Clip.antiAlias,
          child: Column(
            children: [
              Row(
                children: [
                  SizedBox(
                    width: 20,
                  ),
                  IconButton(
                    icon: Image.asset(
                      'assets/fi_home.png',
                      scale: 1,
                    ),
                    tooltip: 'Show Snackbar',
                    onPressed: () => Navigator.pushNamed(
                        context, '/productshome_page'), //productshome_page
                  ),
                  SizedBox(
                    width: 260,
                  ),
                  IconButton(
                    icon: Image.asset(
                      'assets/10.png',
                      scale: 1,
                      color: Colors.red[900],
                    ),
                    tooltip: 'Show Snackbar',
                    onPressed: () =>
                        Navigator.pushNamed(context, '/otopproductslike'),
                  ),
                ],
              ),
            ],
          )),
    );
  }
}
