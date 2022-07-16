import 'package:flutter/material.dart';

import '../../domain/all.dart';

class PersonWid extends StatelessWidget {
  final Size size;
  final String name;
  final String number;
  final Function persofunc;
  const PersonWid({
    Key? key,
    required this.size,
    required this.name,
    required this.number,
    required this.persofunc,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onLongPress: () {
        persofunc();
      },
      child: Container(
        width: double.infinity,
        margin: EdgeInsets.symmetric(
          horizontal: size.width * 0.03,
          vertical: 10,
        ),
        padding: EdgeInsets.symmetric(
          horizontal: size.width * 0.06,
          vertical: 15,
        ),
        decoration: ConstDecoration.containerdeco,
        child: Column(
          children: [
            Text(
              name,
              style: TextStyle(
                color: AppColor.txtcol,
                fontSize: size.width * 0.055,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 5),
            Text(
              "+91 $number",
              style: TextStyle(
                color: AppColor.txtcol,
                fontSize: size.width * 0.045,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
