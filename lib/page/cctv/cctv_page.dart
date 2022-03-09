import 'package:cctv_tun/page/global/style/global.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:webview_flutter/webview_flutter.dart';

class cctv_page extends StatefulWidget {
  cctv_page({Key? key}) : super(key: key);

  @override
  _cctv_pageState createState() => _cctv_pageState();
}

class _cctv_pageState extends State<cctv_page> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        iconTheme: IconThemeData(
          color: ThemeBc.app_white_color, //change your color here
        ),
        foregroundColor: ThemeBc.app_white_color,
        backgroundColor: ThemeBc.app_theme_color,
        title: Column(
          children: [
            Center(
                child: Text(
              'CCTV',
              style: GoogleFonts.sarabun(
                textStyle: TextStyle(
                  color: ThemeBc.app_textwhite_color,
                  fontWeight: FontWeight.bold,
                  fontSize: 18,
                ),
              ),
            )),
          ],
        ),
        actions: <Widget>[
          IconButton(
            icon: Icon(
              Icons.refresh,
              color: ThemeBc.app_linear_on,
            ),
            tooltip: 'Show Snackbar',
            onPressed: () {},
          ),
        ],
      ),
      body: WebView(
        javascriptMode: JavascriptMode.unrestricted,
        initialUrl:
            'http://113.53.239.193/cctvmon/mobileapp/cctv.php?prov=%E0%B9%80%E0%B8%A5%E0%B8%A2&site=MKM01',
      ),
    );
  }
}
