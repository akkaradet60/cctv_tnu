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
          color: ThemeBc.white, //change your color here
        ),
        foregroundColor: ThemeBc.white,
        backgroundColor: ThemeBc.background,
        title: Column(
          children: [
            Center(
                child: Text(
              'CCTV',
              style: GoogleFonts.sarabun(
                textStyle: TextStyle(
                  color: ThemeBc.textwhite,
                  fontWeight: FontWeight.bold,
                  fontSize: 18,
                ),
              ),
            )),
          ],
        ),
        actions: <Widget>[
          IconButton(
            icon: Image.asset('assets/logo.png', scale: 15),
            tooltip: 'Show Snackbar',
            onPressed: () {
              ScaffoldMessenger.of(context).showSnackBar(
                  const SnackBar(content: Text('เราเทศบาลตำบลพระลับ')));
            },
          ),
        ],
      ),
      body: WebView(
        javascriptMode: JavascriptMode.unrestricted,
        initialUrl: 'https://www.ntplc.co.th/News/news17',
      ),
    );
  }
}
