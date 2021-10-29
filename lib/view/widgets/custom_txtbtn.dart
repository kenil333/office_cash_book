import 'package:flutter/material.dart';

import './../../controller/common/all.dart';

class Customtxtbut extends StatelessWidget {
  final Size size;
  final String title;
  final Function txtfunc;
  final AlignmentGeometry align;
  const Customtxtbut({
    Key? key,
    required this.size,
    required this.title,
    required this.txtfunc,
    required this.align,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      padding: EdgeInsets.symmetric(
        horizontal: size.width * 0.06,
        vertical: size.height * 0.005,
      ),
      alignment: align,
      child: TextButton(
        onPressed: () {
          txtfunc();
        },
        child: Text(
          title,
          style: TextStyle(
            color: txtcol,
            fontSize: size.width * 0.035,
            letterSpacing: 1.4,
          ),
        ),
      ),
    );
  }
}
