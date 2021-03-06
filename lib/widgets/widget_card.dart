import 'package:cctv_tun/page/global/style/global.dart';

import 'package:flutter/material.dart';

class WidgetBalanceCard extends StatelessWidget {
  final String currentBalance;
  final String image;

  WidgetBalanceCard({
    Key? key,
    required this.currentBalance,
    required this.image,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 350,
      height: 190,
      padding: EdgeInsets.symmetric(
        horizontal: defaultMargin,
        vertical: 30,
      ),
      decoration: BoxDecoration(
        image: DecorationImage(
          image: AssetImage(
            image,
          ),
        ),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            '',
            style: whiteTextStyle.copyWith(
              fontSize: 13,
              fontWeight: medium,
            ),
          ),
          Text(
            currentBalance,
            style: whiteTextStyle.copyWith(
              fontSize: 28,
              fontWeight: semiBold,
            ),
          ),
          SizedBox(height: 40),
          Text(
            '',
            style: whiteTextStyle.copyWith(
              fontSize: 16,
              fontWeight: regular,
            ),
          ),
        ],
      ),
    );
  }
}
