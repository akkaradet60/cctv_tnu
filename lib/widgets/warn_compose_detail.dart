import 'package:cctv_tun/page/global/style/global.dart';
import 'package:flutter/material.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:google_fonts/google_fonts.dart';

class W_C_Detali extends StatelessWidget {
  final String name;
  final String name02;
  final Function() onPressed;
  W_C_Detali({
    Key? key,
    required this.name,
    required this.name02,
    required this.onPressed,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
          color: secondaryTextColor,
          borderRadius: BorderRadius.circular(
            10,
          ),
          boxShadow: [
            BoxShadow(
                color: Colors.black.withOpacity(0.1),
                offset: Offset(2, 2),
                blurRadius: 2,
                spreadRadius: 1.0),
          ]),
      height: 80,
      child: Center(
        child: Padding(
          padding: const EdgeInsets.all(10.0),
          child: Column(
            // mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Container(
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        SizedBox(height: 10),
                        Text(
                          name,
                          style: GoogleFonts.sarabun(
                            textStyle: TextStyle(
                              color: ThemeBc.app_textblack_color,
                              fontWeight: FontWeight.bold,
                              fontSize: 15,
                            ),
                          ),
                        ),
                        SizedBox(height: 5),
                        Container(
                          width: 200,
                          height: 20,
                          child: ListView(
                            children: [
                              Text(
                                name02,
                                style: GoogleFonts.sarabun(
                                  textStyle: TextStyle(
                                    color: ThemeBc.app_textblack_color,
                                    fontWeight: FontWeight.w400,
                                    fontSize: 13,
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                    Container(
                      child: IconButton(
                        icon: Icon(
                          Icons.article,
                          color: ThemeBc.app_textblack_color,
                          size: 30,
                        ),
                        tooltip: 'Show Snackbar',
                        onPressed: onPressed,
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
//  'em_status': snapshot.data!['data'][index]
//                                           ['em_status'],
  
  
  // Container(
  //                                         child: Row(
  //                                           mainAxisAlignment:
  //                                               MainAxisAlignment.spaceBetween,
  //                                           children: [
  //                                             Column(
  //                                               crossAxisAlignment:
  //                                                   CrossAxisAlignment.start,
  //                                               children: [
  //                                                 SizedBox(height: 10),
  //                                                 Text(
  //                                                   '${snapshot.data!['data'][index]['em_detail']}',
  //                                                   style: primaryTextStyle
  //                                                       .copyWith(
  //                                                           fontSize: 18,
  //                                                           fontWeight: medium),
  //                                                 ),
  //                                               ],
  //                                             ),
  //                                             Container(
  //                                               decoration: BoxDecoration(
  //                                                   color: ThemeBc.black,
  //                                                   borderRadius:
  //                                                       BorderRadius.circular(
  //                                                     30,
  //                                                   ),
  //                                                   boxShadow: [
  //                                                     BoxShadow(
  //                                                         color: Colors.grey
  //                                                             .withOpacity(0.5),
  //                                                         offset: Offset(2, 2),
  //                                                         blurRadius: 7,
  //                                                         spreadRadius: 1.0),
  //                                                     BoxShadow(
  //                                                         color: Colors.black
  //                                                             .withOpacity(0.5),
  //                                                         offset: Offset(2, 4),
  //                                                         blurRadius: 7.0,
  //                                                         spreadRadius: 1.0),
  //                                                   ]),
  //                                               child: IconButton(
  //                                                 icon: Icon(
  //                                                   Icons.article,
  //                                                   color: ThemeBc.app_white_color,
  //                                                   size: 30,
  //                                                 ),
  //                                                 tooltip: 'Show Snackbar',
  //                                                 onPressed: () =>
  //                                                     Navigator.pushNamed(
  //                                                         context,
  //                                                         '/composedetail_page',
  //                                                         arguments: {
  //                                                       'em_owner': snapshot
  //                                                               .data!['data']
  //                                                           [index]['em_owner'],
  //                                                       'em_detail': snapshot
  //                                                               .data!['data'][
  //                                                           index]['em_detail'],
  //                                                       'em_images': snapshot.data![
  //                                                                           'data']
  //                                                                       [index][
  //                                                                   'em_images'] !=
  //                                                               null
  //                                                           ? Global.domainImage +
  //                                                               snapshot.data!['data']
  //                                                                           [index]
  //                                                                       [
  //                                                                       'em_images'][0]
  //                                                                   [
  //                                                                   'emi_path_name']
  //                                                           : '${Global.networkImage}',
  //                                                       'em_phone': snapshot
  //                                                               .data!['data']
  //                                                           [index]['em_phone'],
  //                                                       'em_lat': snapshot
  //                                                               .data!['data']
  //                                                           [index]['em_lat'],
  //                                                       'em_lng': snapshot
  //                                                               .data!['data']
  //                                                           [index]['em_lng'],
  //                                                       'em_location': snapshot
  //                                                                   .data![
  //                                                               'data'][index]
  //                                                           ['em_location'],
  //                                                       'em_type': snapshot
  //                                                               .data!['data']
  //                                                           [index]['em_type'],
  //                                                     }),
  //                                               ),
  //                                             ),
  //                                           ],
  //                                         ),
  //                                       ),