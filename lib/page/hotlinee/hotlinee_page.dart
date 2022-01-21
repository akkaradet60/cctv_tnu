import 'package:cctv_tun/models/hotlinee/hotlinee.dart';
import 'package:cctv_tun/page/global/global.dart';
import 'package:cctv_tun/shared/theme.dart';
import 'package:flutter/material.dart';
import 'package:flutter_phone_direct_caller/flutter_phone_direct_caller.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:cctv_tun/widgets/custom_button.dart';

class hotlinee_page extends StatefulWidget {
  hotlinee_page({Key? key}) : super(key: key);

  @override
  _hotlinee_pageState createState() => _hotlinee_pageState();
}

class _hotlinee_pageState extends State<hotlinee_page> {
  List<Data> data = [];
  bool isLoading = true;
  var hotlinee;
  Future<void> getData() async {
    var url = (Global.urlWeb +
        'api/app/hotline/restful/?hotline_app_id=${Global.app_id}');
    var response = await http.get(Uri.parse(url),
        headers: {'Authorization': 'Bearer ${Global.token}'});
    // print(json.decode(response.body));

    if (response.statusCode == 200) {
      // print(json.decode(response.body));
      //นำ json ใส่ที่โมเมล product
      final Hotlinee hotlinee = Hotlinee.fromJson(json.decode(response.body));
      print(hotlinee.data);
      setState(() {
        data = hotlinee.data;
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
      appBar: AppBar(
        title: Center(child: Text('สายด่วน')),
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
      body: SafeArea(
        child: Container(
          decoration: BoxDecoration(
            gradient: LinearGradient(
                colors: [Colors.pinkAccent, Colors.orangeAccent],
                begin: Alignment.topRight,
                end: Alignment.bottomLeft),
          ),
          child: ListView(
            children: [
              SizedBox(height: 5),

              // sss(context),
              hotlineee(context)
              //  ss2(context),
              //  ssto(context),
            ],
          ),
        ),
      ),
    );
  }

  // Widget sss(BuildContext context) {
  //   return Container(
  //     padding: EdgeInsets.symmetric(horizontal: defaultMargin),
  //     margin: EdgeInsets.only(top: 0, bottom: 20),
  //     child: Row(
  //       mainAxisAlignment: MainAxisAlignment.center,
  //       children: [
  //         CustomButton(
  //           title: 'ทดลองใช้ในฐานะผู้เยี่ยมชม',
  //           onPressed: () => Navigator.pushNamed(context, '/hotlinee_page1'),
  //           colorButton: buttonGreyColor,
  //           textStyle:
  //               secondaryTextStyle.copyWith(fontWeight: medium, fontSize: 16),
  //         ),
  //       ],
  //     ),
  //   );
  // }

  Widget hotlineee(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Container(
        height: 500,
        child: Container(
          decoration: BoxDecoration(
              gradient: LinearGradient(
                  colors: [Colors.pinkAccent, Colors.orangeAccent],
                  begin: Alignment.topRight,
                  end: Alignment.bottomLeft)),
          child: isLoading == true
              ? Center(
                  child: CircularProgressIndicator(),
                )
              : ListView.separated(
                  // scrollDirection: Axis.horizontal,
                  itemBuilder: (context, index) {
                    final number = '${data[index].hotlinePhone}';
                    return Center(
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Card(
                            child: ListTile(
                              title: Text(
                                '${data[index].hotlineName}',
                                style: primaryTextStyle.copyWith(
                                    fontSize: 18, fontWeight: medium),
                              ),
                              subtitle: Text(number),
                              trailing: Material(
                                elevation: 18,
                                color: Colors.orange,
                                shadowColor: Colors.grey,
                                child: TextButton(
                                  style: TextButton.styleFrom(
                                      backgroundColor: Colors.orange,
                                      padding: EdgeInsets.symmetric(
                                          horizontal: 32, vertical: 12),
                                      shape: RoundedRectangleBorder(
                                          side: BorderSide(
                                              color: Colors.orange))),
                                  child: Text(
                                    'call',
                                  ),
                                  onPressed: () async {
                                    await FlutterPhoneDirectCaller.callNumber(
                                        number);
                                  },
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                    );
                  },
                  separatorBuilder: (context, index) => Divider(),
                  itemCount: data.length),
        ),
      ),
    );
  }

  // Widget ss2(BuildContext context) {
  //   return Container(
  //     decoration: BoxDecoration(
  //         gradient: LinearGradient(
  //             colors: [Colors.pinkAccent, Colors.orangeAccent],
  //             begin: Alignment.topRight,
  //             end: Alignment.bottomLeft)),
  //     height: 500,
  //     child: ListView.builder(itemBuilder: (context, index) {
  //       return Container(child: Text('${data[1].hotlineId}'));
  //     }),
  //   );
  // }

  // Widget ssto(BuildContext context) {
  //   return Container(
  //     height: 400,
  //     child: Container(
  //       child: ListView.builder(
  //           // scrollDirection: Axis.horizontal,
  //           itemBuilder: (context, index) {
  //             return Center(
  //               child: Column(
  //                 mainAxisAlignment: MainAxisAlignment.center,
  //                 children: [
  //                   InkWell(
  //                     onTap: () {
  //                       Navigator.pushNamed(context, '/productshop_page',
  //                           arguments: {
  //                             /*   'id': data[index].id,
  //                               'detail': data[index].detail,
  //                               'picture': data[index].picture,
  //                               'view': data[index].view,*/
  //                           });
  //                     },
  //                     child: Container(
  //                       margin: EdgeInsets.only(top: 20, bottom: 0),
  //                       child: Row(
  //                         children: [
  //                           SizedBox(width: defaultMargin),
  //                           Container(
  //                             height: 400,
  //                             width: 365,
  //                             decoration: BoxDecoration(
  //                                 color: secondaryTextColor,
  //                                 borderRadius: BorderRadius.circular(
  //                                   24,
  //                                 ),
  //                                 boxShadow: [
  //                                   BoxShadow(
  //                                       color: Colors.grey.withOpacity(0.5),
  //                                       offset: Offset(2, 2),
  //                                       blurRadius: 7,
  //                                       spreadRadius: 1.0),
  //                                   BoxShadow(
  //                                       color: Colors.grey.withOpacity(0.5),
  //                                       offset: Offset(2, 4),
  //                                       blurRadius: 7.0,
  //                                       spreadRadius: 1.0),
  //                                 ]),
  //                             child: Column(
  //                               mainAxisAlignment: MainAxisAlignment.center,
  //                               children: [
  //                                 Column(
  //                                   children: [
  //                                     ClipRRect(
  //                                       borderRadius: const BorderRadius.all(
  //                                         Radius.circular(3.0),
  //                                       ),
  //                                       child: Stack(
  //                                         children: <Widget>[],
  //                                       ),
  //                                     ),
  //                                     SizedBox(height: 15),
  //                                     Container(
  //                                       width: 340,
  //                                       color: Colors.grey[200],
  //                                       height: 100,
  //                                       child: Column(
  //                                         children: [
  //                                           SizedBox(height: 15),
  //                                           Container(
  //                                             child: Text(
  //                                               'ชื่อสินค้า: ',
  //                                               style:
  //                                                   primaryTextStyle.copyWith(
  //                                                       fontSize: 18,
  //                                                       fontWeight: medium),
  //                                             ),
  //                                           ),
  //                                           SizedBox(height: 15),
  //                                           Text(
  //                                             'ราคาสินค้า : บาท',
  //                                             style: primaryTextStyle.copyWith(
  //                                                 fontSize: 20,
  //                                                 fontWeight: medium),
  //                                           ),
  //                                         ],
  //                                       ),
  //                                     )
  //                                   ],
  //                                 )
  //                               ],
  //                             ),
  //                           ),
  //                         ],
  //                       ),
  //                     ),
  //                   ),
  //                 ],
  //               ),
  //             );
  //           },
  //           // separatorBuilder: (context, index) => Divider(),
  //           itemCount: data.length),
  //     ),
  //   );
  // }
}

// Widget buildbutton() {
//   final number1 = '199';
//   return Padding(
//     padding: EdgeInsets.all(8.0),
//     child: Card(
//       child: ListTile(
//         title: Text(
//           'ตำตรวจ',
//           style: primaryTextStyle.copyWith(fontSize: 18, fontWeight: medium),
//         ),
//         subtitle: Text(number1),
//         trailing: Material(
//           elevation: 18,
//           color: Colors.orange,
//           shadowColor: Colors.grey,
//           child: TextButton(
//             style: TextButton.styleFrom(
//                 backgroundColor: Colors.orange,
//                 padding: EdgeInsets.symmetric(horizontal: 32, vertical: 12),
//                 shape: RoundedRectangleBorder(
//                     side: BorderSide(color: Colors.orange))),
//             child: Text(
//               'call',
//             ),
//             onPressed: () async {
//               await FlutterPhoneDirectCaller.callNumber(number1);
//             },
//           ),
//         ),
//       ),
//     ),
//   );
// }

// Widget buildbutton1() {
//   final number = '043-245265';
//   return Padding(
//     padding: EdgeInsets.all(8.0),
//     child: Card(
//       child: ListTile(
//         title: Text(
//           'ศูตรขอนแก่น',
//           style: primaryTextStyle.copyWith(fontSize: 18, fontWeight: medium),
//         ),
//         subtitle: Text(number),
//         trailing: Material(
//           elevation: 18,
//           color: Colors.orange,
//           shadowColor: Colors.grey,
//           child: TextButton(
//             style: TextButton.styleFrom(
//                 backgroundColor: Colors.orange,
//                 padding: EdgeInsets.symmetric(horizontal: 32, vertical: 12),
//                 shape: RoundedRectangleBorder(
//                     side: BorderSide(color: Colors.orange))),
//             child: Text(
//               'call',
//             ),
//             onPressed: () async {
//               await FlutterPhoneDirectCaller.callNumber(number);
//             },
//           ),
//         ),
//       ),
//     ),
//   );
// }

// Widget buildbutton2() {
//   final number = '083-6842051';
//   return Padding(
//     padding: EdgeInsets.all(8.0),
//     child: Card(
//       child: ListTile(
//         title: Text(
//           'ตั้นคนโสดน่าาา',
//           style: primaryTextStyle.copyWith(fontSize: 18, fontWeight: medium),
//         ),
//         subtitle: Text(number),
//         trailing: Material(
//           elevation: 18,
//           color: Colors.orange,
//           shadowColor: Colors.grey,
//           child: TextButton(
//             style: TextButton.styleFrom(
//                 backgroundColor: Colors.orange,
//                 padding: EdgeInsets.symmetric(horizontal: 32, vertical: 12),
//                 shape: RoundedRectangleBorder(
//                     side: BorderSide(color: Colors.orange))),
//             child: Text(
//               'call',
//             ),
//             onPressed: () async {
//               await FlutterPhoneDirectCaller.callNumber(number);
//             },
//           ),
//         ),
//       ),
//     ),
//   );
// }
