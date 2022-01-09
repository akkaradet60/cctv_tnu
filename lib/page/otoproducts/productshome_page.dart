import 'package:cctv_tun/shared/theme.dart';
import 'package:cctv_tun/widgets/menus_custom.dart';
import 'package:cctv_tun/widgets/menus_otoppro.dart';
import 'package:flutter/material.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';

class productshome_page extends StatelessWidget {
  const productshome_page({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    Widget imageSplash() {
      return Container(
        color: Colors.orange,
        height: 100,
        width: 10,
        child: SafeArea(
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Padding(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 0, vertical: 0),
                ),
                Material(
                  elevation: 18,
                  shadowColor: Colors.grey.withOpacity(0.5),
                  child: TextField(
                    decoration: InputDecoration(
                      suffixIcon: IconButton(
                        icon: Icon(Icons.search),
                        onPressed: () =>
                            Navigator.pushNamed(context, '/otopproductssearch'),
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
      );
    }

    Widget customBottomNav() {
      return Container(
        height: 50,
        child: BottomAppBar(
          color: Colors.pinkAccent,
          shape: CircularNotchedRectangle(),
          notchMargin: 5,
          clipBehavior: Clip.antiAlias,
          child: Row(
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
                onPressed: () {
                  ScaffoldMessenger.of(context).showSnackBar(
                      const SnackBar(content: Text('สินค้า OTOP')));
                },
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
        ),
      );
    }

    Widget newproduct() {
      return FormBuilder(
        child: SafeArea(
          child: Container(
            margin: EdgeInsets.only(top: 15),
            child: Column(
              children: [
                Container(
                  width: 300,
                  child: Image.network(
                      'https://district.cdd.go.th/bangkruai/wp-content/uploads/sites/308/2021/02/logo_img1599704122.png'),
                ),
                Container(
                  margin: EdgeInsets.only(top: 15),
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
                SizedBox(height: 10),
                Container(
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
                      onPressed: () {},
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
                SizedBox(height: 10),
                Container(
                  color: Colors.transparent,
                  width: 342,
                  height: 50,
                  child: Container(
                    child: ElevatedButton(
                      onPressed: () {},
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
              ],
            ),
          ),
        ),
      );
    }

    return Scaffold(
      // bottomNavigationBar: customBottomNav(),
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
        child: SafeArea(
          child: ListView(
            children: [
              imageSplash(),
              SizedBox(height: 10),
              newproduct(),
              SizedBox(height: 50),
            ],
          ),
        ),
      ),
    );
  }
}
