import 'package:flutter/material.dart';

import './../../controller/common/all.dart';

class BalanceWid extends StatelessWidget {
  final Size size;
  final String title;
  final String amount;
  const BalanceWid({
    Key? key,
    required this.size,
    required this.title,
    required this.amount,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.symmetric(
        horizontal: size.width * 0.08,
        vertical: size.height * 0.02,
      ),
      padding: EdgeInsets.symmetric(
        horizontal: size.width * 0.06,
        vertical: 10,
      ),
      height: size.height * 0.15,
      width: double.infinity,
      decoration: containerdeco,
      child: Column(
        children: [
          Expanded(
            child: Container(
              alignment: Alignment.centerLeft,
              child: Text(
                title,
                style: TextStyle(
                  fontSize: size.width * 0.05,
                  color: prim,
                ),
              ),
            ),
          ),
          Expanded(
            child: Container(
              alignment: Alignment.centerRight,
              child: Text(
                amount,
                style: TextStyle(
                  color: title == debit ? butred : butgreen,
                  fontSize: size.width * 0.07,
                  fontWeight: FontWeight.bold,
                ),
                maxLines: 1,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
