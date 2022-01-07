import 'package:carousel_slider/carousel_slider.dart';
import 'package:cctv_tun/page/manu/manu.dart';
import 'package:cctv_tun/shared/theme.dart';
import 'package:cctv_tun/widgets/menus_custom.dart';
import 'package:flutter/material.dart';

class home_page extends StatefulWidget {
  home_page({Key? key}) : super(key: key);

  @override
  _home_pageState createState() => _home_pageState();
}

class _home_pageState extends State<home_page> {
  @override
  Widget build(BuildContext context) {
    Widget slider() {
      int _curr = 0;
      final List<String> images = [
        'assets/homepage/1.png',
        'assets/homepage/2.png',
        'assets/homepage/3.png',
        'assets/homepage/4.png',
      ];
      final List<String> places = [
        '',
        '',
        '',
        '',
        '',
        '',
      ];
      List<Widget> generateImagesTiles() {
        return images
            .map((element) => ClipRRect(
                  child: Image.asset(
                    element,
                    fit: BoxFit.cover,
                  ),
                  borderRadius: BorderRadius.circular(15.0),
                ))
            .toList();
      }

      return Container(
        padding: const EdgeInsets.only(top: 20),
        child: Stack(
          children: [
            CarouselSlider(
                items: generateImagesTiles(),
                options: CarouselOptions(
                    enlargeCenterPage: true,
                    autoPlay: true,
                    aspectRatio: 35 / 15,
                    onPageChanged: (index, other) {
                      setState(() {
                        _curr = index;
                      });
                    })), //setState
            AspectRatio(
              aspectRatio: 35 / 15,
              child: Center(
                child: Center(
                  child: Text(
                    places[_curr],
                    style: TextStyle(
                        decoration: TextDecoration.none,
                        color: Colors.white,
                        fontSize: MediaQuery.of(context).size.width / 15),
                  ),
                ),
              ),
            )
          ],
        ),
      );
    }

    Widget titleMenus() {
      return Container(
        margin: EdgeInsets.only(top: 30, left: defaultMargin),
        child: Text(
          'เมนู',
          style: primaryTextStyle.copyWith(fontSize: 18, fontWeight: medium),
        ),
      );
    }

    Widget cardMenus() {
      return Container(
          margin: EdgeInsets.only(top: 18),
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 24),
            child: Column(
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    MenusCustom(
                      iconMenus: 'assets/homepage/icon_1.png',
                      titleMenus: 'แจ้งเหตุฉุกเฉิน',
                      pathName: '/warn',
                      titleMenus1: '',
                      titleMenus2: '',
                    ),
                    MenusCustom(
                      iconMenus: 'assets/homepage/icon_2.png',
                      titleMenus: 'ร้องเรียน',
                      pathName: '/hotline',
                      titleMenus1: '',
                      titleMenus2: '',
                    ),
                    MenusCustom(
                      iconMenus: 'assets/homepage/icon_3.png',
                      titleMenus: 'สายด่วน',
                      pathName: '/appeal',
                      titleMenus1: '',
                      titleMenus2: '',
                    ),
                  ],
                ),
                SizedBox(height: 18),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    MenusCustom(
                      iconMenus: 'assets/homepage/icon_4.png',
                      titleMenus: 'ข่าวสาร',
                      pathName: '/message',
                      titleMenus1: '',
                      titleMenus2: '',
                    ),
                    MenusCustom(
                      iconMenus: 'assets/homepage/icon_5.png',
                      titleMenus: 'ปฎิทินการอบรม',
                      pathName: '/trainingcalendar',
                      titleMenus1: '',
                      titleMenus2: '',
                    ),
                    MenusCustom(
                      iconMenus: 'assets/homepage/icon_6.png',
                      titleMenus: 'CCTV',
                      pathName: '/cctv',
                      titleMenus2: '',
                      titleMenus1: '',
                    ),
                  ],
                ),
              ],
            ),
          ));
    }

    Widget cardMenus1() {
      return Container(
        margin: EdgeInsets.only(top: 18),
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 24),
          child: Column(
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  MenusCustom(
                    iconMenus: 'assets/homepage/icon_7.png',
                    titleMenus: 'รางวัล',
                    pathName: '/reward',
                    titleMenus1: '',
                    titleMenus2: '',
                  ),
                  MenusCustom(
                    iconMenus: 'assets/homepage/icon_8.png',
                    titleMenus: 'YOUTUBE',
                    pathName: '/youtube',
                    titleMenus1: '',
                    titleMenus2: '',
                  ),
                  MenusCustom(
                    iconMenus: 'assets/homepage/icon_9.png',
                    titleMenus: 'คู่มือการใช้งาน',
                    pathName: '/help',
                    titleMenus1: '',
                    titleMenus2: '',
                  ),
                ],
              ),
              SizedBox(height: 18),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  MenusCustom(
                    iconMenus: 'assets/homepage/icon_10.png',
                    titleMenus: 'ท่องเที่ยว',
                    pathName: '/travel',
                    titleMenus1: '',
                    titleMenus2: '',
                  ),
                  MenusCustom(
                    iconMenus: 'assets/homepage/icon_11.png',
                    titleMenus: 'สินค้า OTOP',
                    pathName: '/otopproducts',
                    titleMenus1: '',
                    titleMenus2: '',
                  ),
                  MenusCustom(
                    iconMenus: 'assets/homepage/icon_12.png',
                    titleMenus: 'สถานที่ราชการ',
                    pathName: '/testmaps',
                    titleMenus1: '',
                    titleMenus2: '',
                  ),
                ],
              ),
            ],
          ),
        ),
      );
    }

    return Scaffold(
      drawer: manu(),
      appBar: AppBar(
        title: const Text('เทศบาลเมืองมหาสารคาม'),
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
      body: SafeArea(
        child: Container(
          decoration: BoxDecoration(
              gradient: LinearGradient(
                  colors: [Colors.pinkAccent, Colors.orangeAccent],
                  begin: Alignment.topRight,
                  end: Alignment.bottomLeft)),
          child: ListView(
            children: [
              slider(),
              titleMenus(),
              cardMenus(),
              cardMenus1(),
              SizedBox(height: 111),
            ],
          ),
        ),
      ),
    );
  }
}
