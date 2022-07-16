import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';

import '../../domain/all.dart';

class ClosingAmountWid extends StatelessWidget {
  final Size size;
  final Stream<DatabaseEvent> api;
  const ClosingAmountWid({
    Key? key,
    required this.size,
    required this.api,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return StreamBuilder<DatabaseEvent>(
      stream: api,
      builder: (BuildContext context, AsyncSnapshot<DatabaseEvent> snap) {
        double amount = 00.00;
        if (snap.connectionState == ConnectionState.waiting) {
          return Text(
            amount.toString(),
            style: TextStyle(
              color: AppColor.butgreen,
              fontSize: size.width * 0.07,
              fontWeight: FontWeight.bold,
            ),
            maxLines: 1,
          );
        } else if (snap.data != null &&
            snap.hasData &&
            snap.data!.snapshot.value != null) {
          amount = double.parse(snap.data!.snapshot.value! as String);
          return Text(
            amount.toString(),
            style: TextStyle(
              color: amount < 0 ? AppColor.butred : AppColor.butgreen,
              fontSize: size.width * 0.07,
              fontWeight: FontWeight.bold,
            ),
            maxLines: 1,
          );
        } else {
          return Text(
            amount.toString(),
            style: TextStyle(
              color: AppColor.butgreen,
              fontSize: size.width * 0.07,
              fontWeight: FontWeight.bold,
            ),
            maxLines: 1,
          );
        }
      },
    );
  }
}
