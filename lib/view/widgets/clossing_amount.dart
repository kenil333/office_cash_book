import 'package:flutter/material.dart';

import './../../controller/common/all.dart';

class ClosingAmountWid extends StatelessWidget {
  final Size size;
  final Stream api;
  const ClosingAmountWid({
    Key? key,
    required this.size,
    required this.api,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return StreamBuilder(
      stream: api,
      builder: (BuildContext context, AsyncSnapshot<dynamic> snap) {
        double _amount = 00.00;
        if (snap.connectionState == ConnectionState.waiting) {
          return Text(
            _amount.toString(),
            style: TextStyle(
              color: butgreen,
              fontSize: size.width * 0.07,
              fontWeight: FontWeight.bold,
            ),
            maxLines: 1,
          );
        } else if (snap.hasData || snap.data.snapshot.value != null) {
          _amount = double.parse(snap.data.snapshot.value);
          return Text(
            _amount.toString(),
            style: TextStyle(
              color: _amount < 0 ? butred : butgreen,
              fontSize: size.width * 0.07,
              fontWeight: FontWeight.bold,
            ),
            maxLines: 1,
          );
        } else {
          return Text(
            _amount.toString(),
            style: TextStyle(
              color: butgreen,
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
