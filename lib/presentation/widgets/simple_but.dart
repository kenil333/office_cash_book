import 'package:flutter/material.dart';

import '../../domain/all.dart';

class SimpleBut extends StatelessWidget {
  final Size size;
  final IconData icon;
  final String title;
  final Function butfunc;
  const SimpleBut({
    Key? key,
    required this.size,
    required this.icon,
    required this.title,
    required this.butfunc,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(vertical: 8),
      child: InkWell(
        onTap: () {
          butfunc();
        },
        child: Row(
          children: [
            Icon(
              icon,
              color: AppColor.txtcol,
              size: size.width * 0.08,
            ),
            const SizedBox(width: 20),
            Text(
              title,
              style: TextStyle(
                fontSize: size.width * 0.055,
                color: AppColor.txtcol,
                fontWeight: FontWeight.w400,
              ),
            ),
            Expanded(
                child: Container(
              alignment: Alignment.centerRight,
              child: Icon(
                Icons.arrow_forward_ios,
                color: AppColor.txtcol,
                size: size.width * 0.06,
              ),
            ))
          ],
        ),
      ),
    );
  }
}
