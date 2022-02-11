import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

int currentIndex = 0;
double defaultMargin = 24.0;

double defaultMargin1 = 24.0;

Color primaryColor = Color(0xff5F59E1);
Color secondaryColor = Color(0xff38ABBE);
Color backgroundColor1 = Color(0xffff4081);
Color backgroundColor2 = Color(0xffff9100);
Color backgroundColor3 = Color(0xffffe0b2);
Color primaryTextColor = Color(0xff111111);
Color secondaryTextColor = Color(0xffFFFFFF);
Color buttonGreyColor = Color(0xffffa726);
Color transparentColor = Colors.transparent;
Color transparentColor1 = Colors.orange;
Color COLOR_BLACK = Colors.black;
Color COLOR_ORANGE = Color(0xff111111);
Color COLOR_GREY = Color(0xffFFFFFF);
Color COLOR_WHITE = Color(0xffffa726);
Color COLOR_GREEN = Color(0xffffa726);

TextTheme defaultText = TextTheme(
    headline1: GoogleFonts.nunito(
  fontWeight: FontWeight.bold,
));
// loading() {
//   return Container(
//     child: Center(
//       child: Column(children: [
//         SizedBox(
//           height: 10,
//         ),
//         CircularProgressIndicator(),
//         SizedBox(
//           height: 10,
//         ),
//         Text(
//           "กำลังโหลด...",
//           style: TextStyle(color: ThemeBc.white),
//         )
//       ]),
//     ),
//   );
// }
// TextStyle primaryTextStyle = GoogleFonts.poppins(
//   color: primaryTextColor,
// );

TextStyle secondaryTextStyle = GoogleFonts.poppins(
  color: secondaryTextColor,
);

TextStyle whiteTextStyle1 = GoogleFonts.poppins(color: backgroundColor1);

//appBar
class ThemeBc {
  static const orange = Colors.orangeAccent;
  static const pinkAccent = Colors.pinkAccent;
  static const whiteBg = Color(0xFFFFF9EC);
  static const white = Color(0xffF1EFE3);
  static const black = Color(0xff1B2836);
  static const green = Color(0xff02d667);
  static const greens = Colors.green;
  static const background = Color(0xff1B2836);
  static const text = Color(0xffF1EFE3);
}

TextStyle primaryTextStyle = GoogleFonts.poppins(
  color: ThemeBc.background,
);
//bg
// const whiteBg = Color(0xFFFFF9EC);
// const white = Color(0xffF1EFE3);
// const black = Color(0xff1B2836);
// const green = Color(0xff02d667);
// const greens = Colors.green;

// Color primaryColor = Color(0xff5F59E1);
// Color secondaryColor = Color(0xff38ABBE);
// Color backgroundColor1 = Color(0xff9c27b0);
// Color backgroundColor3 = Color(0xff388e3c);
// Color backgroundColor2 = Color(0xffffe0b2);
// Color primaryTextColor = Color(0xff111111);
// Color secondaryTextColor = Color(0xffFFFFFF);
// Color buttonGreyColor = Color(0xffffa726);
// Color transparentColor = Colors.transparent;
// Color transparentColor1 = Colors.orange;

// TextStyle primaryTextStyle = GoogleFonts.poppins(
//   color: primaryTextColor,
// );

// TextStyle secondaryTextStyle = GoogleFonts.poppins(
//   color: secondaryTextColor,
// );

TextStyle whiteTextStyle = GoogleFonts.poppins(color: ThemeBc.white);

FontWeight light = FontWeight.w300;
FontWeight regular = FontWeight.w400;
FontWeight medium1 = FontWeight.w500;
FontWeight semiBold = FontWeight.w600;
FontWeight bold = FontWeight.w700;

FontWeight medium = FontWeight.w500;

//new

class LightColors {
  static const Color kLightYellow = Color(0xFFFFF9EC);
  static const Color kLightYellow2 = Color(0xFFFFE4C7);
  static const Color kDarkYellow = Color(0xFFF9BE7C);
  static const Color kPalePink = Color(0xFFFED4D6);

  static const Color kRed = Color(0xFFE46472);
  static const Color kLavender = Color(0xFFD5E4FE);
  static const Color kBlue = Color(0xFF6488E4);
  static const Color kLightGreen = Color(0xFFD9E6DC);
  static const Color kGreen = Color(0xFF309397);

  static const Color kDarkBlue = Color(0xFF0D253F);
}

class AppTheme {
  AppTheme._();

  static const Color notWhite = Color(0xFFEDF0F2);
  static const Color nearlyWhite = Color(0xFFFEFEFE);
  static const Color white = Color(0xFFFFFFFF);
  static const Color nearlyBlack = Color(0xFF213333);
  static const Color grey = Color(0xFF3A5160);
  static const Color dark_grey = Color(0xFF313A44);

  static const Color darkText = Color(0xFF253840);
  static const Color darkerText = Color(0xFF17262A);
  static const Color lightText = Color(0xFF4A6572);
  static const Color deactivatedText = Color(0xFF767676);
  static const Color dismissibleBackground = Color(0xFF364A54);
  static const Color chipBackground = Color(0xFFEEF1F3);
  static const Color spacer = Color(0xFFF2F2F2);
  static const String fontName = 'WorkSans';

  static const TextTheme textTheme = TextTheme(
    headline4: display1,
    headline5: headline,
    headline6: title,
    subtitle2: subtitle,
    bodyText2: body2,
    bodyText1: body1,
    caption: caption,
  );

  static const TextStyle display1 = TextStyle(
    // h4 -> display1
    fontFamily: fontName,
    fontWeight: FontWeight.bold,
    fontSize: 36,
    letterSpacing: 0.4,
    height: 0.9,
    color: darkerText,
  );

  static const TextStyle headline = TextStyle(
    // h5 -> headline
    fontFamily: fontName,
    fontWeight: FontWeight.bold,
    fontSize: 24,
    letterSpacing: 0.27,
    color: darkerText,
  );

  static const TextStyle title = TextStyle(
    // h6 -> title
    fontFamily: fontName,
    fontWeight: FontWeight.bold,
    fontSize: 16,
    letterSpacing: 0.18,
    color: darkerText,
  );

  static const TextStyle subtitle = TextStyle(
    // subtitle2 -> subtitle
    fontFamily: fontName,
    fontWeight: FontWeight.w400,
    fontSize: 14,
    letterSpacing: -0.04,
    color: darkText,
  );

  static const TextStyle body2 = TextStyle(
    // body1 -> body2
    fontFamily: fontName,
    fontWeight: FontWeight.w400,
    fontSize: 14,
    letterSpacing: 0.2,
    color: darkText,
  );

  static const TextStyle body1 = TextStyle(
    // body2 -> body1
    fontFamily: fontName,
    fontWeight: FontWeight.w400,
    fontSize: 16,
    letterSpacing: -0.05,
    color: darkText,
  );

  static const TextStyle caption = TextStyle(
    // Caption -> caption
    fontFamily: fontName,
    fontWeight: FontWeight.w400,
    fontSize: 12,
    letterSpacing: 0.2,
    color: lightText, // was lightText
  );
}
