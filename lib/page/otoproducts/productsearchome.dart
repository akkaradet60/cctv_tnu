import 'package:cctv_tun/page/global/style/global.dart';
import 'package:cctv_tun/widgets/Text_pane.dart';
import 'package:cctv_tun/widgets/custom_buttonn.dart';

import 'package:flutter/material.dart';

class produsctsearchome extends StatefulWidget {
  produsctsearchome({Key? key}) : super(key: key);

  @override
  State<produsctsearchome> createState() => _produscthomeState();
}

class _produscthomeState extends State<produsctsearchome> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
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
              Center(child: Text('ค้นหา')),
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
                colors: [ThemeBc.orangeAccent, ThemeBc.pinkAccent],
                begin: Alignment.topRight,
                end: Alignment.bottomLeft),
          ),
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Container(
              height: 1000,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Column(
                    children: [
                      SizedBox(height: 20),
                      CustomButton(
                          title: 'ค้นหาสินค้า',
                          onPressed: () {
                            Navigator.pushNamed(
                              context,
                              '/productstore_page',
                            );
                          },
                          colorButton: ThemeBc.white,
                          textStyle: TextStyle(
                            fontSize: 17.0,
                            fontWeight: FontWeight.bold,
                            // backgroundColor: Colors.black45,
                            color: ThemeBc.textblack,
                          )),
                      SizedBox(height: 10),
                      CustomButton(
                          title: 'ค้นหาร้านค้า',
                          onPressed: () {
                            Navigator.pushNamed(
                                context, '/productsearchstore_page',
                                arguments: {});
                          },
                          colorButton: ThemeBc.white,
                          textStyle: TextStyle(
                            fontSize: 17.0,
                            fontWeight: FontWeight.bold,
                            // backgroundColor: Colors.black45,
                            color: ThemeBc.textblack,
                          ))
                    ],
                  ),
                ],
              ),
            ),
          ),
        ));
  }
}
//  Container(
//         height: 300,
//         decoration: BoxDecoration(
//             color: ThemeBc.black,
//             borderRadius: BorderRadius.circular(
//               20,
//             ),
//             boxShadow: [
//               BoxShadow(
//                   color: Colors.black.withOpacity(0.5),
//                   offset: Offset(2, 2),
//                   blurRadius: 7,
//                   spreadRadius: 1.0),
//             ]),
//         child: Column(
//           children: [
//             SizedBox(height: 80),
//             CustomButton(
//                 title: 'ค้นหาสินค้า',
//                 onPressed: () {
//                   Navigator.pushNamed(
//                     context,
//                     '/productstore_page',
//                   );
//                 },
//                 colorButton: ThemeBc.white,
//                 textStyle: TextStyle(
//                   fontSize: 20.0,
//                   fontWeight: FontWeight.bold,
//                   // backgroundColor: Colors.black45,
//                   color: ThemeBc.textblack,
//                 )),
//             SizedBox(height: 10),
//             CustomButton(
//                 title: 'ค้นหาร้านค้า',
//                 onPressed: () {
//                   Navigator.pushNamed(
//                     context,
//                     '/productsearchstore_page',
//                   );
//                 },
//                 colorButton: ThemeBc.white,
//                 textStyle: TextStyle(
//                   fontSize: 20.0,
//                   fontWeight: FontWeight.bold,
//                   // backgroundColor: Colors.black45,
//                   color: ThemeBc.textblack,
//                 ))
//           ],
//         ),
//       ),
