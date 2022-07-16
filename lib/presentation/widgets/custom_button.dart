import 'package:flutter/material.dart';

import '../../domain/all.dart';

class Custbutton extends StatelessWidget {
  final String title;
  final Size size;
  final Function custbutfunc;
  const Custbutton({
    Key? key,
    required this.title,
    required this.size,
    required this.custbutfunc,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      padding: EdgeInsets.symmetric(
        horizontal: title == AppString.statement ? 0 : size.width * 0.12,
      ),
      child: ElevatedButton(
        style: ElevatedButton.styleFrom(
          elevation: 5,
          primary: title == AppString.save
              ? AppColor.butgreen
              : (title == AppString.statement || title == AppString.remove)
                  ? AppColor.butred
                  : AppColor.prim,
        ),
        onPressed: () {
          custbutfunc();
        },
        child: Container(
          alignment: Alignment.center,
          width: double.infinity,
          padding: EdgeInsets.symmetric(vertical: size.height * 0.015),
          child: Text(
            title,
            style: TextStyle(fontSize: size.width * 0.05),
          ),
        ),
      ),
    );
  }
}
